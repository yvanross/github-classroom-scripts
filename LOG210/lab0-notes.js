/**
 * This script browses all repositories contained at the given path and "runs" them to automatically generate the
 * associated grade. The first argument is the path (either absolute or relative) to the folder containing said
 * repositories, the second argument is optional and is the number of repositories to process in parallel.
 *
 * Three files are outputted, one text file that follows the format of the bash version of this script, one with a
 * prettier format (JSON) and extra information, and a file containing error details for each repository processing
 * that raised an error.
 *
 * Even though multiple repositories can be processed in parallel, the process is quite slow. This slowness mostly
 * comes from the fact that we have to run "npm install" on each individual repository. By installing the needed
 * modules globally once and skipping the "npm install" part, we could dramatically increase this script's speed
 * (and save disk space).
 *
 * Unless you have a fast CPU with multiple cores and, most importantly, a fast drive (Sata-SSD or even NVMe-SSD),
 * you'll experience lower performance using bigger batches. Also, since Jest tries its best to run its tests in
 * parallel, it may be faster to simply process one repo at a time (default).
 *
 * @author Ruben Tordjman <ruben.tordjman.1@ens.etsmtl.ca>
 */

const fs = require("fs/promises")
const child_process = require("child_process")
const { join } = require("path")
const { EOL } = require("os")

const NAME_RE = /\<nomComplet1\>(.*)\<\/nomComplet1\>/
const MOODLE_RE = /\<codeMoodle1\>([a-zA-Z]{2}\d{5})\<\/codeMoodle1\>/ // Matches the AA0000 format
const ERROR_FILE = "processing_errors.json" // A JSON file containing error details for each student's grade processing
const errors = {} // Contains error details for each student's grade processing

// File in which students should write their experience with lazy teammates
const PARASITE_FILE = "docs/experience-parasites-mollassons.md"
const PARASITE_BASE_WORD_COUNT = 115 // The number of words present in the file before students write anything

const STUDENT_INFO_FILE = "docs/Squelette.md" // File in which to find the student's name and moodle code
const TXT_OUTPUT_FILE = "S20211-LAB0.txt" // Name of the file containing all grades
const JSON_OUTPUT_FILE = "S20211-LAB0.json" // Same as output file, but in JSON so its easier to read and parse
const REPORT_FILE = "report_test_stats.json" // Name of thje file containing the test report

const PARALLEL_PROCESSINGS = parseInt(process.argv[3]) || 1 // Number of repos to process at the same time
const REPOS_PATH = process.argv[2]

if (REPOS_PATH === undefined) {
    console.log("Missing or invalid repositories path")
    console.log(`Usage: node lab0-notes.js path/to/all/repos [nbParallelProcessings]`)
    process.exit()
}

/**
 * A dataclass made to store data related to a student evaluation
 */
class StudentEvaluation {
    moodleCode = "Code vide"
    labName = "Lab #0 Remise"
    percentSuccess = 0
    studentName = "Nom vide"
    dirName = ""
    nbTests = 0
    nbFailedTests = 0
    nbPassedTests = 0
    nbParasiteWords = 0 // Number of new words in the "parasite et mollasson" text

    constructor() {
        // Nothing to initialize, StudentEvaluation is a dataclass
    }

    toString() {
        return `${this.moodleCode};${this.labName};${this.percentSuccess};${this.studentName}` +
        `;${this.dirName};${this.nbTests};${this.nbFailedTests};${this.nbPassedTests}`
    }
}

async function main() {
    console.log(`Looking for repos in: ${REPOS_PATH}`)
    const repos = await fs.readdir(REPOS_PATH)
    let nbBatches = Math.ceil(repos.length / PARALLEL_PROCESSINGS)
    console.log(`Running ${nbBatches} batche(s) of repository processing`)

    const results = []
    for (let i = 0; i < nbBatches; i++) {
        console.log(`Running batch ${i + 1}/${nbBatches}`)
        const res = repos.splice(0, PARALLEL_PROCESSINGS).map(processRepo)
        const evaluations = await Promise.allSettled(res)
        results.push(...evaluations)
    }

    await outputResults(results, TXT_OUTPUT_FILE, JSON_OUTPUT_FILE, ERROR_FILE)
}

/**
 * Promisifies the "exec" function from child_process
 * @param {String} command the command to run
 * @returns a Promise of the process' stdout (a string)
 */
async function exec(command, options) {
    return new Promise((resolve, reject) => {
        child_process.exec(command, options, (error, stdout, stderr) => {
            if (error) { reject(error) }
            else { resolve(stdout) }
        })
    })
}

/**
 * Processes the given repository, installing npm modules (npm install) and running tests.
 * @param {String} dirName the path of the repository to process
 * @returns a StudentEvaluation for the given dirName
 */
async function processRepo(dirName) {
    const studentEval = new StudentEvaluation()
    studentEval.dirName = dirName

    const repoPath = join(REPOS_PATH, dirName)
    await fillStudentInfo(studentEval, repoPath)

    try {
        await exec("npm install", {cwd: repoPath})
    } catch (error) {
        console.log(`Error caught while running "npm install" on ${dirName}`)
        errors[dirName] = `${error}`.split("\n")
        return studentEval
    }

    try {
        await exec("npm run testj", {cwd: repoPath})
    } catch (error) {
        console.log(`Error caught while running "npm run testj" on ${dirName}`)
        errors[dirName] = `${error}`.split("\n")
    }

    // We could directly parse the output of the command instead of printing it to a file then reading it, but
    // it's less reliable
    const reportFile = join(repoPath, REPORT_FILE)
    const report = require(reportFile)

    studentEval.nbTests = report.numTotalTests
    studentEval.nbFailedTests = report.numFailedTests
    studentEval.nbPassedTests = report.numPassedTests

    const successRate = studentEval.nbPassedTests / Math.max(studentEval.nbTests, 1)
    studentEval.percentSuccess = Math.trunc(successRate * 100)

    studentEval.nbParasiteWords = (await getWordCount(repoPath, PARASITE_FILE)) - PARASITE_BASE_WORD_COUNT
    return studentEval;
}

/**
 * Reads file containing the student's information in `repoPath` and fills the given `studentEval` with its name and
 * moodle code.
 * @param {StudentEvaluation} studentEval the StudentEvaluation to fill
 * @param {String} repoPath the path on disk of the student's repository
 */
async function fillStudentInfo(studentEval, repoPath) {
    let infoFilePath = join(repoPath, STUDENT_INFO_FILE)
    try {
        var fileContent = await fs.readFile(infoFilePath, {encoding: "utf-8"})
    } catch (error) { // Trying an alternate path
        // TODO: Remove this check and instruct students to leave this file in its initial directory
        infoFilePath = join(repoPath, STUDENT_INFO_FILE.split("/")[1])
        fileContent = await fs.readFile(infoFilePath, {encoding: "utf-8"})
        console.log(`Found ${studentEval.dirName} info file at repository's root instead of ${STUDENT_INFO_FILE}`)
    }

    const name = fileContent.match(NAME_RE)[1].trim()
    if (name !==null && !name.includes("Entrer")) {
        studentEval.studentName = name
    }

    let moodleCode = fileContent.match(MOODLE_RE)
    if (moodleCode !== null) { // Some students forget to fill their moodle code, meaning there's no match
        moodleCode = moodleCode[1]
        if (!moodleCode.includes("Entrer")) {
            studentEval.moodleCode = moodleCode.toUpperCase() // Ensures the AA00000 format
        }
    }
}

/**
 * Parses the processing results, format the StudentEvaluations and outputs them in the output file
 * @param {(PromiseRejectedResult | PromiseFulfilledResult<StudentEvaluation>)[]} results
 * @param {String} outputFile the file to output results to
 * @param {String} jsonOutput the file to pretty-print results to
 * @param {String} errorFile the file to output error details to
 */
async function outputResults(results, outputFile, jsonOutput, errorFile) {
    let output = ""
    const studentEvals = []
    for (const res of results) {
        if (res.status === "fulfilled") {
            const studentEval = res.value
            output += `${studentEval.toString()}${EOL}`
            studentEvals.push(studentEval)
        } else {
            console.log("Got miss", res.reason)
        }
    }

    await fs.writeFile(outputFile, output)
    await fs.writeFile(jsonOutput, JSON.stringify(studentEvals, null, 4))
    await fs.writeFile(errorFile, JSON.stringify(errors, null, 4))
}

/**
 * @param {String} repoPath the path on disk of the student's repository
 * @param {String} fileName the name of the file to count words from (or a path relative to `repoPath`)
 * @returns the number of words contained in `fileName`
 */
async function getWordCount(repoPath, fileName) {
    const parasiteFilePath = join(repoPath, fileName)
    const content = await fs.readFile(parasiteFilePath, {encoding: "utf-8"})
    return content.split(/\s+/).length // Splits on sequences of 1 or more whitespaces
}

main()


import SwiftCLI

let cli = CLI(
    name: "coherent-swift",
    version: "0.1.0",
    description: "A command-line tool to analyze and report Swift code cohesion"
)

cli.commands = [
    Report()
]

cli.globalOptions.append(VerboseFlag)

_ = cli.go()

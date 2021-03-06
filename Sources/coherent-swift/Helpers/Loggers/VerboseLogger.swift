//
//  coherent-swift
//
//  Created by Arthur Alves on 05/05/2020.
//

import SwiftCLI
import Foundation

let VerboseFlag = Flag("-v", "--verbose", description: "Log tech details for nerds")

public enum ShellColor: String {
    case blue = "\\033[0;34m"
    case red = "\\033[0;31m"
    case green = "\\033[0;32m"
    case cyan = "\\033[0;36m"
    case purple = "\\033[0;35m"
    case ios = "\\033[0;49;36m"
    case android = "\\033[0;49;33m"
    case neutral = "\\033[0m"
    
    func bold() -> String {
        return self.rawValue.replacingOccurrences(of: "[0", with: "[1")
    }
}

public enum LogLevel: String {
    case info = "INFO  "
    case warning = "WARN  "
    case verbose = "DEBUG "
    case error = "ERROR "
    case none = "     "
}

public protocol VerboseLogger {
    var verbose: Bool { get }
    func log(_ prefix: Any, item: Any, indentationLevel: Int, color: ShellColor, logLevel: LogLevel)
}

extension VerboseLogger {
    public var verbose: Bool { VerboseFlag.value }
    
    public func log(_ prefix: Any = "", item: Any, indentationLevel: Int = 0, color: ShellColor = .neutral, logLevel: LogLevel = .none) {
        if logLevel == .verbose {
            guard verbose else { return }
        }
        let indentation = String(repeating: "   ", count: indentationLevel)
        var command = ""
        let arguments =  [
            "\(logLevel.rawValue)",
            "[\(Date().logTimestamp())]: ▸ ",
            "\(indentation)",
            "\(color.bold())\(prefix)",
            "\(color.rawValue)\(item)\(ShellColor.neutral.rawValue)"
        ]
        arguments.forEach { command.append($0) }
        try? Task.run("printf", command+"\n")
    }
}


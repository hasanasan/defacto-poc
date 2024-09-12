//
//  Logger.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import CocoaLumberjackSwift
import Foundation

// MARK: - LogLevel -

enum LogLevel: Int, CustomStringConvertible {
    case verbose = 0
    case debug
    case info
    case warning
    case error

    // MARK: - Internal -

    var description: String {
        switch self {
        case .verbose:
            return "Verbose"
        case .debug:
            return "Debug"
        case .info:
            return "Info"
        case .warning:
            return "Warning"
        case .error:
            return "Error"
        }
    }
}

// MARK: - LogMessage -

struct LogMessage: CustomStringConvertible {
    let level: LogLevel
    let message: String

    let file: String
    let function: String
    let line: Int

    var description: String {
        "\(file) [\(function):\(line)] \(level.description): \(message)"
    }
}

// MARK: - Logger -

final class Logger {
    // MARK: - Lifecycle -

    init(logLevel: LogLevel = .debug) {
        self.logLevel = logLevel
    }

    // MARK: - Internal -

    var logLevel: LogLevel

    func setLogLevel(_ logLevel: LogLevel) {
        self.logLevel = logLevel
    }

    func log(level: LogLevel, message: String, file: String = #file, function: String = #function, line: Int = #line) {
        guard level.rawValue >= logLevel.rawValue else {
            return
        }

        let message = LogMessage(level: level,
                                 message: message,
                                 file: shortenFileName(file),
                                 function: String(describing: function),
                                 line: line)

        switch level {
        case .verbose:
            DDLogVerbose(message.description)
        case .debug:
            DDLogDebug(message.description)
        case .info:
            DDLogInfo(message.description)
        case .warning:
            DDLogWarn(message.description)
        case .error:
            DDLogError(message.description)
        }
    }

    func verbose(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(level: .verbose, message: message, file: file, function: function, line: line)
    }

    func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(level: .debug, message: message, file: file, function: function, line: line)
    }

    func info(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(level: .info, message: message, file: file, function: function, line: line)
    }

    func warn(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(level: .warning, message: message, file: file, function: function, line: line)
    }

    func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(level: .error, message: message, file: file, function: function, line: line)
    }

    // MARK: - Private -

    private func shortenFileName(_ fileName: String) -> String {
        var str = String(describing: fileName)
        if let range = str.range(of: "/", options: .backwards) {
            let index = range.upperBound
            str = String(str[index...])
        }
        if let range = str.range(of: ".", options: .backwards) {
            let index = range.upperBound
            str = String(str[..<index])
        }
        return str
    }
}

[![swift-version](https://img.shields.io/badge/swift-5.7-brightgreen.svg)](https://github.com/apple/swift)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
![GitHub Workflow Status (branch)](https://img.shields.io/github/workflow/status/adessoTurkey/ios-boilerplate/iOS%20Build%20Check%20Workflow/develop)


============================

This is the  app created by Adesso Turkey.

Table of Contents
-----------------

- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Workspace Preparing](#workspace-preparing)
- [List of Frameworks](#list-of-frameworks)
- [License](#license)

## Prerequisites

- [MacOS Big Sur (11.5 or higher)](https://support.apple.com/kb/SP777)
- [Xcode 13 or higher](https://developer.apple.com/download/) ~ Swift 5.x
- Swiftlint - To Install SwiftLint, please check Swiftlint Installation section from read me file 
- SwiftFormat - To Install SwiftFormat, please check SwiftFormat Installation section from read me file 

## Swiftlint Installation 

- On the directory of `{project_root}/scripts/installation`, via terminal
    - run `sh swiftlint.sh` to install brew (if necessary) and swiftlint.

## SwiftFormat Installation 

- On the directory of `{project_root}/scripts/installation`, via terminal
    - run `sh swiftformat.sh` to install brew (if necessary) and swiftformat.

## Project Structure

| Name | Description |
| --- | --- |
| **Application/Services**/ | Application based services will be defined here, such as logging, network, server... |
| **Configs**/ | Everything relative to build and environment configuration will be defined here |
| **Managers**/ | Managers will be put here such as LoggerManager, UtilityManager... |
| **Network**/ | Network related implementations will be defined here. You can find network related developments under feature/adesso-network branch. If you want to use it, you can merge it to develop easily. |
| **Scenes**/ | Application related scenes will be defined here, such as navigation viewcontrollers, storyboards... |
| **Utility**/ | Extensions, final classes etc. will be put here  |
| **Resources**/ | Images, icons, assets, fonts, Mocks, `Localizable.strings`... 

## Workspace Preparing

- On the directory of `{project_root}/scripts/installation`, via terminal
    - run `./rename-project.swift "$NEW_PROJECT_NAME"` to change project name.
    - run `sh install-githooks.sh` to install git-hooks into your project. Includes following git hooks; Git hooks include SwiftLint validation, git message character limitation and issue-id check
        - pre-commit: This hook provides swiftlint control to detect errors quickly before commit.
        - commit-msg: This hook checks that messages must have a minimum 50 characters. It also tells it should contain an issue tag. Ticket id must be between square brackets and [ticketid] separated by hyphens. See example: "[ISSUE-123] commit message" or "[JIRA-56] - commit message"
    

## List of Frameworks

| Framework | Description |
| ------------------------------- | --------------------------------------------------------------------- |
| [SwiftLint](https://github.com/realm/SwiftLint) | A tool to enforce Swift style and conventions. |
| [Pulse](https://github.com/kean/Pulse) | Pulse is a powerful logging system for Apple Platforms. Native. Built with SwiftUI. |
| [CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack) | Powerful & flexible logging framework. |
| [Alamofire](https://github.com/Alamofire/Alamofire) | Alamofire is an HTTP networking library written in Swift. |
| [Kingfisher](https://github.com/onevcat/Kingfisher) | Kingfisher is a powerful, pure-Swift library for downloading and caching images from the web. |
| [SnapKit](https://github.com/SnapKit/SnapKit) | SnapKit is a DSL to make Auto Layout easy on both iOS and OS X. |
| [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD) | SVProgressHUD is a clean and easy-to-use HUD meant to display the progress of an ongoing task on iOS and tvOS. |
| [Cosmos](https://github.com/evgenyneu/Cosmos) | Cosmos is a UI control for iOS and tvOS written in Swift |
| [CHIPageControl](https://github.com/ChiliLabs/CHIPageControl) | CHIPageControl is a set of cool animated page controls. |

## Useful Tools and Resources

- [SwiftLint](https://github.com/realm/SwiftLint) - A tool to enforce Swift style and conventions.
- [SwiftFormat](https://github.com/nicklockwood/SwiftFormat) - SwiftFormat is a code library and command-line tool for reformatting Swift code on macOS, Linux or Windows.
- [TestFlight](https://help.apple.com/itunes-connect/developer/#/devdc42b26b8) - TestFlight beta testing lets you distribute beta builds of your app to testers and collect feedback.
- [Appcenter](https://appcenter.ms/) - Continuously build, test, release, and monitor apps for every platform.

## License

```
Copyright 2020 adesso Turkey

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
//
//  LoggingService.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import UIKit

class LoggingService: NSObject, UIApplicationDelegate {
    // MARK: - Internal -

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LoggerManager.instance.setup(level: .debug)
        logApplicationAndDeviceInfo()

        return true
    }

    // MARK: - Private -

    private func logApplicationAndDeviceInfo() {
        let version = UIApplication.appVersion
        let build = UIApplication.appBuild
        let deviceModel = UIDevice.modelName
        let osVersion = UIDevice.osVersion

        LoggerManager.instance.setInfo(version: version, build: build, deviceModel: deviceModel, osVersion: osVersion)
    }
}

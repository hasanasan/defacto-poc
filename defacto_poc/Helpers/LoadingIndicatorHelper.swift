//
//  LoadingIndicatorHelper.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso. All rights reserved.
//

import SVProgressHUD

enum LoadingIndicatorHelper {
    static func show() {
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
    }

    static func hide() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }

    static func success(status: String?) {
        DispatchQueue.main.async {
            SVProgressHUD.showSuccess(withStatus: status)
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }

    static func error(status: String?) {
        DispatchQueue.main.async {
            SVProgressHUD.showError(withStatus: status)
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
}

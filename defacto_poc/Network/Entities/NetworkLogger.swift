//
//  NetworkLogger.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import Alamofire
import Foundation

class NetworkLogger: EventMonitor {
    let queue = DispatchQueue(label: "com.adesso.defacto")

    func requestDidFinish(_ request: Request) {
        var bodyStr = ""
        if let body = request.request?.httpBody {
            bodyStr = String(data: body, encoding: .utf8) ?? ""
        }

        let message = """
            ---------- 👉 HTTP REQUEST START 👈 ----------
            url: \(request.request?.url?.absoluteString ?? "")
            headers: \(request.request?.allHTTPHeaderFields?.toJSONString ?? "")
            method: \(request.request?.method?.rawValue ?? "")
            body: \(bodyStr)
            ---------- 👉 HTTP REQUEST END 👈 ----------
            """
        Logger().log(level: .debug, message: message)
    }

    func request<Value>(_: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        var message = """
            ---------- 👉 HTTP RESPONSE START 👈 ----------
            status: \(response.response?.statusCode ?? -1)
            url: \(response.response?.url?.absoluteString ?? "")
            headers: \(response.response?.allHeaderFields.toJSONString ?? "")
            data: {{data}}
            error: {{error}}
            ---------- 👉 HTTP RESPONSE END 👈 ----------
            """

        if let data = response.data,
           let json = String(data: data, encoding: .utf8)
        {
            message = message.replacingOccurrences(of: "{{data}}", with: json)
        }

        Logger().log(level: .debug, message: message)
    }
}

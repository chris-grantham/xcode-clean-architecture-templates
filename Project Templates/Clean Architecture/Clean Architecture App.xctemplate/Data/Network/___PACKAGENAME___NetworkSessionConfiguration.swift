// ___FILEHEADER___

import Foundation

/// Value-type configuration for a `NetworkSession`.
///
/// Create environment-specific instances and inject via the `AppContainer`:
/// ```swift
/// private let networkConfig: NetworkSessionConfiguration = appEnvironment.isDebug
///     ? .staging
///     : .production
/// ```
struct ___PACKAGENAME___NetworkSessionConfiguration: Sendable {

    // MARK: - Properties

    var baseURL: URL
    var timeoutInterval: TimeInterval
    var defaultHeaders: [String: String]
    var cachePolicy: URLRequest.CachePolicy

    // MARK: - Static instances

    static let `default` = ___PACKAGENAME___NetworkSessionConfiguration(
        baseURL: URL(string: "https://api.example.com/v1")!,
        timeoutInterval: 30,
        defaultHeaders: [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ],
        cachePolicy: .useProtocolCachePolicy
    )

    // MARK: - Request builder

    func buildRequest(
        path: String,
        method: String = "GET",
        body: Data? = nil,
        headers: [String: String] = [:]
    ) -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        request.httpMethod = method
        request.httpBody = body
        defaultHeaders.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        return request
    }
}

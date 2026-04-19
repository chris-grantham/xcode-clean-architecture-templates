// ___FILEHEADER___

import Foundation

// MARK: - NetworkSessionConfiguration

/// Value-type configuration for a `NetworkSession`.
///
/// Create environment-specific instances (`.staging`, `.production`) and
/// inject via the `AppContainer`. Adapter types use `buildRequest(…)` to
/// construct fully-configured `URLRequest` values without embedding URL
/// construction logic in their fetch methods.
///
/// ```swift
/// // AppContainer
/// let configuration: NetworkSessionConfiguration = appEnvironment.isProduction
///     ? .production
///     : .staging
/// func makeUserAdapter() -> any UserPort {
///     UserAdapter(session: URLSession.shared, configuration: configuration)
/// }
/// ```
struct ___FILEBASENAME___NetworkSessionConfiguration: Sendable {

    // MARK: - Properties

    var baseURL: URL
    var timeoutInterval: TimeInterval
    var defaultHeaders: [String: String]
    var cachePolicy: URLRequest.CachePolicy

    // MARK: - Static instances

    static let `default` = ___FILEBASENAME___NetworkSessionConfiguration(
        baseURL: URL(string: "https://api.example.com/v1")!,
        timeoutInterval: 30,
        defaultHeaders: [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ],
        cachePolicy: .useProtocolCachePolicy
    )

    // MARK: - Request builder

    /// Constructs a fully-configured `URLRequest` for the given path.
    ///
    /// - Parameters:
    ///   - path: Relative path appended to `baseURL` (e.g. `"/users/42"`).
    ///   - method: HTTP method string. Defaults to `"GET"`.
    ///   - body: Optional encoded request body.
    ///   - headers: Per-request headers merged on top of `defaultHeaders`.
    ///              Per-request values take precedence on collision.
    /// - Returns: A configured `URLRequest`.
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

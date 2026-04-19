// ___FILEHEADER___

import Foundation

// MARK: - NetworkSession (Port)

/// Infrastructure boundary for URL-based networking.
///
/// Depend on this protocol in Adapters and test doubles — never on `URLSession` directly.
///
/// ```swift
/// struct MockNetworkSession: NetworkSession {
///     var stubbedData: Data = Data()
///     var stubbedResponse: URLResponse = HTTPURLResponse()
///     func data(for request: URLRequest) async throws -> (Data, URLResponse) {
///         (stubbedData, stubbedResponse)
///     }
/// }
/// ```
protocol NetworkSession: Sendable {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

// MARK: - URLSession conformance

extension URLSession: @retroactive NetworkSession {}

// MARK: - NetworkSession + convenience

extension NetworkSession {

    /// Performs a request and decodes the response body as `T`.
    func decoded<T: Decodable>(
        _ type: T.Type = T.self,
        for request: URLRequest,
        using decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {
        let (data, response) = try await self.data(for: request)
        try validate(response)
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkSessionError.decoding(error)
        }
    }

    private func validate(_ response: URLResponse) throws {
        guard let http = response as? HTTPURLResponse else {
            throw NetworkSessionError.invalidResponse
        }
        guard (200..<300).contains(http.statusCode) else {
            throw NetworkSessionError.statusCode(http.statusCode)
        }
    }
}

// MARK: - NetworkSessionError

enum NetworkSessionError: Error, LocalizedError {
    case invalidResponse
    case statusCode(Int)
    case decoding(Error)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "The server returned an invalid or non-HTTP response."
        case .statusCode(let code):
            return "The server responded with HTTP \(code)."
        case .decoding(let error):
            return "Response decoding failed: \(error.localizedDescription)"
        }
    }
}

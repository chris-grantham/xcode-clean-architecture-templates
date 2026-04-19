// ___FILEHEADER___

import Foundation
import WebKit

// MARK: - WebDataStoreProviding (Port)

/// Domain boundary for WKWebsiteDataStore.
/// Conforming types gain testability without depending on the concrete WebKit API.
@MainActor
protocol WebDataStoreProviding: AnyObject {
    var isPersistent: Bool { get }
    var httpCookieStore: WKHTTPCookieStore { get }
    func removeData(
        ofTypes dataTypes: Set<String>,
        modifiedSince date: Date,
        completionHandler: @escaping () -> Void
    )
}

extension WKWebsiteDataStore: WebDataStoreProviding {}

// MARK: - AppContainer

/// Application-layer dependency container.
///
/// System services use **singleton lifetime** (one instance per container) but
/// **non-singleton access** — callers receive the instance through a factory method,
/// keeping the dependency injection graph explicit and testable.
@MainActor
final class ___FILEBASENAME___AppContainer {

    // MARK: - App-wide state

    let appState: AppState
    let appEnvironment: AppEnvironment

    // MARK: - Init

    init(appState: AppState, appEnvironment: AppEnvironment) {
        self.appState = appState
        self.appEnvironment = appEnvironment
    }

    // MARK: - System service factories

    private lazy var _webDataStore: any WebDataStoreProviding = WKWebsiteDataStore.default()

    /// Returns the default persistent web data store. Replace the lazy initialiser in tests.
    func makeWebDataStore() -> any WebDataStoreProviding { _webDataStore }

    // MARK: - Scoped factories
}

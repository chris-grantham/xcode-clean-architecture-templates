// ___FILEHEADER___

import Foundation
import WebKit

// MARK: - WebDataStoreProviding (Port)

/// Domain boundary for WKWebsiteDataStore. Conform test doubles to this protocol
/// rather than depending on the concrete WebKit API.
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

/// Application-layer dependency container — the composition root for ___PACKAGENAME___.
///
/// System services use **singleton lifetime** (one shared instance per container) but
/// **non-singleton access** — features receive the instance through a factory method,
/// keeping the dependency graph explicit and testable.
@MainActor
final class ___PACKAGENAME___AppContainer {

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

    /// Returns the default persistent web data store for this container.
    func makeWebDataStore() -> any WebDataStoreProviding { _webDataStore }

    // MARK: - Scoped factories
}

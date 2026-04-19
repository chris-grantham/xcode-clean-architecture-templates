// ___FILEHEADER___

import Foundation

/// Application-layer dependency container.
///
/// Owns long-lived state and constructs scoped dependency graphs on demand.
/// Add factory methods below — each factory creates a new object graph rooted
/// at the relevant feature boundary.
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

    // MARK: - Scoped factories
    //
    // Example:
    //   func makeHomeViewModel() -> HomeViewModel {
    //       HomeViewModel(userPort: makeUserRepository(), appState: appState)
    //   }
}

// ___FILEHEADER___

import Foundation

/// Application-layer dependency container — the composition root for ___PACKAGENAME___.
///
/// Owns long-lived state and constructs scoped dependency graphs on demand.
/// Add factory methods below keyed to feature boundaries. Each factory creates
/// a fresh object graph rooted at that boundary; only the services stored as
/// `private lazy var` properties share lifetime with the container.
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

    // MARK: - Scoped factories
    //
    // Example — wire a UserProfile feature:
    //   func makeUserProfileViewModel() -> UserProfileViewModel {
    //       UserProfileViewModel(userPort: makeUserAdapter())
    //   }
    //   private func makeUserAdapter() -> any UserProfilePort {
    //       UserProfileAdapter(session: URLSession.shared, configuration: networkConfig)
    //   }
}

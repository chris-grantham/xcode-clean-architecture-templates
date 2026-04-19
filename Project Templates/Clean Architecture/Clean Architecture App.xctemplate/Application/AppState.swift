// ___FILEHEADER___

import Foundation

/// App-wide observable state, injected into the SwiftUI environment at the root scene.
///
/// Any view in the hierarchy can read this with:
/// ```swift
/// @Environment(AppState.self) private var appState
/// ```
///
/// Mutate from the main actor only — ViewModels should call methods here rather
/// than writing properties directly from async contexts.
@MainActor @Observable
final class AppState {

    // MARK: - Global state
    //
    // Declare properties that need to be accessible across unrelated feature boundaries
    // (e.g. authentication status, deep-link routing, global error banners).
    // Feature-specific state belongs in the feature's ViewModel, not here.
    //
    // Example:
    //   var authenticationState: AuthenticationState = .unauthenticated
    //   var deepLink: DeepLink? = nil
}

// ___FILEHEADER___

import Foundation

/// Immutable environment configuration resolved once at launch and injected
/// into the AppContainer.
///
/// Extend this type with environment-specific values as the app grows —
/// feature flags, API tier selection, analytics configuration, etc.
/// Avoid reaching for `#if DEBUG` inside feature code; check `AppEnvironment`
/// properties instead so behaviour is fully testable.
struct AppEnvironment: Sendable {

    // MARK: - Properties

    let isDebug: Bool

    // MARK: - Static instances

    /// The environment for the running process, resolved from compiler flags.
    static let current = AppEnvironment(
        isDebug: _isDebugAssertConfiguration()
    )

    // MARK: - Testing / Preview helpers

    static let debug = AppEnvironment(isDebug: true)
    static let release = AppEnvironment(isDebug: false)
}

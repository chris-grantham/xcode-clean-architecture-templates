// ___FILEHEADER___

import AVFoundation
import Foundation

// MARK: - AudioSessionProviding (Port)

/// Domain boundary for AVAudioSession.
/// Conforming types gain testability without depending on the concrete AVAudioSession API.
protocol AudioSessionProviding: Sendable {
    var inputNumberOfChannels: Int { get }
    var outputNumberOfChannels: Int { get }
    var outputVolume: Float { get }
    var sampleRate: Double { get }
    func setCategory(
        _ category: AVAudioSession.Category,
        mode: AVAudioSession.Mode,
        options: AVAudioSession.CategoryOptions
    ) throws
    func setActive(_ active: Bool, options: AVAudioSession.SetActiveOptions) throws
}

extension AVAudioSession: AudioSessionProviding {}

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

    private lazy var _audioSession: any AudioSessionProviding = AVAudioSession.sharedInstance()

    /// Returns the shared audio session. Replace the lazy initialiser in tests.
    func makeAudioSession() -> any AudioSessionProviding { _audioSession }

    // MARK: - Scoped factories
}

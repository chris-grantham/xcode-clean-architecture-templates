// ___FILEHEADER___

import AVFoundation
import Foundation

// MARK: - AudioSessionProviding (Port)

/// Domain boundary for AVAudioSession. Conform test doubles to this protocol
/// rather than depending on the concrete AVAudioSession API.
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

    private lazy var _audioSession: any AudioSessionProviding = AVAudioSession.sharedInstance()

    /// Returns the shared audio session for this container.
    /// Replace the lazy initialiser in tests: container._audioSession = MockAudioSession()
    func makeAudioSession() -> any AudioSessionProviding { _audioSession }

    // MARK: - Scoped factories
}

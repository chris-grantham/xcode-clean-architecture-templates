// ___FILEHEADER___

import AVFoundation
import CoreLocation
import Foundation
import WebKit

// MARK: - AudioSessionProviding (Port)

/// Domain boundary for AVAudioSession.
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

// MARK: - LocationProviding (Port)

/// Domain boundary for CLLocationManager.
@MainActor
protocol LocationProviding: AnyObject {
    var authorizationStatus: CLAuthorizationStatus { get }
    var location: CLLocation? { get }
    var distanceFilter: CLLocationDistance { get set }
    var desiredAccuracy: CLLocationAccuracy { get set }
    func requestWhenInUseAuthorization()
    func requestAlwaysAuthorization()
    func startUpdatingLocation()
    func stopUpdatingLocation()
}

extension CLLocationManager: LocationProviding {}

// MARK: - WebDataStoreProviding (Port)

/// Domain boundary for WKWebsiteDataStore.
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

    private lazy var _audioSession: any AudioSessionProviding = AVAudioSession.sharedInstance()
    /// Returns the shared audio session. Replace the lazy initialiser in tests.
    func makeAudioSession() -> any AudioSessionProviding { _audioSession }

    private lazy var _locationManager: any LocationProviding = CLLocationManager()
    /// Returns the shared location manager. Replace the lazy initialiser in tests.
    func makeLocationManager() -> any LocationProviding { _locationManager }

    private lazy var _webDataStore: any WebDataStoreProviding = WKWebsiteDataStore.default()
    /// Returns the default persistent web data store. Replace the lazy initialiser in tests.
    func makeWebDataStore() -> any WebDataStoreProviding { _webDataStore }

    // MARK: - Scoped factories
}

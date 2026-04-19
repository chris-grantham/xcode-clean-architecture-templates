// ___FILEHEADER___

import CoreLocation
import Foundation

// MARK: - LocationProviding (Port)

/// Domain boundary for CLLocationManager. Conform test doubles to this protocol
/// rather than depending on the concrete CoreLocation API.
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

    private lazy var _locationManager: any LocationProviding = CLLocationManager()

    /// Returns the shared location manager for this container.
    func makeLocationManager() -> any LocationProviding { _locationManager }

    // MARK: - Scoped factories
}

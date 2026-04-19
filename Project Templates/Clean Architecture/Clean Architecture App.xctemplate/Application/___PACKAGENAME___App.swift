// ___FILEHEADER___

import SwiftUI

@main
struct ___PACKAGENAME___App: App {

    // AppContainer is the composition root — it owns all long-lived state and
    // produces scoped dependency graphs on demand via make*() factory methods.
    @State private var container = ___PACKAGENAME___AppContainer(
        appState: AppState(),
        appEnvironment: .current
    )

    var body: some Scene {
        WindowGroup {
            ContentView()
                // Inject app-wide state so any view can read it with
                // @Environment(AppState.self) private var appState
                .environment(container.appState)
        }
    }
}

// ___FILEHEADER___

import SwiftUI

/// Root view of the application.
///
/// Keep this thin — it reads from the environment and delegates to
/// feature views. Business logic belongs in ViewModels.
struct ContentView: View {

    @Environment(AppState.self) private var appState

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "building.columns.fill")
                .font(.system(size: 56))
                .foregroundStyle(.blue)
            Text("___PACKAGENAME___")
                .font(.largeTitle.bold())
            Text("Clean Architecture")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environment(AppState())
}

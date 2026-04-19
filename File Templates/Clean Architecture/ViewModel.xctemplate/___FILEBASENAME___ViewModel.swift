// ___FILEHEADER___

import Foundation

/// Presentation-layer ViewModel for the ___FILEBASENAME___ feature.
///
/// Conforms to `@Observable` (iOS 17+ / macOS 14+). All published state is tracked
/// automatically — no `@Published` wrappers needed.
///
/// Usage in a SwiftUI view:
/// ```swift
/// @State private var viewModel = ___FILEBASENAME___ViewModel()
/// ```
@MainActor @Observable
final class ___FILEBASENAME___ViewModel {

    // MARK: - State
    //
    // Declare observable state here. Any property mutation triggers view updates.
    // Example:
    //   var items: [Item] = []
    //   var isLoading: Bool = false
    //   var errorMessage: String? = nil

    // MARK: - Dependencies
    //
    // Inject ports (protocols), never concrete implementations.
    // Example:
    //   private let userPort: any UserPort

    // MARK: - Init

    init() {

    }

    // MARK: - Actions
    //
    // Expose intent-based methods that Views call in response to user interaction.
    // Prefer async throws methods for operations that can fail.
    // Example:
    //   func loadItems() async {
    //       isLoading = true
    //       defer { isLoading = false }
    //       do {
    //           items = try await userPort.fetchAll()
    //       } catch {
    //           errorMessage = error.localizedDescription
    //       }
    //   }
}

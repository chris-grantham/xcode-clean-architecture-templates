// ___FILEHEADER___

import Foundation

// MARK: - ___FILEBASENAME___Port (Domain boundary)

/// Defines the contract that the Domain layer requires from the Data layer.
///
/// The Domain layer depends on this protocol, never on the concrete Adapter.
/// Swap the Adapter implementation (network, cache, in-memory) without touching
/// any domain or presentation code.
protocol ___FILEBASENAME___Port: Sendable {

    /// Fetch a single entity by its identifier.
    func fetch(id: String) async throws -> ___FILEBASENAME___

    /// Fetch all entities, optionally filtered.
    func fetchAll() async throws -> [___FILEBASENAME___]

    /// Persist a new or updated entity.
    func save(_ entity: ___FILEBASENAME___) async throws

    /// Remove an entity by its identifier.
    func delete(id: String) async throws
}

// MARK: - ___FILEBASENAME___Adapter (Data layer implementation)

/// Implements `___FILEBASENAME___Port` using a `NetworkSession`.
///
/// Inject this concrete type at the composition root (AppContainer) and pass
/// only the `any ___FILEBASENAME___Port` existential to domain/presentation code.
final class ___FILEBASENAME___Adapter: ___FILEBASENAME___Port {

    // MARK: - Dependencies

    private let session: any NetworkSession

    // MARK: - Init

    init(session: any NetworkSession) {
        self.session = session
    }

    // MARK: - ___FILEBASENAME___Port

    func fetch(id: String) async throws -> ___FILEBASENAME___ {
        // TODO: build a URLRequest via NetworkSessionConfiguration, call session.data(for:),
        //       validate the response, and decode the result.
        fatalError("___FILEBASENAME___Adapter.fetch(id:) — not yet implemented")
    }

    func fetchAll() async throws -> [___FILEBASENAME___] {
        fatalError("___FILEBASENAME___Adapter.fetchAll() — not yet implemented")
    }

    func save(_ entity: ___FILEBASENAME___) async throws {
        fatalError("___FILEBASENAME___Adapter.save(_:) — not yet implemented")
    }

    func delete(id: String) async throws {
        fatalError("___FILEBASENAME___Adapter.delete(id:) — not yet implemented")
    }
}

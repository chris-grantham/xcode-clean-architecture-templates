#!/usr/bin/env bash
# scaffold_feature.sh — Generate clean-architecture boilerplate for a new feature.
#
# Called by the project Makefile — do not invoke directly unless you pass the arg.
#
# Usage:
#   make scaffold FEATURE=UserProfile
#
# Direct usage (run from anywhere inside the project):
#   ./Scripts/scaffold_feature.sh <FeatureName>
#   ./Scripts/scaffold_feature.sh UserProfile
#
# Generates inside the source root (the directory containing this Scripts/ folder):
#   Presentation/<Feature>/<Feature>View.swift
#   Presentation/<Feature>/<Feature>ViewModel.swift
#   Domain/<Feature>/<Feature>.swift
#   Data/<Feature>/<Feature>Repository.swift        ← Port + Adapter
#
# Because this project uses Xcode 15 filesystem-synchronized folders, the new
# files appear in the Xcode Navigator automatically — no "Add Files" step needed.

set -euo pipefail

# ── Validate arguments ──────────────────────────────────────────────────────
if [[ $# -lt 1 ]]; then
    echo "❌  Usage: scaffold_feature.sh <FeatureName>" >&2
    echo "    Example: scaffold_feature.sh UserProfile" >&2
    echo "    (Run via: make scaffold FEATURE=UserProfile)" >&2
    exit 1
fi

FEATURE="$1"

# Feature name must be PascalCase.
if ! [[ "$FEATURE" =~ ^[A-Z][A-Za-z0-9]*$ ]]; then
    echo "❌  Feature name must start with an uppercase letter and contain only" >&2
    echo "    alphanumeric characters (e.g. UserProfile, PaymentFlow)." >&2
    exit 1
fi

# ── Resolve paths ────────────────────────────────────────────────────────────
# This script lives at <SourceRoot>/Scripts/scaffold_feature.sh, so the source
# root is always the parent of the Scripts/ directory — regardless of where
# make is invoked from.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_ROOT="$(dirname "$SCRIPT_DIR")"
SOURCE_DIR="$(basename "$SOURCE_ROOT")"

# The test target folder is expected at <ProjectRoot>/<SourceDir>Tests/
# (the default Xcode naming convention).  If it doesn't exist we skip test
# generation and print a note instead of failing.
PROJECT_ROOT="$(dirname "$SOURCE_ROOT")"
TESTS_ROOT="$PROJECT_ROOT/${SOURCE_DIR}Tests"

YEAR=$(date +%Y)
CREATED=$(date +"%d %b %Y")

PRESENTATION_DIR="$SOURCE_ROOT/Presentation/$FEATURE"
DOMAIN_DIR="$SOURCE_ROOT/Domain/$FEATURE"
DATA_DIR="$SOURCE_ROOT/Data/$FEATURE"

VIEW_FILE="$PRESENTATION_DIR/${FEATURE}View.swift"
VIEWMODEL_FILE="$PRESENTATION_DIR/${FEATURE}ViewModel.swift"
MODEL_FILE="$DOMAIN_DIR/${FEATURE}.swift"
REPOSITORY_FILE="$DATA_DIR/${FEATURE}Repository.swift"

TESTS_FEATURE_DIR="$TESTS_ROOT/Features/$FEATURE"
TESTS_FILE="$TESTS_FEATURE_DIR/${FEATURE}Tests.swift"

# ── Conflict check ───────────────────────────────────────────────────────────
CONFLICTS=()
for f in "$VIEW_FILE" "$VIEWMODEL_FILE" "$MODEL_FILE" "$REPOSITORY_FILE"; do
    [[ -f "$f" ]] && CONFLICTS+=("$f")
done
[[ -d "$TESTS_ROOT" && -f "$TESTS_FILE" ]] && CONFLICTS+=("$TESTS_FILE")

if [[ ${#CONFLICTS[@]} -gt 0 ]]; then
    echo "❌  The following files already exist:" >&2
    for f in "${CONFLICTS[@]}"; do
        echo "    ${f#"$SOURCE_ROOT/"}" >&2
    done
    echo "    Delete or rename them before scaffolding." >&2
    exit 1
fi

# ── Create directories ───────────────────────────────────────────────────────
mkdir -p "$PRESENTATION_DIR" "$DOMAIN_DIR" "$DATA_DIR"

# ── Write files ──────────────────────────────────────────────────────────────

# ---- Presentation/<Feature>/<Feature>View.swift ----------------------------
cat > "$VIEW_FILE" << SWIFT
//
//  ${FEATURE}View.swift
//
//  Created $CREATED
//  Copyright © $YEAR ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct ${FEATURE}View: View {

    @State private var viewModel = ${FEATURE}ViewModel()

    var body: some View {
        Text("${FEATURE}")
    }
}

#Preview {
    ${FEATURE}View()
}
SWIFT

# ---- Presentation/<Feature>/<Feature>ViewModel.swift -----------------------
cat > "$VIEWMODEL_FILE" << SWIFT
//
//  ${FEATURE}ViewModel.swift
//
//  Created $CREATED
//  Copyright © $YEAR ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

@MainActor @Observable
final class ${FEATURE}ViewModel {

    // MARK: - State


    // MARK: - Dependencies


    // MARK: - Init

    init() {

    }

    // MARK: - Actions
}
SWIFT

# ---- Domain/<Feature>/<Feature>.swift (domain model) ----------------------
cat > "$MODEL_FILE" << SWIFT
//
//  ${FEATURE}.swift
//
//  Created $CREATED
//  Copyright © $YEAR ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

/// Domain model for the ${FEATURE} feature.
///
/// Keep this type free of framework dependencies — no SwiftUI, no UIKit.
struct ${FEATURE}: Identifiable, Hashable, Sendable {
    let id: String
    // Add domain properties here.
}
SWIFT

# ---- Data/<Feature>/<Feature>Repository.swift (Port + Adapter) ------------
cat > "$REPOSITORY_FILE" << SWIFT
//
//  ${FEATURE}Repository.swift
//
//  Created $CREATED
//  Copyright © $YEAR ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

// MARK: - ${FEATURE}Port (Domain boundary)

/// Defines the contract the Domain layer requires from the Data layer.
/// Depend on this protocol — never on the concrete ${FEATURE}Adapter.
protocol ${FEATURE}Port: Sendable {
    func fetch(id: String) async throws -> ${FEATURE}
    func fetchAll() async throws -> [${FEATURE}]
    func save(_ entity: ${FEATURE}) async throws
    func delete(id: String) async throws
}

// MARK: - ${FEATURE}Adapter (Data layer implementation)

/// Implements \`${FEATURE}Port\` using a \`NetworkSession\`.
/// Injected at the composition root (AppContainer); only the Port is exposed
/// to Domain and Presentation code.
final class ${FEATURE}Adapter: ${FEATURE}Port {

    private let session: any NetworkSession

    init(session: any NetworkSession) {
        self.session = session
    }

    func fetch(id: String) async throws -> ${FEATURE} {
        fatalError("${FEATURE}Adapter.fetch(id:) — not yet implemented")
    }

    func fetchAll() async throws -> [${FEATURE}] {
        fatalError("${FEATURE}Adapter.fetchAll() — not yet implemented")
    }

    func save(_ entity: ${FEATURE}) async throws {
        fatalError("${FEATURE}Adapter.save(_:) — not yet implemented")
    }

    func delete(id: String) async throws {
        fatalError("${FEATURE}Adapter.delete(id:) — not yet implemented")
    }
}
SWIFT

# ── Generate test stub (Swift Testing) ───────────────────────────────────────
TESTS_GENERATED=false
if [[ -d "$TESTS_ROOT" ]]; then
    mkdir -p "$TESTS_FEATURE_DIR"
    cat > "$TESTS_FILE" << SWIFT
//
//  ${FEATURE}Tests.swift
//
//  Created $CREATED
//  Copyright © $YEAR ___ORGANIZATIONNAME___. All rights reserved.
//

import Testing
@testable import ${SOURCE_DIR}

// MARK: - Domain Model

@Suite("${FEATURE}")
struct ${FEATURE}Tests {

    @Test("initialises with expected id")
    func initialises() {
        let sut = ${FEATURE}(id: "test-id")
        #expect(sut.id == "test-id")
    }
}

// MARK: - Port Contract (use a mock adapter)

@Suite("${FEATURE}Port")
struct ${FEATURE}PortTests {

    // Implement a mock conforming to ${FEATURE}Port, then verify
    // each operation in isolation here.
}
SWIFT
    TESTS_GENERATED=true
fi

# ── Summary ──────────────────────────────────────────────────────────────────
echo ""
echo "✅  Scaffolded: ${FEATURE}"
echo ""
echo "   📁 ${SOURCE_DIR}/Presentation/${FEATURE}/"
echo "      ${FEATURE}View.swift"
echo "      ${FEATURE}ViewModel.swift"
echo "   📁 ${SOURCE_DIR}/Domain/${FEATURE}/"
echo "      ${FEATURE}.swift"
echo "   📁 ${SOURCE_DIR}/Data/${FEATURE}/"
echo "      ${FEATURE}Repository.swift"
if [[ "$TESTS_GENERATED" == true ]]; then
echo "   📁 ${SOURCE_DIR}Tests/Features/${FEATURE}/"
echo "      ${FEATURE}Tests.swift"
else
echo ""
echo "   ℹ️   No test target found at $(basename "$TESTS_ROOT")/."
echo "       Create an XCTest/Swift Testing bundle named ${SOURCE_DIR}Tests"
echo "       and re-run scaffold to generate test stubs automatically."
fi
echo ""
echo "   Xcode picks up new files automatically (filesystem-synchronized folders)."
echo ""
echo "   Wire the feature in AppContainer:"
echo "      func make${FEATURE}ViewModel() -> ${FEATURE}ViewModel {"
echo "          ${FEATURE}ViewModel(/* inject ${FEATURE}Port */)  "
echo "      }"
echo ""

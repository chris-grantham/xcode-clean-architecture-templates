// ___FILEHEADER___

import SwiftUI

// MARK: - Semantic Color Tokens
//
// Back each token with an Asset Catalogue entry whose name matches the string literal.
// Group entries in the catalogue under the same folder structure (Brand/, Background/, etc.)
// to keep token names and asset paths in sync.
//
// Light/dark variants are handled by the Asset Catalogue — no conditional code needed here.

extension Color {

    // MARK: - Brand

    /// Primary interactive colour — buttons, links, tinted icons.
    enum Brand {
        static let primary   = Color("Brand/Primary")
        static let secondary = Color("Brand/Secondary")
        static let accent    = Color("Brand/Accent")
    }

    // MARK: - Background

    /// Surface colours for screens, cards, and sheets.
    enum Background {
        /// Main screen background.
        static let primary   = Color("Background/Primary")
        /// Elevated surfaces (cards, sidebars).
        static let secondary = Color("Background/Secondary")
        /// Deeply inset or grouped content.
        static let tertiary  = Color("Background/Tertiary")
    }

    // MARK: - Text

    /// Label colours with descending visual hierarchy.
    enum Text {
        static let primary   = Color("Text/Primary")
        static let secondary = Color("Text/Secondary")
        static let tertiary  = Color("Text/Tertiary")
        static let disabled  = Color("Text/Disabled")
        /// Text placed on top of `Brand.primary` backgrounds.
        static let onBrand   = Color("Text/OnBrand")
    }

    // MARK: - Border

    /// Dividers, input field outlines, and separator lines.
    enum Border {
        static let subtle    = Color("Border/Subtle")
        static let default_  = Color("Border/Default")
        static let strong    = Color("Border/Strong")
    }

    // MARK: - Status

    /// Semantic feedback colours for system state.
    enum Status {
        static let success   = Color("Status/Success")
        static let warning   = Color("Status/Warning")
        static let error     = Color("Status/Error")
        static let info      = Color("Status/Info")
        /// Background tint for success status banners.
        static let successSubtle = Color("Status/SuccessSubtle")
        /// Background tint for warning status banners.
        static let warningSubtle = Color("Status/WarningSubtle")
        /// Background tint for error status banners.
        static let errorSubtle   = Color("Status/ErrorSubtle")
    }

    // MARK: - Icon

    /// Tint colours for decorative and functional icons.
    enum Icon {
        static let primary   = Color("Icon/Primary")
        static let secondary = Color("Icon/Secondary")
        static let disabled  = Color("Icon/Disabled")
        static let onBrand   = Color("Icon/OnBrand")
    }
}

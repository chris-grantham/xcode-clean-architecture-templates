// ___FILEHEADER___

import SwiftUI

// MARK: - Spacing

/// 8-point spacing scale.
///
/// Use these tokens wherever layout spacing is required to maintain consistent
/// visual rhythm. Prefer `Spacing.md` as the default component padding.
enum Spacing {
    /// 2 pt — hairline separators, tight icon offsets.
    static let xxxs: CGFloat = 2
    /// 4 pt — compact insets, badge padding.
    static let xxs: CGFloat = 4
    /// 8 pt — small component gaps, icon-to-label spacing.
    static let xs: CGFloat = 8
    /// 12 pt — tight section padding.
    static let sm: CGFloat = 12
    /// 16 pt — default component padding (base unit × 2).
    static let md: CGFloat = 16
    /// 20 pt — comfortable list row insets.
    static let mdl: CGFloat = 20
    /// 24 pt — section-level vertical rhythm.
    static let lg: CGFloat = 24
    /// 32 pt — generous section gaps.
    static let xl: CGFloat = 32
    /// 48 pt — screen-edge margins on iPad, hero spacing.
    static let xxl: CGFloat = 48
    /// 64 pt — large structural dividers.
    static let xxxl: CGFloat = 64
}

// MARK: - Typography

/// Type scale and weight tokens aligned to the iOS Dynamic Type size chart.
enum Typography {

    // MARK: Size

    enum Size: CGFloat, CaseIterable {
        case caption2    = 11
        case caption     = 12
        case footnote    = 13
        case subheadline = 15
        case callout     = 16
        case body        = 17
        case headline    = 17
        case title3      = 20
        case title2      = 22
        case title       = 28
        case largeTitle  = 34
    }

    // MARK: Weight

    enum Weight: CaseIterable {
        case ultraLight, thin, light, regular, medium, semibold, bold, heavy, black

        var fontWeight: Font.Weight {
            switch self {
            case .ultraLight: return .ultraLight
            case .thin:       return .thin
            case .light:      return .light
            case .regular:    return .regular
            case .medium:     return .medium
            case .semibold:   return .semibold
            case .bold:       return .bold
            case .heavy:      return .heavy
            case .black:      return .black
            }
        }
    }

    // MARK: Factory

    static func font(size: Size, weight: Weight = .regular) -> Font {
        .system(size: size.rawValue, weight: weight.fontWeight, design: .default)
    }

    static func roundedFont(size: Size, weight: Weight = .regular) -> Font {
        .system(size: size.rawValue, weight: weight.fontWeight, design: .rounded)
    }

    static func monoFont(size: Size, weight: Weight = .regular) -> Font {
        .system(size: size.rawValue, weight: weight.fontWeight, design: .monospaced)
    }

    // MARK: Semantic aliases

    static let body          = font(size: .body, weight: .regular)
    static let bodyEmphasised = font(size: .body, weight: .semibold)
    static let headline      = font(size: .headline, weight: .semibold)
    static let subheadline   = font(size: .subheadline, weight: .regular)
    static let footnote      = font(size: .footnote, weight: .regular)
    static let caption       = font(size: .caption, weight: .regular)
    static let largeTitle    = font(size: .largeTitle, weight: .bold)
}

// MARK: - Semantic Color Tokens
//
// Back each token with an Asset Catalogue entry whose name matches the string literal.
// Group entries under the same folder structure (Brand/, Background/, etc.)

extension Color {

    // MARK: Brand

    enum Brand {
        static let primary   = Color("Brand/Primary")
        static let secondary = Color("Brand/Secondary")
        static let accent    = Color("Brand/Accent")
    }

    // MARK: Background

    enum Background {
        static let primary   = Color("Background/Primary")
        static let secondary = Color("Background/Secondary")
        static let tertiary  = Color("Background/Tertiary")
    }

    // MARK: Text

    enum Text {
        static let primary   = Color("Text/Primary")
        static let secondary = Color("Text/Secondary")
        static let tertiary  = Color("Text/Tertiary")
        static let disabled  = Color("Text/Disabled")
        static let onBrand   = Color("Text/OnBrand")
    }

    // MARK: Border

    enum Border {
        static let subtle   = Color("Border/Subtle")
        static let default_ = Color("Border/Default")
        static let strong   = Color("Border/Strong")
    }

    // MARK: Status

    enum Status {
        static let success       = Color("Status/Success")
        static let warning       = Color("Status/Warning")
        static let error         = Color("Status/Error")
        static let info          = Color("Status/Info")
        static let successSubtle = Color("Status/SuccessSubtle")
        static let warningSubtle = Color("Status/WarningSubtle")
        static let errorSubtle   = Color("Status/ErrorSubtle")
    }

    // MARK: Icon

    enum Icon {
        static let primary   = Color("Icon/Primary")
        static let secondary = Color("Icon/Secondary")
        static let disabled  = Color("Icon/Disabled")
        static let onBrand   = Color("Icon/OnBrand")
    }
}

// ___FILEHEADER___

import SwiftUI

// MARK: - Spacing

/// 8-point spacing scale.
enum Spacing {
    static let xxxs: CGFloat = 2
    static let xxs:  CGFloat = 4
    static let xs:   CGFloat = 8
    static let sm:   CGFloat = 12
    static let md:   CGFloat = 16
    static let mdl:  CGFloat = 20
    static let lg:   CGFloat = 24
    static let xl:   CGFloat = 32
    static let xxl:  CGFloat = 48
    static let xxxl: CGFloat = 64
}

// MARK: - Typography

/// Type scale and weight tokens.
enum Typography {

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

    static func font(size: Size, weight: Weight = .regular) -> Font {
        .system(size: size.rawValue, weight: weight.fontWeight, design: .default)
    }

    static func roundedFont(size: Size, weight: Weight = .regular) -> Font {
        .system(size: size.rawValue, weight: weight.fontWeight, design: .rounded)
    }

    static func monoFont(size: Size, weight: Weight = .regular) -> Font {
        .system(size: size.rawValue, weight: weight.fontWeight, design: .monospaced)
    }

    static let body           = font(size: .body, weight: .regular)
    static let bodyEmphasised = font(size: .body, weight: .semibold)
    static let headline       = font(size: .headline, weight: .semibold)
    static let subheadline    = font(size: .subheadline, weight: .regular)
    static let footnote       = font(size: .footnote, weight: .regular)
    static let caption        = font(size: .caption, weight: .regular)
    static let largeTitle     = font(size: .largeTitle, weight: .bold)
}

// MARK: - Semantic Color Tokens
//
// Back each token with an Asset Catalogue colour set whose name matches the string literal.
// Organise colour sets under folders matching these namespaces (Brand/, Background/, etc.)
// so light/dark variants are handled by the catalogue — no conditional code needed here.

extension Color {

    enum Brand {
        static let primary   = Color("Brand/Primary")
        static let secondary = Color("Brand/Secondary")
        static let accent    = Color("Brand/Accent")
    }

    enum Background {
        static let primary   = Color("Background/Primary")
        static let secondary = Color("Background/Secondary")
        static let tertiary  = Color("Background/Tertiary")
    }

    enum Text {
        static let primary   = Color("Text/Primary")
        static let secondary = Color("Text/Secondary")
        static let tertiary  = Color("Text/Tertiary")
        static let disabled  = Color("Text/Disabled")
        static let onBrand   = Color("Text/OnBrand")
    }

    enum Border {
        static let subtle   = Color("Border/Subtle")
        static let default_ = Color("Border/Default")
        static let strong   = Color("Border/Strong")
    }

    enum Status {
        static let success       = Color("Status/Success")
        static let warning       = Color("Status/Warning")
        static let error         = Color("Status/Error")
        static let info          = Color("Status/Info")
        static let successSubtle = Color("Status/SuccessSubtle")
        static let warningSubtle = Color("Status/WarningSubtle")
        static let errorSubtle   = Color("Status/ErrorSubtle")
    }

    enum Icon {
        static let primary   = Color("Icon/Primary")
        static let secondary = Color("Icon/Secondary")
        static let disabled  = Color("Icon/Disabled")
        static let onBrand   = Color("Icon/OnBrand")
    }
}

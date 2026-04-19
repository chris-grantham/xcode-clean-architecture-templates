// ___FILEHEADER___

import SwiftUI

// MARK: - Typography

/// Type scale and weight tokens aligned to the iOS Dynamic Type size chart.
///
/// Use `Typography.font(size:weight:)` or the convenience `View` modifier
/// `.typographyStyle(_:)` to apply consistent text styling.
///
/// ```swift
/// Text("Hello")
///     .font(Typography.font(size: .body, weight: .regular))
/// ```
enum Typography {

    // MARK: - Size

    /// Point sizes matching the default (Large) Dynamic Type setting.
    enum Size: CGFloat, CaseIterable {
        case caption2    = 11
        case caption     = 12
        case footnote    = 13
        case subheadline = 15
        case callout     = 16
        case body        = 17
        case headline    = 17  // headline is bold body
        case title3      = 20
        case title2      = 22
        case title       = 28
        case largeTitle  = 34
    }

    // MARK: - Weight

    enum Weight: CaseIterable {
        case ultraLight
        case thin
        case light
        case regular
        case medium
        case semibold
        case bold
        case heavy
        case black

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

    // MARK: - Factory

    /// Returns a SwiftUI `Font` for the given size and weight combination.
    static func font(size: Size, weight: Weight = .regular) -> Font {
        .system(size: size.rawValue, weight: weight.fontWeight, design: .default)
    }

    /// Returns a SwiftUI `Font` using the system rounded design.
    static func roundedFont(size: Size, weight: Weight = .regular) -> Font {
        .system(size: size.rawValue, weight: weight.fontWeight, design: .rounded)
    }

    /// Returns a SwiftUI `Font` using the monospaced design.
    static func monoFont(size: Size, weight: Weight = .regular) -> Font {
        .system(size: size.rawValue, weight: weight.fontWeight, design: .monospaced)
    }

    // MARK: - Semantic aliases

    /// Body copy — `body / regular`.
    static let body = font(size: .body, weight: .regular)
    /// Prominent body — `body / semibold`.
    static let bodyEmphasised = font(size: .body, weight: .semibold)
    /// Navigation / card titles — `headline / semibold`.
    static let headline = font(size: .headline, weight: .semibold)
    /// Secondary labels — `subheadline / regular`.
    static let subheadline = font(size: .subheadline, weight: .regular)
    /// De-emphasised detail text — `footnote / regular`.
    static let footnote = font(size: .footnote, weight: .regular)
    /// Smallest supplementary text — `caption / regular`.
    static let caption = font(size: .caption, weight: .regular)
    /// Large display text — `largeTitle / bold`.
    static let largeTitle = font(size: .largeTitle, weight: .bold)
}

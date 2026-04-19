// ___FILEHEADER___

import CoreFoundation

// MARK: - Spacing

/// 8-point spacing scale.
///
/// Use these tokens wherever layout spacing is required to maintain consistent
/// visual rhythm. Prefer `Spacing.md` as the default component padding.
///
/// ```swift
/// .padding(.horizontal, Spacing.md)
/// .padding(.vertical, Spacing.sm)
/// VStack(spacing: Spacing.lg) { … }
/// ```
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

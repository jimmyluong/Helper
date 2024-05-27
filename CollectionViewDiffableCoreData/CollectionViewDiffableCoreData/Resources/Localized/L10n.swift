// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// 停止跑步 Korean
  internal static let languageEn = L10n.tr("Localizable", "language_en", fallback: "停止跑步 Korean")
  /// 停止跑步 korean
  internal static let languageKo = L10n.tr("Localizable", "language_ko", fallback: "停止跑步 korean")
  /// 停止跑步 korean
  internal static let languageVi = L10n.tr("Localizable", "language_vi", fallback: "停止跑步 korean")
  /// 暂停运行
  internal static let pauseMessge = L10n.tr("Localizable", "pause_messge", fallback: "暂停运行")
  /// 开始跑步
  internal static let startMessge = L10n.tr("Localizable", "start_messge", fallback: "开始跑步")
  /// 停止跑步
  internal static let stopMessge = L10n.tr("Localizable", "stop_messge", fallback: "停止跑步")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type

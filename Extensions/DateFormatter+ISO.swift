
import Foundation

// MARK: Support Codable + Json parser
extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()
    
    static let iso8601Date: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd"
      return formatter
    }()
    
    static func dateFormatLocale(locale: Locale) -> DateFormatter {
        let formatter = DateFormatter()
        if locale.identifier.contains("ja") {
            formatter.dateFormat = "yyyy年MM月dd日 HH時mm分"
        } else {
            formatter.dateStyle = .long
            formatter.timeStyle = .short
        }
        return formatter
    }
    
    static func utcToLocal(dateStr: String, locale: Locale) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone.current
            if locale.identifier.contains("ja") {
                dateFormatter.dateFormat = "yyyy年MM月dd日 HH時mm分"
            } else {
                dateFormatter.dateStyle = .long
                dateFormatter.timeStyle = .short
            }
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    static let dateISONaht: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }()
    
}

// MARK: Support DateTime BackEnd
extension DateFormatter {
    
    /// Matching Backend Format
    static let dateTimeGMT: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
}

// MARK:
extension Date {
    
    /// Returns the difference between two dates.
    /// - Parameters:
    ///   - components: Which components to compare (starting date components --> ending date components )
    ///   - calendar: The date to use.
    /// - Returns: The result of calculating the difference from start to end.
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    /// Returns the value for one component of a date.
    /// - Parameters:
    ///   - component: The component to calculate.
    ///   - calendar: The date to use.
    /// - Returns: The value for the component.
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

extension Date {
    
    var convertNameCharacter: String {
        /// get double time unix
        let timeInterval = self.timeIntervalSince1970
        /// convert name
        let replace = String(timeInterval).replacingOccurrences(of: ".", with: "-")
        
        return replace
    }
}

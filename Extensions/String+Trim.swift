
import Foundation

extension String {
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    func trimDotCharacter() -> String {
        return trim().replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "。", with: "")
    }
    
    func hasNonEmptyValue() -> Bool {
        return self.trim() != ""
    }
    
    func getAgeFromDateBirthDay() -> String {
        var calendar = Calendar.init(identifier: .gregorian)
        calendar.locale = Locale.autoupdatingCurrent
        let dateBirthDay = DateFormatter.dateISONaht.date(from: self) ?? Date()
        let yearBirthDay = dateBirthDay.get(.year, calendar: calendar)
        let yearNow = Date().get(.year, calendar: calendar)
        let age = yearNow - yearBirthDay
        return "\(age)\("patient_list_age_title".localized)"
    }
    
}


extension String {
    
    var convertDateTimeGMT: String {
        /// convert convention to TimeInterval
        let replace = self.replacingOccurrences(of: ".\(MineType.mp3.rawValue)", with: "").replacingOccurrences(of: "-", with: ".")
        
        guard let timeInterval = Double(replace) else {
            return "\(Int(Date().timeIntervalSince1970))"
        }
        
        let date = Date(timeIntervalSince1970: timeInterval)
        
        return DateFormatter.dateTimeGMT.string(from: date)
    }
}


extension StringProtocol {
    
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        ranges(of: string, options: options).map(\.lowerBound)
    }
    
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
              let range = self[startIndex...]
                .range(of: string, options: options) {
            result.append(range)
            startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}

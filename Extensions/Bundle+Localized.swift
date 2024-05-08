

import Foundation

private let languageDefault = "en"

extension String {
    
    var localized: String {
        let languageCode = Bundle.main.preferredLocalizations.first ?? languageDefault
        let resourceBundle = Bundle.main.path(forResource: languageCode, ofType: "lproj") ?? languageDefault
        
        return NSLocalizedString(self, bundle: Bundle(path: resourceBundle) ?? Bundle.main, comment: self)
    }
    
    func localizedWithFormat(arguments: CVarArg...) -> String{
        return String(format: self.localized, arguments: arguments)
    }
    
    
}

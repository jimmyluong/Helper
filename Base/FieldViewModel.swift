

import Foundation
import RxSwift

protocol FieldViewModel {
    
    var isSecureTextEntry: Bool { get }
    var isValid: Observable<Bool> { get }
    
    // Observables
    var value: BehaviorSubject<String> { get set }
    var errorValue: Observable<String?> { get }
}


extension FieldViewModel {
    
    func validateSize(_ value: String, size: (min: Int, max: Int)) -> Bool {
        return (size.min...size.max).contains(value.count)
    }
    
    func validateString(_ value: String?, pattern: String) -> Bool {
        let predicate = NSPredicate(format:"SELF MATCHES %@", pattern)
        return predicate.evaluate(with: value)
    }
}

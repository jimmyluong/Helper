//
//  UserDefaults+Extensions.swift
//  
//
//  Created by Jimmy on 30/07/2023.
//

import Foundation

public protocol ObjectSavable {
    func saveObject<Object>(_ object: Object?, forKey: String) throws where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}

enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"
    
    var errorDescription: String? {
        rawValue
    }
}

extension UserDefaults: ObjectSavable {
    public func saveObject<Object>(_ object: Object?, forKey: String) throws where Object: Encodable {
        guard let object = object else {
            set(nil, forKey: forKey)
            return
        }
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }
    
    public func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
        guard let data = data(forKey: forKey) else { throw ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
}

// https://www.avanderlee.com/swift/property-wrappers/
/// Allows to match for optionals with generics that are defined as non-optional.
public protocol AnyOptional {
    /// Returns `true` if `nil`, otherwise `false`.
    var isNil: Bool { get }
}
extension Optional: AnyOptional {
    public var isNil: Bool { self == nil }
}

public enum UserDefaultMode {
    case normal
    case encodable
}

@propertyWrapper
public struct UserDefault<Value: Codable> {
    let key: String
    let mode: UserDefaultMode
    let defaultValue: Value
    var container: UserDefaults = .standard
    
    public  init(key: String, mode: UserDefaultMode, defaultValue: Value, container: UserDefaults = .standard) {
        self.key = key
        self.mode = mode
        self.defaultValue = defaultValue
        self.container = container
    }

    public var wrappedValue: Value {
        get {
            if mode == .encodable {
                do {
                    return try container.getObject(forKey: key, castTo: Value.self)
                }
                catch let error {
//                    Logger.shared.error(error.localizedDescription)
                    return defaultValue
                }
            } else {
                let temp = container.object(forKey: key) as? Value
                if temp == nil {
                    container.set(defaultValue, forKey: key)
                }
                
                return container.object(forKey: key) as? Value ?? defaultValue
            }
        }
        set {
            // Check whether we're dealing with an optional and remove the object if the new value is nil.
            if let optional = newValue as? AnyOptional, optional.isNil {
                container.removeObject(forKey: key)
            } else {
                if mode == .encodable {
                    do {
                        try container.saveObject(newValue, forKey: key)
                    } catch let error {
//                        Logger.shared.error(error.localizedDescription)
                    }
                } else {
                    container.set(newValue, forKey: key)
                }
            }
        }
    }

    public var projectedValue: Bool {
        return true
    }
}


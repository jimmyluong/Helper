
import Foundation

extension Data {
    func toObject<T:Codable>(_ type: T.Type) -> T? {
        if type == VoidResponse.self {
            return VoidResponse() as? T
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(.iso8601Full)
            return try decoder.decode(type, from: self)
        } catch {
            Logger.error("Error decoding data \(error)")
            return nil
        }
    }
}

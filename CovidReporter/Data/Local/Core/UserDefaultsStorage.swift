import Foundation

@propertyWrapper
final class UserDefaultsStorage<T: UserDefaultConvertible> {

    private let key: String

    init(key: String) {
        self.key = key
    }

    var wrappedValue: T? {
        get {
            guard
                let object = UserDefaults.standard.object(forKey: self.key),
                let value = T(with: object)
            else  {
                return nil
            }
            return value

        } set {
            if let object = newValue?.toUserDefaultObject() {
                UserDefaults.standard.set(object, forKey: self.key)
            } else {
                UserDefaults.standard.removeObject(forKey: self.key)
            }
        }
    }
}

struct UserDefaultKey {
    static let prefectures = "prefectures"
}

protocol UserDefaultConvertible {
    init?(with object: Any)
    func toUserDefaultObject() -> Any?
}

extension String: UserDefaultConvertible {
    init?(with object: Any) {
        guard
            let value = object as? Self
        else {
            return nil
        }
        self = value
    }

    func toUserDefaultObject() -> Any? {
        return self
    }
}

extension Array: UserDefaultConvertible where Element: UserDefaultConvertible {

    private struct UserDefaultCompatibleError: Error {}

    init?(with userDefaultObject: Any) {
        guard
            let objects = userDefaultObject as? [Any]
        else {
            return nil
        }
        
        do {
            let values = try objects.map { object -> Element in
                if let element = Element(with: object) {
                    return element
                } else {
                    throw UserDefaultCompatibleError()
                }
            }
            self = values
        } catch {
            return nil
        }
    }

    func toUserDefaultObject() -> Any? {
        map {
            $0.toUserDefaultObject()
        }
    }
}

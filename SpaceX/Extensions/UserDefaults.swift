//
//  UserDefaults.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 22.12.2022.
//

import Foundation

@propertyWrapper
struct Persist<T> {
    let key: String
    let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue

        if UserDefaults.standard.object(forKey: key) == nil {
            wrappedValue = defaultValue
        }
    }

    var wrappedValue: T {
        get {
            if let val = UserDefaults.standard.object(forKey: key) as? T {
                return val
            } else {
                UserDefaults.standard.set(defaultValue, forKey: key)
                return defaultValue
            }
        }

        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

extension UserDefaults {
    @Persist(key: "Высота", defaultValue: 0)
    static var height: Int
    
    @Persist(key: "Диаметр", defaultValue: 0)
    static var diametr: Int
    
    @Persist(key: "Масса", defaultValue: 0)
    static var mass: Int

    @Persist(key: "Полезная нагрузка", defaultValue: 0)
    static var payload: Int
}

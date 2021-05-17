//
//  DataStore.swift
//  MyWeight
//
//  Created by Astemir Shibzuhov on 5/17/21.
//

import Foundation


class DataStore {
    enum KeyForStore: String {
        case user = "user"
    }
    
    func saveUser(user: User) {
        UserDefaults.standard.setValue(try? PropertyListEncoder().encode(user), forKey: KeyForStore.user.rawValue)
    }
    
    func getUser() -> User? {
        if let data = UserDefaults.standard.data(forKey: KeyForStore.user.rawValue) {
            return try? PropertyListDecoder().decode(User.self, from: data)
        } else {
            return nil
        }
    }
}

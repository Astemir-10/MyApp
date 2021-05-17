//
//  User.swift
//  MyWeight
//
//  Created by Astemir Shibzuhov on 5/17/21.
//

import Foundation

enum Gender: String, Codable, CaseIterable {
    case men = "Мужской"
    case women = "Женский"
    case none = "Не указано"
}

enum LifeStyle: String, Codable, CaseIterable {
    case trening1 = "Тренеровки 1-3 раза в неделю"
    case none = "Не указано"
}

class User: Codable {

    
    var name: String
    var gender: Gender
    var age: Int
    var height: Int
    var weight: Int
    var lifeStyle: LifeStyle
    
    func set(params: UserParams, value: String) {
        switch params {
        case .name:
            self.name = value
        case .gender:
            self.gender = Gender(rawValue: value) ?? .none
        case .lifeStyle:
            self.lifeStyle = LifeStyle(rawValue: value) ?? .none
        case .height:
            self.height = Int(value) ?? 0
        case .weight:
            self.weight = Int(value) ?? 0
        case .age:
            self.age = Int(value) ?? 0
        case .none:
            break
        }
    }
    
    func set(gender: Gender) {
        self.gender = gender
    }
    
    init() {
        self.name = ""
        self.gender = .none
        self.age = 0
        self.height = 0
        self.weight = 0
        self.lifeStyle = .none
    }
}

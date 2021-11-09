//
//  Base.swift
//  formApp
//
//  Created by MacBook Pro on 31.03.2021.
//

import Foundation

final class DataManager {
    let defaults = UserDefaults.standard
    
    // MARK: - SingleTon
    static let shared = DataManager()
    
    // MARK: - UserMessage Struct
    struct UserMessage: Codable {
        var name: String
        var lastName: String
        var number: String
        var email: String
        var message: String
        var date : String
        var cellShow: String {
            return "\(name) \(lastName)"
        }
    }
    
    // MARK: - Add Message
    var addMessage: [UserMessage] {
        get {
            if let data = defaults.value(forKey: "addMessage") as? Data {
                return try! PropertyListDecoder().decode([UserMessage].self, from: data)
            } else {
                return [UserMessage]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: "addMessage")
            }
        }
    }
    
    // MARK: - Save Message
    func saveMessage(name: String, lastName: String, number: String, email: String, message: String, date: String) {
        let message = UserMessage(name: name, lastName: lastName, number: number, email: email, message: message, date: date)
        addMessage.insert(message, at: 0)
    }
}

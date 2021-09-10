//
//  PersistencyService.swift
//  avitoTraineeTestCase
//
//  Created by Mikhail Semenov on 09.09.2021.
//

import Foundation

final class DefaultPersistencyService {
    
    private let cacheTimeSeconds = 3600
    
    // MARK: Save Data
    
    func save(_ response: Any, key: String) {
        UserDefaults.standard.set(response, forKey: key)
    }
    
    func saveDate(_ date: Date, key: String) {
        UserDefaults.standard.set(date, forKey: key)
    }
    
    // MARK: Get Data
    
    func get(key: String) -> Data? {
        guard
            let data = UserDefaults.standard.data(forKey: key)
            else {
            return nil
        }
        return data
    }
    
    // MARK: Functions
    
    func compareDateFromStore(key: String) -> Bool {
        guard let date = UserDefaults.standard.object(forKey: key) as? Date else {
            return true
        }
        let calendar = Calendar.current
        guard let difference = calendar.dateComponents([.second], from: date, to: Date()).second
        else {
            print("error")
            return true
        }
        if difference > cacheTimeSeconds {
            return true
        }
        else {
            return false
        }
    }
}

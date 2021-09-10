//
//  JSONDecoder.swift
//  avitoTraineeTestCase
//
//  Created by Mikhail Semenov on 09.09.2021.
//

import Foundation

final class AppJSONDecoder: JSONDecoder {
    override init() {
        super.init()
        decodeSettings()
    }
    
    private func decodeSettings() {
        self.keyDecodingStrategy = .convertFromSnakeCase
    }
}

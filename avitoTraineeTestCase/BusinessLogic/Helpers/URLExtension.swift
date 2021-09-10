//
//  URLExtension.swift
//  avitoTraineeTestCase
//
//  Created by Mikhail Semenov on 09.09.2021.
//

import Foundation

extension URL {
    init(staticString string: StaticString) {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("Invalid static URL string: \(string)")
        }
        
        self = url
    }
}

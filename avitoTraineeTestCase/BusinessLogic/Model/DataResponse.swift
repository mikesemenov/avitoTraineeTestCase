//
//  DataResponse.swift
//  avitoTraineeTestCase
//
//  Created by Mikhail Semenov on 09.09.2021.
//

import Foundation

struct MainResponse: Codable{
    let company: Company
}

struct Company: Codable {
    let name: String?
    let employees: [Employee]?
}

struct Employee: Codable {
    var name: String?
    var phoneNumber: String?
    var skills: [String]?
}

//
//  SampleModel.swift
//  TestProject
//
//  Created by Александр Сибирцев on 10.10.2020.
//

import Foundation

struct SampleModel: Codable, Parseable, Equatable {
    typealias ParseableType = SampleModel
    
    let data: [SampleData]
    let view: [String]
}

// MARK: - Attributes
struct SampleData: Codable, Equatable {
    let name: String
    let data : AttributesData
}

struct AttributesData: Codable, Equatable {
    let text, url: String?
    let selectedId : Int?
    let variants: [AttributesDataVariants]?
}

struct AttributesDataVariants: Codable, Equatable {
    let text: String
    let id: Int
}




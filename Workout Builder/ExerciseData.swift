//
//  FoundationalMovements.swift
//  Workout Builder
//
//  Created by Cesar Fernandez on 8/16/24.
//

import Foundation

struct ExerciseCategory: Codable {
    let name: String
    let exercises: [String]
}

class ExerciseData: ObservableObject {
    let categories: [ExerciseCategory]
    
    init() {
        self.categories = ExerciseData.loadFromFile()
    }
    
    static func loadFromFile() -> [ExerciseCategory] {
        guard let url = Bundle.main.url(forResource: "exerciseData", withExtension: "json") else {
            print("File not found.")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([ExerciseCategory].self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
            return []
        }
    }
}

//

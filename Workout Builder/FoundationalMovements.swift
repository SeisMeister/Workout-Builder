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

struct ExerciseData {
    let categories: [ExerciseCategory]
    
    static func exampleData() -> ExerciseData {
        return ExerciseData(categories: [
            ExerciseCategory(name: "Squat", exercises: ["Goblet Squat", "Box Squat", "Split Squat"]),
            ExerciseCategory(name: "Hinge", exercises: ["Deadlift", "Good-Morning", "Glute Bridge"]),
            ExerciseCategory(name: "Push", exercises: ["Benchpress", "Deficit Push-Ups", "Military Press"]),
            ExerciseCategory(name: "Pull", exercises: ["Bent-Over Row", "Lat Pulldowns", "Bicep Curls"]),
            ExerciseCategory(name: "Carry", exercises: ["Farmer's Carry", "Suitcase Carry", "Overhead Carry"]),
            ExerciseCategory(name: "Rotation", exercises: ["Cable Axe Chops", "Rotational Medicine Ball Throws", "Rotational LandMine Press"])
        ])
    }
    
    static func loadFromFile() -> ExerciseData? {
        guard let url = Bundle.main.url(forResource: "exerciseData", withExtension: "json") else {
            print("File not found.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([String: [String]].self, from: data)
            
            let categories = decodedData.map { ExerciseCategory(name: $0.key, exercises: $0.value)}
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}

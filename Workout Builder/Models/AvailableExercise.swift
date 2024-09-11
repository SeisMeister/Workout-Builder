//
//  AvaliableExercises.swift
//  Workout Builder
//
//  Created by Cesar Fernandez on 9/10/24.
//

import Foundation
import SwiftData

@Model public class AvailableExercise {
    var name: String
    var sets: Int
    var repetitions: Int
    var category: ExerciseCategory
    
    public init(name: String, sets: Int, repetitions: Int, category: ExerciseCategory) {
        self.name = name
        self.sets = sets
        self.repetitions = repetitions
        self.category = category
    }
    
    public init(dto: AvailableExerciseDTO) {
        self.name = dto.name
        self.sets = dto.sets
        self.repetitions = dto.repetitions
        self.category = dto.category
    }
}


/// Data transfer object. Helps to take data from the JSON file, pops into this DTO
///  then we inject in the swiftData class.
public struct AvailableExerciseDTO: Codable {
    var name: String
    var sets: Int
    var repetitions: Int
    var category: ExerciseCategory
}
    

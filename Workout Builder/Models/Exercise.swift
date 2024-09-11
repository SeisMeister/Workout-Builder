//
//  Exercises.swift
//  Workout Builder
//
//  Created by Cesar Fernandez on 8/20/24.
//

import Foundation
import SwiftData

@Model public class Exercise {
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
    
    public init(from exercise: AvailableExercise) {
        self.name = exercise.name
        self.sets = exercise.sets
        self.repetitions = exercise.repetitions
        self.category = exercise.category
    }
}

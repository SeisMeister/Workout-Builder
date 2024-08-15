//
//  Workout.swift
//  Workout Builder
//
//  Created by Cesar Fernandez on 8/15/24.
//

import Foundation
import SwiftData

@Model public class Workout {
    var exercise: String
    var sets: Int
    var reps: Int
    
    init(exercise: String, sets: Int, reps: Int) {
        self.exercise = exercise
        self.sets = sets
        self.reps = reps
    }
}

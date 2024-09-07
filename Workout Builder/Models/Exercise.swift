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
    
    public init(name: String, sets: Int, repetitions: Int) {
        self.name = name
        self.sets = sets
        self.repetitions = repetitions
    }
}

// Ignore initial sample data
// Get it so the user can
// Get app working from swiftData not the sample data

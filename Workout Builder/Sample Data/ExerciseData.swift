//
//  FoundationalMovements.swift
//  Workout Builder
//
//  Created by Cesar Fernandez on 8/16/24.
//

import Foundation
import SwiftData

// Enum that helps categorize the exercise by the foundational movement patterns
public enum ExerciseCategory: String, CaseIterable, Codable {
    case squat, hinge, push, pull, carry, rotation
    
    var name: String {
        rawValue.capitalized
    }
}

class ExerciseData: ObservableObject {
    let categories: [ExerciseCategory]
    
    init() {
        self.categories = ExerciseCategory.allCases
    }
}

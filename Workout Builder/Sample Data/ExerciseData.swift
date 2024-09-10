//
//  FoundationalMovements.swift
//  Workout Builder
//
//  Created by Cesar Fernandez on 8/16/24.
//

import Foundation
import SwiftData

//struct ExerciseCategory: Codable {
//    let name: String
//    let exercises: [String]
//}

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

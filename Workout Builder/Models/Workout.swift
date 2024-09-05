//
//  FundamentalMovementPatterns.swift
//  Workout Builder
//
//  Created by Cesar Fernandez on 8/20/24.
//

import Foundation
import SwiftData

@Model class Workout {
    var name: String
    @Relationship(deleteRule: .cascade) var exercises: [Exercise] = []
    
    public init(name: String) {
        self.name = name
//        self.exercises = exercises
    }
}

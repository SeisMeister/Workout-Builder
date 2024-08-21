//
//  FundamentalMovementPatterns.swift
//  Workout Builder
//
//  Created by Cesar Fernandez on 8/20/24.
//

import Foundation
import SwiftData

@Model public struct Workout {
    var name: String
    var exercises = [Exercise]()
    
    public init(name: String, exercises: [Exercise]) {
        self.name = name
        self.exercises = exercises
    }
}

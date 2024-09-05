//
//  WorkoutDetail.swift
//  Workout Builder
//
//  Created by Cesar Fernandez on 9/5/24.
//

import SwiftUI
import SwiftData

struct WorkoutDetail: View {
    var workout: Workout
    
    var body: some View {
        ForEach(workout.exercises) { exercise in
            VStack {
                Text(exercise.name)
                Text("\(exercise.sets)")
                Text("\(exercise.repetitions)")
            }
        }
    }
}


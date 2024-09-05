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
        ForEach(workout.exercises, id: \.name) { exercise in
            VStack {
                HStack {
                    Text(exercise.name)
                    Spacer()
                    HStack {
                        Text("\(exercise.sets) sets")
                        Text("\(exercise.repetitions) reps")
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.vertical, 4)
            }
        }
    }
}


//
//  WorkoutDetail.swift
//  Workout Builder
//
//  Created by Cesar Fernandez on 9/5/24.
//

import SwiftUI
import SwiftData

struct WorkoutDetailView: View {
    var workout: Workout
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(workout.exercises, id: \.name) { exercise in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(exercise.name)
                                .font(.headline)
                            HStack {
                                Text("\(exercise.sets) sets, \(exercise.repetitions) reps")
                                    .font(.subheadline)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 2)
                        .padding(.vertical, 5)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle(workout.name)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: StartWorkoutView(workout: workout)) {
                        Text("Start Workout")
                    }
                }
            }
        }
    }
}

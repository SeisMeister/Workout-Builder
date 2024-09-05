//
//  StartPage.swift
//  Workout Builder
//
//  Created by Cesar Fernandez on 8/21/24.
//

import SwiftUI
import SwiftData

struct StartPage: View {
    @State private var showExerciseList = false
    @Query private var workoutArray: [Workout] = []
    
    var body: some View {
        NavigationStack {
            List {
                if !workoutArray.isEmpty {
                    Section("Workouts") {
                        ForEach(workoutArray, id: \.name) { workout in
                            NavigationLink {
                                WorkoutDetail(workout: workout)
                            } label: {
                                Text(workout.name)
                            }

                        }
                    }
                }
            }
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showExerciseList = true
                    }) {
                        Label("add new workout", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showExerciseList) {
                ExerciseList()
            }
        }
    }
}

#Preview {
    StartPage()
}

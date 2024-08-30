//
//  StartPage.swift
//  Workout Builder
//
//  Created by Cesar Fernandez on 8/21/24.
//

import SwiftUI

struct StartPage: View {
    @State private var showExerciseList = false
    @State private var newWorkoutName = ""
    @State private var workoutArray: [Workout] = []
    
    var body: some View {
        NavigationStack {
            List {
                if !workoutArray.isEmpty {
                    Section("Workouts") {
                        ForEach(workoutArray, id: \.name) { workout in
                                Text(workout.name)
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
    
    func addWorkout() {
        guard newWorkoutName.isEmpty == false else { return }
        
            withAnimation {
                let workout = Workout(name: newWorkoutName, exercises: [])
                workoutArray.append(workout)
                newWorkoutName = ""
        }
    }
    
    func addExercises(to workout: inout Workout) {
        guard newWorkoutName.isEmpty == false else { return }
        let set = 0
        let rep = 0
        
        withAnimation {
            let exercise = Exercise(name: newWorkoutName, sets: set, repetitions: rep)
            workout.exercises.append(exercise)
            newWorkoutName = ""
        }
    }
}

#Preview {
    StartPage()
}

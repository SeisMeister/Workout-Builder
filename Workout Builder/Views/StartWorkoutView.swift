//
//  StartWorkoutView.swift
//  Workout Builder
//
//  Created by Cesar Fernandez on 9/6/24.
//

import SwiftUI
import SwiftData

struct StartWorkoutView: View {
    var workout: Workout
    @State private var completedSets: [String: [Bool]] = [:]  // Dictionary to track completed sets for each exercise
    @State private var skippedSets: [String: [Bool]] = [:]     // Dictionary to track skipped sets for each exercise

    var body: some View {
        NavigationStack {
            List {
                ForEach(workout.exercises, id: \.name) { exercise in
                    // Helps to create a little more visual distinction for the user when scrolling through exercises.
                    
                    Section(header: Text(exercise.name)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .padding(.vertical, 5)) {
                        // Loop through each set for the current exercise
                        ForEach(0..<exercise.sets, id: \.self) { setIndex in
                            HStack {
                                // Showing the user the sets as well as the reps here
                                Text("Set \(setIndex + 1): \(exercise.repetitions) reps")
                                    .font(.subheadline)
                                
                                Spacer()  // Pushes the circles to the right side
                                
                                // Checkmark Circle - outlined vs filled
                                Image(systemName: completedSets[exercise.name, default: Array(repeating: false, count: exercise.sets)][setIndex] ? "checkmark.circle.fill" : "checkmark.circle")
                                    .foregroundColor(completedSets[exercise.name, default: Array(repeating: false, count: exercise.sets)][setIndex] ? .green : .gray)
                                    .onTapGesture {
                                        toggleSetCompletion(for: exercise.name, at: setIndex)
                                    }
                                
                                // X Circle, outline vs filled
                                Image(systemName: skippedSets[exercise.name, default: Array(repeating: false, count: exercise.sets)][setIndex] ? "xmark.circle.fill" : "xmark.circle")
                                    .foregroundColor(skippedSets[exercise.name, default: Array(repeating: false, count: exercise.sets)][setIndex] ? .red : .gray)
                                    .onTapGesture {
                                        toggleSetSkipped(for: exercise.name, at: setIndex)
                                    }
                            }
                            .padding()  // Adds padding inside the HStack
                            .background(Color.white)  // Sets background color for each set
                            .cornerRadius(15)  // Rounds the corners of the HStack background
                            .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 10)  
                            /// Adding a spicy shadow for each cell in the HStack
                            .padding(.vertical, 5)  // Adds vertical padding between sets
                        }
                    }
                }
            }
            .navigationTitle(workout.name)  // Big bold title for the name of your workout at the top
            .onAppear {
                initializeCompletionStatus()  // Initialize completion and skipped statuses when the view appears
            }
        }
    }

    private func initializeCompletionStatus() {
        // Initializes complete or incomplete for the user
        for exercise in workout.exercises {
            completedSets[exercise.name] = Array(repeating: false, count: exercise.sets)
            skippedSets[exercise.name] = Array(repeating: false, count: exercise.sets)
        }
    }

    private func toggleSetCompletion(for exerciseName: String, at setIndex: Int) {
        // Lets you click complete for a set
        completedSets[exerciseName]?[setIndex].toggle()
        // Helps to have disable the x if check is toggled
        if completedSets[exerciseName]?[setIndex] == true {
            skippedSets[exerciseName]?[setIndex] = false
        }
    }

    private func toggleSetSkipped(for exerciseName: String, at setIndex: Int) {
        // Lets you click incomplete for a set
        skippedSets[exerciseName]?[setIndex].toggle()
        // Won't let the user mark set as complete if marked as skipped
        if skippedSets[exerciseName]?[setIndex] == true {
            completedSets[exerciseName]?[setIndex] = false
        }
    }
}

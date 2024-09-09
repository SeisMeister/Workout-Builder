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
    @State private var completedSets: [String: [Bool]] = [:]

    var body: some View {
        List {
            ForEach(workout.exercises, id: \.name) { exercise in
                Section(header: Text(exercise.name).font(.headline)) {
                    ForEach(0..<exercise.sets, id: \.self) { setIndex in
                        HStack {
                            Text("Set \(setIndex + 1): \(exercise.repetitions) reps")
                            Spacer()
                            Image(systemName: completedSets[exercise.name, default: Array(repeating: false, count: exercise.sets)][setIndex] ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundColor(completedSets[exercise.name, default: Array(repeating: false, count: exercise.sets)][setIndex] ? .green : .red)
                                .onTapGesture {
                                    toggleSetCompletion(for: exercise.name, at: setIndex)
                                }
                        }
                    }
                }
            }
        }
        .onAppear {
            initializeCompletionStatus()
        }
    }

    private func initializeCompletionStatus() {
        for exercise in workout.exercises {
            completedSets[exercise.name] = Array(repeating: false, count: exercise.sets)
        }
    }

    private func toggleSetCompletion(for exerciseName: String, at setIndex: Int) {
        completedSets[exerciseName]?[setIndex].toggle()
    }
}


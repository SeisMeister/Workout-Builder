//
//  ContentView.swift
//  Workout Builder
//
//  Created by Cesar Fernandez on 8/15/24.
//

import SwiftUI

struct ExerciseList: View {
    @EnvironmentObject var exerciseData: ExerciseData
    @Environment(\.dismiss) var dismiss
    @Binding var workoutArray: [Workout]
    @State private var newWorkoutName = ""
    @State private var selectedExercise: Set<Exercise> = []
    
    var body: some View {
        List {
            HStack {
                TextField("Workout Name", text: $newWorkoutName)
                Button("Save", action: addWorkout)
            }
            ForEach(exerciseData.categories, id: \.name) { cat in
                Section(cat.name) {
                    ForEach(cat.exercises, id: \.self) { exerciseName in
                        HStack {
                            Text(exerciseName)
                            Spacer()
                            if selectedExercise.contains(where: { $0.name == exerciseName}) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            toggleExercisesSelection(name: exerciseName)
                        }
                    }
                }
            }
        }
    }
    
    func toggleExercisesSelection(name: String) {
        if let existingExercise = selectedExercise.first(where: { $0.name == name }) {
            selectedExercise.remove(existingExercise)
        } else {
            let newExercise = Exercise(name: name, sets: 3, repetitions: 10)
            selectedExercise.insert(newExercise)
        }
    }
    
    func addWorkout() {
        guard !newWorkoutName.isEmpty else { return }
        
            withAnimation {
                let workout = Workout(name: newWorkoutName, exercises: Array(selectedExercise))
                workoutArray.append(workout)
                newWorkoutName = ""
                selectedExercise.removeAll()
                dismiss()
        }
    }
}
#Preview {
    ExerciseList(workoutArray: .constant([]))
        .environmentObject(ExerciseData())
}

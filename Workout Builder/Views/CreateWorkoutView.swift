//
//  ContentView.swift
//  Workout Builder
//
//  Created by Cesar Fernandez on 8/15/24.
//

import SwiftUI
import SwiftData

struct CreateWorkoutView: View {
    @EnvironmentObject var exerciseData: ExerciseData
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Query var workoutArray: [Workout]
    @State private var newWorkoutName = ""
    @State private var searchExercise = ""
    @State private var customExerciseName = ""
    @State private var selectedExercise: Set<Exercise> = []
    @State private var expandedSections: Set<String> = []
    
    @State private var newSquat = ""
    @State private var newHinge = ""
    @State private var newPush = ""
    @State private var newPull = ""
    @State private var newCarry = ""
    @State private var newRotation = ""
    
    private var saveIsDisabled: Bool {
        newWorkoutName.isEmpty || selectedExercise.isEmpty
    }
    
    private var addIsDisabled: Bool {
        customExerciseName.isEmpty
    }
    
    var body: some View {
            HStack {
                TextField("Workout Name", text: $newWorkoutName)
                    .contentShape(Rectangle())
                    .contentShape(.rect(cornerRadius: 10))
                Button("Save", action: addWorkout)
                    .opacity(saveIsDisabled ? 0.5 : 1)
                    .disabled(saveIsDisabled)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 10)
            .padding(.vertical, 0)
            List {
                HStack {
                    TextField("Search Exercise", text: $searchExercise)
                }
                // For my confusing following block of code:
                // This iterates through each exercise category
                ForEach(exerciseData.categories, id: \.name) { cat in
                    // This part here shows or hides its contents based on the 'expandedSections' set
                    DisclosureGroup(isExpanded: Binding(
                        get: { expandedSections.contains(cat.name) }, // This here checks if the category is expanded
                        set: { isExpanded in
                            if isExpanded {
                                expandedSections.insert(cat.name) // This expands (adding a category to the set)
                            } else {
                                expandedSections.remove(cat.name) // This here collapses (removing the category from the set)
                            }
                        }
                    )) {
                        // This displays each exercise per category
                        ForEach(cat.exercises, id: \.self) { exerciseName in
                            HStack {
                                Text(exerciseName) // This shows the name of the exercise
                                Spacer()
                                if selectedExercise.contains(where: { $0.name == exerciseName}) {
                                    Image(systemName: "checkmark")  // This part here shows a checkmark when selected
                                        .foregroundColor(.blue)
                                }
                            }
                            .contentShape(Rectangle())      // This here makes the entire row tappable to the user
                            .onTapGesture {
                                toggleExercisesSelection(name: exerciseName)    // this toggles selection when tapped
                            }
                        }
                        // Following adds a custom exercise input for the category
                        customExerciseView(for: cat.name)
                    } label: {
                        Text(cat.name)     // This part shows the category label
                    }
                }
            }
        }
        
    @ViewBuilder
    func customExerciseView(for category: String) -> some View {
        switch category {
        case "Squat":
            customExerciseViewTextField(text: $newSquat)
        case "Hinge":
            customExerciseViewTextField(text: $newHinge)
        case "Push":
            customExerciseViewTextField(text: $newPush)
        case "Pull":
            customExerciseViewTextField(text: $newPull)
        case "Carry":
            customExerciseViewTextField(text: $newCarry)
        case "Rotation":
            customExerciseViewTextField(text: $newRotation)
        default:
            EmptyView()
        }
    }
    
        func customExerciseViewTextField (text: Binding<String>) -> some View {
            HStack {
                TextField("Custom Exercise", text: text)
                Button("Add", action: {addCustomExercise(text: text.wrappedValue)})
//                    .opacity(addIsDisabled ? 0.5 : 1)
//                    .disabled(addIsDisabled)
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
                let workout = Workout(name: newWorkoutName)
                workout.exercises = Array(selectedExercise)
                modelContext.insert(workout)
                newWorkoutName = ""
                selectedExercise.removeAll()
                dismiss()
            }
        }
        
    func addCustomExercise(text: String) {
            guard !text.isEmpty else { return }
            
            let customExercise = Exercise(name: customExerciseName, sets: 3, repetitions: 10)
            modelContext.insert(customExercise)
        }
    }

    #Preview {
        CreateWorkoutView()
            .environmentObject(ExerciseData())
    }

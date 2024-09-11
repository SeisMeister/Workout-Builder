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
    @Query var exercises: [AvailableExercise]
    @State private var newWorkoutName = ""
    
    @State private var selectedExercise: Set<AvailableExercise> = []
    @State private var expandedSections: Set<String> = []
        
    @State private var newSquat = ""
    @State private var newHinge = ""
    @State private var newPush = ""
    @State private var newPull = ""
    @State private var newCarry = ""
    @State private var newRotation = ""
    
    let heights = stride(from: 0.35, through: 1.0, by: 0.1).map { PresentationDetent.fraction($0) } // Setting a custom height for the edit reps and sets sheet
    
    private var saveIsDisabled: Bool {
        newWorkoutName.isEmpty || selectedExercise.isEmpty
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField("Workout Name", text: $newWorkoutName)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                Button("Save", action: addWorkout)
                    .disabled(saveIsDisabled)
                    .opacity(saveIsDisabled ? 0.5 : 1)
            }
            .padding()
            
            List {
                ForEach(exerciseData.categories, id: \.name) { category in
                    // This lil' chunk down here lets the user expand a category and drop it down showing the exercises
                    DisclosureGroup(isExpanded: Binding(
                        get: { expandedSections.contains(category.name) },
                        set: { isExpanded in
                            if isExpanded {
                                expandedSections.insert(category.name)
                            } else {
                                expandedSections.remove(category.name)
                            }
                        }
                    )) {
                        // Filter exercises based on the category
                        let filteredExercises = exercises.filter {
                            $0.category == category
                        }
                        
                        // loops through the exercises and has a little circle that can be checkmarked
                        ForEach(filteredExercises, id: \.self) { exercise in
                            HStack {
                                if selectedExercise.contains(exercise) {
                                    Image(systemName: "checkmark.circle")
                                        .foregroundColor(.blue)
                                } else {
                                    Image(systemName: "circle")
                                        .foregroundColor(.blue)
                                }
                                
                                // This part here displays the default sets and reps below the exercise
                                VStack(alignment: .leading){
                                    Text(exercise.name)
                                    Text("\(exercise.sets) sets, \(exercise.repetitions) reps")
                                        .font(.subheadline)
                                }
                                
                                Spacer()
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                toggleExerciseSelection(exercise: exercise) // toggling is executed in the view here
                            }
                        }
                        // Lets the user swipe to delete an exercise if wanted. Need to guard against letting user swipe to delete sample data.
                        .onDelete { indexSet in
                            deleteExercise(at: indexSet, from: filteredExercises)
                        }
                        customExerciseView(for: category)
                    } label: {
                        Text(category.name)
                    }
                }
            }
        }
    }
    
    // this bottom function gives the user the ability to create an exercise
    @ViewBuilder
    func customExerciseView(for category: ExerciseCategory) -> some View {
        HStack {
            TextField("Custom Exercise", text: customExerciseBinding(for: category))
            Button("Add", action: {
                addCustomExercise(text: customExerciseBinding(for: category).wrappedValue, category: category)
            })
        }
    }
    
    func customExerciseBinding(for category: ExerciseCategory) -> Binding<String> {
        switch category {
        case .squat: return $newSquat
        case .hinge: return $newHinge
        case .push: return $newPush
        case .pull: return $newPull
        case .carry: return $newCarry
        case .rotation: return $newRotation
        }
    }
    
    // this guy adds the custom exercise
    func addCustomExercise(text: String, category: ExerciseCategory) {
        guard !text.isEmpty else { return }
        
        // Saves it to a different data structure here, that way were not corrupting the OG data, the original exercise class.
        // Next step would be to find a way to display more set info, like resistance/weight adjustment for RT
        let customExercise = AvailableExercise(name: text, sets: 3, repetitions: 10, category: category)
        modelContext.insert(customExercise)
        customExerciseBinding(for: category).wrappedValue = ""
    }
    
    // Bottom function lets the user pick the exercise that they want
    func toggleExerciseSelection(exercise: AvailableExercise) {
        if selectedExercise.contains(exercise) {
            selectedExercise.remove(exercise)
        } else {
            selectedExercise.insert(exercise)
        }
    }
    
    func addWorkout() {
        guard !newWorkoutName.isEmpty else { return }
        
        withAnimation {
            let workout = Workout(name: newWorkoutName)
            workout.exercises = selectedExercise.map { Exercise(from: $0) }
            modelContext.insert(workout)
            newWorkoutName = ""
            selectedExercise.removeAll()
            dismiss()
        }
    }
    
    func deleteExercise(at offsets: IndexSet, from exercises: [AvailableExercise]) {
        for index in offsets {
            let exerciseToDelete = exercises[index]
            if let indexInSelected = selectedExercise.firstIndex(of: exerciseToDelete) {
                selectedExercise.remove(at: indexInSelected)
            }
            modelContext.delete(exerciseToDelete)
        }
    }
}

#Preview {
    CreateWorkoutView()
        .environmentObject(ExerciseData())
}

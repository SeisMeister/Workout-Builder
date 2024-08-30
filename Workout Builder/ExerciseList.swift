//
//  ContentView.swift
//  Workout Builder
//
//  Created by Cesar Fernandez on 8/15/24.
//

import SwiftUI

struct ExerciseList: View {
    @EnvironmentObject var exerciseData: ExerciseData
    @State private var newWorkoutName = ""
    
    var body: some View {
        List {
            HStack {
                TextField("Workout Name", text: $newWorkoutName)
//                Button("Save", action: $saveWorkout)
            }
            ForEach(exerciseData.categories, id: \.name) { cat in
                Section(cat.name) {
                    ForEach(cat.exercises, id: \.self) { exercise in
                        Text(exercise)
                    }
                }
            }
        }
    }
    
//    func saveWorkout() {
//        
//    }
}
#Preview {
    ExerciseList()
        .environmentObject(ExerciseData())
}

// Add save button at the top so user can save.
// When workout is made then it is made into a copy

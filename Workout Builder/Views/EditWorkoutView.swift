//
//  EditWorkoutView.swift
//  Workout Builder
//
//  Created by Cesar Fernandez on 9/9/24.
//

import SwiftUI
import SwiftData

struct EditWorkoutView: View {
    @Environment(\.modelContext) var modelContext
    @Binding var exercise: Exercise
    
    var body: some View {
        ZStack { // Helps for multiple view stacking
            Color(.systemGray6)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 20) {
                Text(exercise.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                HStack {
                    Text("Sets")
                    /// Lets the user adjust the sets (Int) from 1 to 10
                    Stepper(value: $exercise.sets, in: 1...10) {
                        Text("\(exercise.sets)")
                    }
                    .onChange(of: exercise.sets) { oldValue, newValue in
                        save() // saves whatever sets were set in the pop up.
                    }
                }
                .padding(.horizontal, 20)
                
                
                HStack {
                    Text("Reps")
                    /// Lets the user adjust the repetitions (Int) from 1 to 35
                    Stepper(value: $exercise.repetitions, in: 1...35) {
                        Text("\(exercise.repetitions)")
                    }
                    .onChange(of: exercise.repetitions) { oldValue, newValue in
                        save() // saves whatever sets were set in the pop up.
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 10) // Cool shadow view
            .padding(.horizontal, 20)
        }
    }
    
    func save() {
        try? modelContext.save() // Saving to the modelContext, or to the swiftData
    }
}

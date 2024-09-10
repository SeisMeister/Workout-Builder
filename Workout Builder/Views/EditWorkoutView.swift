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
        ZStack {
            Color(.systemGray6)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 20) {
                Text(exercise.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                HStack {
                    Text("Sets")
                    Stepper(value: $exercise.sets, in: 1...10) {
                        Text("\(exercise.sets)")
                    }
                    .onChange(of: exercise.sets) { oldValue, newValue in
                        save()
                    }
                }
                .padding(.horizontal, 20)
                
                
                HStack {
                    Text("Reps")
                    Stepper(value: $exercise.repetitions, in: 1...35) {
                        Text("\(exercise.repetitions)")
                    }
                    .onChange(of: exercise.repetitions) { oldValue, newValue in
                        save()
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 10)
            .padding(.horizontal, 20)
        }
    }
    
    func save() {
        try? modelContext.save()
    }
}

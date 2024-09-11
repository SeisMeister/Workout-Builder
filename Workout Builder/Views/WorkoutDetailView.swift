//
//  WorkoutDetail.swift
//  Workout Builder
//
//  Created by Cesar Fernandez on 9/5/24.
//

import SwiftUI
import SwiftData

struct WorkoutDetailView: View {
    @State private var isShowingEditWorkoutView = false
    @State private var exerciseToEdit: Exercise?
    
    let heights = stride(from: 0.35, through: 1.0, by: 0.1).map { PresentationDetent.fraction($0) }
    var workout: Workout
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(workout.exercises, id: \.name) { exercise in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(exercise.name)
                                .font(.headline)
                            Text("\(exercise.sets) sets, \(exercise.repetitions) reps")
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        
                        Button {
                            exerciseToEdit = exercise
                        } label: {
                            Text("Edit")
                        }
                        .buttonStyle(.borderless) // this lets the user tap on the edit button, even if the whole cell was tappable
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 10)
                    .padding(.vertical, 5)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle(workout.name)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: StartWorkoutView(workout: workout)) {
                        Text("Start Workout")
                    }
                }
            }
        }
        .sheet(item: $exerciseToEdit) { exercise in
            let binding = Binding(
                get: { exercise },
                set: { exerciseToEdit = $0 }
            )
            EditWorkoutView(exercise: binding)
                .presentationDetents(Set(heights))
        }
    }
}

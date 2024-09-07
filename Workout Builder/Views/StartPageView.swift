//
//  StartPage.swift
//  Workout Builder
//
//  Created by Cesar Fernandez on 8/21/24.
//
// Rename views to have view at the end of the signature of the struct.

import SwiftUI
import SwiftData

struct StartPageView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showExerciseList = false
    @State private var showWorkoutPreview = false
    @Query private var workoutArray: [Workout] = []
    
    var body: some View {
        NavigationStack {
            List {
                if !workoutArray.isEmpty {
                    Section {
                        ForEach(workoutArray, id: \.name) { workout in
                            NavigationLink {
                                WorkoutDetailView(workout: workout)
                            } label: {
                                Text(workout.name)
                            }
                        }
                        .onDelete(perform: delete)
                    }
                }
            }
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ExerciseListView()) {
                        Label("Add new workout", systemImage: "plus")
                    }
                }
            }
        }
    }
}

extension StartPageView {
    func delete(at offsets: IndexSet) {
        for index in offsets {
            let workoutToDelete = workoutArray[index]
            modelContext.delete(workoutToDelete)
        }
        try? modelContext.save()
    }
}

#Preview {
    StartPageView()
}

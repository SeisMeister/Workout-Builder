//
//  ContentView.swift
//  Workout Builder
//
//  Created by Cesar Fernandez on 8/15/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @Query private var workouts: [Workout]
    @State private var isShowingWorkoutNameField = false

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(workouts) { workout in
                    NavigationLink {
                        
                    } label: {
                        
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addWorkout) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingWorkoutNameField) {
            WorkoutScreen()
            // Left off here at 10:33 AMs
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }
    
    private func addWorkout() {
        // Work this function out, this ain't right
        withAnimation {
            let newWorkout = Workout(exercise: String(), sets: Int(), reps: Int())
            modelContext.insert(newWorkout)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

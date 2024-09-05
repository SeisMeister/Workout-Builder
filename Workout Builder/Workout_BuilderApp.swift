//
//  Workout_BuilderApp.swift
//  Workout Builder
//
//  Created by Cesar Fernandez on 8/15/24.
//

import SwiftUI
import SwiftData

@main
struct Workout_BuilderApp: App {
   static var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            Workout.self,
            Exercise.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    @StateObject var exerciseData = ExerciseData()

    var body: some Scene {
        WindowGroup {
            StartPage()
//            ExerciseList()
        }
        .environmentObject(exerciseData)
//        .modelContainer(Self.sharedModelContainer)
        .modelContainer(for: Workout.self)
   }
}

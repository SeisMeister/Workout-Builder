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
       // Possibly google how to add an enum to a model object
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            var container = try ModelContainer(for: schema, configurations: [modelConfiguration])
//            let categories = loadFromFile()
//            TODO: If statement would go somewhere in here.
//            for category in categories {
//                container.mainContext.insert(category)
//            }
            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
//    static func loadFromFile() -> [Exercise] {
//        guard let url = Bundle.main.url(forResource: "exerciseData", withExtension: "json") else {
//            print("File not found.")
//            return []
//        }
//        
//        do {
//            let data = try Data(contentsOf: url)
//            let decoder = JSONDecoder()
//            return try decoder.decode([ExerciseCategory].self, from: data)
//        } catch {
//            print("Error decoding JSON: \(error)")
//            return []
//        }
//    }

    @StateObject var exerciseData = ExerciseData()

    var body: some Scene {
        WindowGroup {
            StartPageView()
//            CreateWorkoutView()
        }
        .environmentObject(exerciseData)
//        .modelContainer(Self.sharedModelContainer)
        .modelContainer(for: Workout.self)
   }
}

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
    // like an app @State
    @AppStorage("didLoadData") static private var didLoadData = false
    
   static var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Workout.self,
            Exercise.self,
            AvaliableExercise.self
        ])
       // Possibly google how to add an enum to a model object
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            var container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            if !didLoadData {
                let dtos = loadCategoriesFromFile()
                
                for dto in dtos {
                    container.mainContext.insert(AvaliableExercise(dto: dto))
                }
                
                didLoadData = true
            }
            
            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    static func loadCategoriesFromFile() -> [AvaliableExerciseDTO] {
        guard let url = Bundle.main.url(forResource: "exerciseData", withExtension: "json") else {
            print("File not found.")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([AvaliableExerciseDTO].self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
            return []
        }
    }

    @StateObject var exerciseData = ExerciseData()

    var body: some Scene {
        WindowGroup {
            StartPageView()
//            CreateWorkoutView()
        }
        .environmentObject(exerciseData)
        .modelContainer(Self.sharedModelContainer)
//        .modelContainer(for: Workout.self)
   }
}

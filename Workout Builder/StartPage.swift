//
//  StartPage.swift
//  Workout Builder
//
//  Created by Cesar Fernandez on 8/21/24.
//

import SwiftUI

struct StartPage: View {
    @State private var newWorkoutName = ""
    @State private var newWorkout: [Workout] = []
    
    var body: some View {
        List {
            
        }
    }
    
    func addWorkout() {
        guard newWorkoutName.isEmpty == false else { return }
        
        withAnimation {
            let workout = Workout(name: newWorkoutName, exercises: <#T##[Exercise]#>)
            newWorkout.append(workout)
            newWorkoutName = ""
        }
    }
    
    func addExercisesToWorkout() {
        guard newWorkoutName.isEmpty == false else { return }
        
        withAnimation {
            let exercise = Exercise(name: <#T##String#>, sets: <#T##Int#>, repetitions: <#T##Int#>)
            newWorkout.exercises.append(workout)
            newWorkoutName = ""
        }
    }
}

//#Preview {
//    StartPage()
//}

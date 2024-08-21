//
//  ContentView.swift
//  Workout Builder
//
//  Created by Cesar Fernandez on 8/15/24.
//

import SwiftUI

struct ExerciseList: View {
    @EnvironmentObject var exerciseData: ExerciseData
    
    var body: some View {
        List {
            ForEach(exerciseData.categories, id: \.name) { cat in
                Section(cat.name) {
                    ForEach(cat.exercises, id: \.self) { exercise in
                        Text(exercise)
                    }
                }
            }
        }
    }
}
#Preview {
    ExerciseList()
        .environmentObject(ExerciseData())
}

//
//  ExerciseInWorkout.swift
//  Pocket Trainer
//
//  Created by vladukha on 15.09.2021.
//

import SwiftUI

struct ExerciseInWorkout: View {
	@State var data: [ExerciseData]
	@State var exercises = [Exercise]()
	
	
	
	func fillExercise(_ exercise: [Exercise]){
		exercises = exercise
	}
	
	
	
	var body: some View {
		//ZStack{
		//	Color("Background")
		//		.ignoresSafeArea()
		ScrollView{
			if !exercises.isEmpty {
				ForEach(data, id: \.ExerciseID){ exer in
					HStack{
						let exercise  = exercises.first(where: {$0.ExerciseId == exer.ExerciseID})
						NavigationLink(
							destination:
								ExerciseDetailView(exercise: exercise!),
							label: {
								ExerciseMuscleRowView(exercise: exercise)
							})
							.foregroundColor(.primary)
						
						Text("\(exer.SetNumber) по \(exer.RepsNumber)")
							.padding(.trailing)
						
					}
				}
			}else{
				ProgressView()
			}
		}
		.onAppear {
			if exercises.isEmpty{
				getExercises(complete: fillExercise)
			}
		}
		
		.background(Color("Background"))
	//}
	}
}


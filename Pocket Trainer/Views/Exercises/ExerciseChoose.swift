//
//  ExerciseChoose.swift
//  Pocket Trainer
//
//  Created by vladukha on 15.09.2021.
//

import SwiftUI

struct ExerciseChoose: View {
	@State var ExerciseList = [Exercise]()
	@State var Muscle: MuscleGroup

	
	func fillExercise(_ exercises: [Exercise]){
		ExerciseList = exercises
		
	}
	
	var ExerciseForMuscle: [Exercise] {
		
		let exerc = ExerciseList.filter { exercise in
			exercise.MuscleGroups.contains {$0.MuscleGroupID == Muscle.MuscleGroupID }
		}
		
		return exerc
	}
	
	var body: some View {
		//ZStack{
		//	Color("Background")
		//		.ignoresSafeArea()
		ScrollView{
			if ExerciseForMuscle.isEmpty{
					ForEach(1..<10, id:\.self){ _ in
						ExerciseMuscleRowPlaceholder()
					}
			}else {
				ForEach(ExerciseForMuscle, id: \.ExerciseId){ exercise in
					NavigationLink(
						destination:
							ExerciseDetailView(exercise: exercise),
						label: {
							ExerciseMuscleRowView(exercise: exercise)
						})
						.foregroundColor(.primary)
				}
			}
		}
		.onAppear(perform: {
			if ExerciseList.isEmpty{
				
			getExercises(complete: fillExercise)
				
			}
		})
		.navigationTitle(Muscle.Name!)
		.navigationBarTitleDisplayMode(.inline)
		.background(Color("Background"))
		//}
		
	}
	
	
}

struct ExerciseChoose_Previews: PreviewProvider {
	static var previews: some View {
		ExerciseChoose(Muscle: MuscleGroup(MuscleGroupID: 1, Name: "Musclel", ImagePath: nil))
	}
}

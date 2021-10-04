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
	
	@Environment(\.colorScheme) var colorScheme
	
	var backColor: Color{
		return colorScheme == .dark ? Color(red: 30/256, green: 32/256, blue: 34/256) : Color.white
	}
	
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
		ZStack{
		backColor
				.ignoresSafeArea()
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
		}
		
	}
	
	
}

struct ExerciseChoose_Previews: PreviewProvider {
	static var previews: some View {
		ExerciseChoose(Muscle: MuscleGroup(MuscleGroupID: 1, Name: "Musclel", ImagePath: nil))
	}
}

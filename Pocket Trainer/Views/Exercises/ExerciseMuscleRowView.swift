//
//  ExerciseRowView.swift
//  Pocket Trainer
//
//  Created by vladukha on 14.09.2021.
//

import SwiftUI

struct ExerciseMuscleRowView: View {
	@State var exercise: Exercise?
	@State var muscle: MuscleGroup?
	var imageLink: String {
		let ex = exercise?.ImagePath
		let mus = muscle?.ImagePath
		return  ex ?? mus ?? ""
	}
	
    var body: some View {
		HStack{
			AsyncImage(
				url: URL(string: imageLink)!,
				placeholder: {
					AnimatedGradient()
						.frame(width: 80, height: 80)
				}
			)
			.frame(width: 80, height: 80, alignment: .center)
			.aspectRatio(contentMode: .fit)
			.cornerRadius(15)
				.padding()
			Text(exercise?.Name ?? muscle?.Name ?? "No Name")
				.padding()
			Spacer()
		}
		.overlay(
			RoundedRectangle(cornerRadius: 16)
				.stroke(Color.gray, lineWidth: 4.0)
		)
		.padding(.leading)
		.padding(.trailing)
		.padding(.top)
		.transition(.scale)
    }
}

struct ExerciseButtonRowView: View {
	@State var exercise: Exercise
	
	var body: some View {
		HStack{
			AsyncImage(
				url: URL(string: exercise.ImagePath!)!,
				placeholder: {
					AnimatedGradient()
						.frame(width: 50, height: 50)
				}
			)
			.frame(width: 50, height: 50, alignment: .center)
			.aspectRatio(contentMode: .fit)
			.cornerRadius(15)
			Text(exercise.Name)
				.foregroundColor(Color.primary)
			Spacer()
		}
		.overlay(
			RoundedRectangle(cornerRadius: 16)
				.stroke(Color.gray, lineWidth: 4.0)
		)
		.padding(.leading)
		.padding(.trailing)
		.padding(3)
		
	}
}

//struct ExerciseRowView_Previews: PreviewProvider {
//    static var previews: some View {
//		ExerciseMuscleRowView(muscle: MuscleGroup(MuscleGroupID: 1, Name: "Cum", ImagePath: nil))
//		ExerciseMuscleRowView(exercise: Exercise(ExerciseId: 1, Name: "Name", Description: "De/Users/vladukha/Library/Mobile Documents/com~apple~CloudDocs/Alive Projects/Pocket Trainer/Pocket Trainer/Views/DebugView.fawfamkfnasijafsjnvhusngfijb ashgfsdijvha bvbaj fhuabf j ah eiufhsBVI J A V AWFJ AIEHF AHF ABURBBHABJbkjbrfij djvb a aigfj iahirbfjanf swiftxc", ImagePath: nil, MuscleGroups: [MuscleGroup(MuscleGroupID: 1, Name: nil, ImagePath: nil)]))
 //   }
//}

//
//  ExerciseMuscleRowPlaceholder.swift
//  Pocket Trainer
//
//  Created by vladukha on 22.09.2021.
//

import SwiftUI

struct ExerciseMuscleRowPlaceholder: View {
    var body: some View {
		HStack{
			AnimatedGradient()
				.frame(width: 80, height: 80)
				.padding()
                .cornerRadius(10)
			AnimatedGradient()
				.frame(width: 100, height: 60)
                .cornerRadius(10)
			Spacer()
		}
		.background(Color("Block"))
		.cornerRadius(16)
		//.overlay(
		//	RoundedRectangle(cornerRadius: 16)
		//		.stroke(Color.gray, lineWidth: 4.0)
		//)
		.padding(.leading)
		.padding(.trailing)
		.padding(.top)
		.transition(.scale)
    }
}

struct ExerciseMuscleRowPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseMuscleRowPlaceholder()
    }
}

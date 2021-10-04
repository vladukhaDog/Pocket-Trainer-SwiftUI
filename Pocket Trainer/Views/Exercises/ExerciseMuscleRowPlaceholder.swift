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
			ProgressView()
			.frame(width: 40, height: 40, alignment: .center)
			.cornerRadius(15)
				.padding()
			AnimatedGradient()
				.frame(width: 50, height: 50)
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

struct ExerciseMuscleRowPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseMuscleRowPlaceholder()
    }
}

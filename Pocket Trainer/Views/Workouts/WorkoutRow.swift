//
//  WorkoutRow.swift
//  Pocket Trainer
//
//  Created by vladukha on 15.09.2021.
//

import SwiftUI

struct WorkoutRow: View {
	@State var workout: Workout
	@State var Show = false
	
	var body: some View {
		
			VStack{
				HStack{
					AsyncImage(
						url: URL(string: workout.ImagePath!)!,
						placeholder: {
							AnimatedGradient()
								.frame(width: 100, height: 100)
								.padding()
						}
					).aspectRatio(contentMode: .fit)
					.cornerRadius(15)
					.transition(.scale)
					
					
					VStack{
						Text(workout.Name)
					}
					
					Spacer()
					Image(systemName:  "chevron.down")
						.rotationEffect(.degrees(Show ? 180 : 0))
						.foregroundColor(.blue)
						.padding(.leading)
					
				}
				.onTapGesture {
					withAnimation{
						Show.toggle()
					}
				}
				if Show{
					WorkoutDays(workout: workout)
						.transition(.move(edge: Show ? .top : .bottom).combined(with: .opacity))
						
				}
			}
			
		
			.padding()
			.background(Color("Block"))
			.cornerRadius(16)
		//.overlay(
		//	RoundedRectangle(cornerRadius: 16)
		//		.stroke(Color.gray, lineWidth: 4.0)
		//)
		.padding(.leading)
		.padding(.trailing)
		.padding(.top)
		.transition(.opacity)
	}
}

struct WorkoutRow_Previews: PreviewProvider {
	static var previews: some View {
		WorkoutRow(workout: Workout(ID: 1, Name: "cum", ImagePath: nil, WorkoutDays: [WorkoutDay(WorkoutDayID: 1, Name: nil, Exercises: nil)]))
	}
}

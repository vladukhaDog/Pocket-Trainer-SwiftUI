//
//  WorkoutDetails.swift
//  Pocket Trainer
//
//  Created by vladukha on 15.09.2021.
//

import SwiftUI

struct WorkoutDays: View {
	@State var workout: Workout
	@State var workoutDays = [WorkoutDay]()
	
	
	var Days: [WorkoutDay] {
		
		let cum = workoutDays.filter{work in
			workout.WorkoutDays.contains(where: {$0.WorkoutDayID == work.WorkoutDayID})
		}
		return cum
	}
	
	func fillWorkoutDays(workoutdays: [WorkoutDay]){
		withAnimation {
			workoutDays = workoutdays
		}
	}
	
	var body: some View {
		VStack{
			ForEach(Days, id: \.WorkoutDayID){ work in
				NavigationLink(
					destination:
						ExerciseInWorkout(data: work.Exercises!) ,
					label: {
						HStack{
							Text(work.Name!)
								.fixedSize(horizontal: false, vertical: true)
								.foregroundColor(.primary)
							Spacer()
						}
						.padding()
						.overlay(
							RoundedRectangle(cornerRadius: 16)
								.stroke(Color.gray, lineWidth: 4.0)
						)
					})
			}
		}
		.onAppear {
			if workoutDays.isEmpty{
			getWorkoutDays(complete: fillWorkoutDays)
			}
		}
	}
}

struct WorkoutDays_Previews: PreviewProvider {
	static var previews: some View {
		WorkoutDays(workout: Workout(ID: 1, Name: "Namm", ImagePath: nil, WorkoutDays: [WorkoutDay(WorkoutDayID: 1, Name: nil, Exercises: nil)]))
	}
}

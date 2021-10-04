//
//  WorkoutsView.swift
//  Pocket Trainer
//
//  Created by vladukha on 13.09.2021.
//

import SwiftUI

struct WorkoutsView: View {
	@State var workouts = [Workout]()
	
	@Environment(\.colorScheme) var colorScheme
	
	var backColor: Color{
		return colorScheme == .dark ? Color(red: 30/256, green: 32/256, blue: 34/256) : Color.white
	}
	
	func makeData(workout: [Workout]){
		withAnimation{
			workouts = workout
		}
	}
	var body: some View {
		NavigationView(){
			ZStack{
				backColor
					.ignoresSafeArea()
				ScrollView{
					if workouts.isEmpty{
						ForEach(1..<10, id:\.self){ _ in
							WorkoutRowPlaceholder()
						}
					}else{
						ForEach(workouts){ workout in
							WorkoutRow(workout: workout)
						}
						
					}
					
				}
				
			}
			.navigationTitle("Программы")
			.onAppear {
				if workouts.isEmpty{
					getWorkouts(complete: makeData)
				}
			}
		}
	}
	
}

struct WorkoutsView_Previews: PreviewProvider {
	static var previews: some View {
		WorkoutsView()
	}
}

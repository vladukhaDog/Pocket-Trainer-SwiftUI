//
//  WorkoutsView.swift
//  Pocket Trainer
//
//  Created by vladukha on 13.09.2021.
//

import SwiftUI

struct WorkoutsView: View {
	@State var workouts = [Workout]()
	

	func makeData(workout: [Workout]){
		withAnimation{
			workouts = workout
		}
	}
	
	init() {
		getWorkouts(complete: makeData)
	}
	var body: some View {
		NavigationView(){
			//ZStack{
			//	Color("Background")
			//		.ignoresSafeArea()
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
				.background(Color("Background"))
				.navigationTitle("Программы")
			}
			
		
			
		//}
	}
	
}

struct WorkoutsView_Previews: PreviewProvider {
	static var previews: some View {
		WorkoutsView()
	}
}

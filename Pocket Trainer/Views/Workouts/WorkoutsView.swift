//
//  WorkoutsView.swift
//  Pocket Trainer
//
//  Created by vladukha on 13.09.2021.
//

import SwiftUI

struct WorkoutsView: View {
	@State var workouts = [Workout]()
    @State var workoutss = 0

	func makeData(workout: [Workout]){
		withAnimation{
			workouts = workout
		}
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
                        ForEach(workouts, id:\.ID){ workout in
                            WorkoutRow(workout: workout)
                        }
                        
                    }
                    
                }
                .background(Color("Background"))
                .navigationTitle("Программы")
                .onAppear {
                    if workouts.isEmpty{
                        getWorkouts(complete: makeData)
                    }
                }
        }
			
		
			
		//}
	}
	
}

struct WorkoutsView_Previews: PreviewProvider {
	static var previews: some View {
		WorkoutsView()
	}
}

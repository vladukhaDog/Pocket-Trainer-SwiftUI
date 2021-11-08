//
//  MuscleChoose.swift
//  Pocket Trainer
//
//  Created by vladukha on 14.09.2021.
//

import SwiftUI

struct MuscleChoose: View {
	@State var MuscleList = [MuscleGroup]()
	

	
	func fillMuscles(_ muscles: [MuscleGroup]){
		MuscleList = muscles
		
	}
	var body: some View {
		NavigationView{
			//ZStack{
			//	Color("Background")
			//		.ignoresSafeArea()
				ScrollView{
					if MuscleList.isEmpty{
						ForEach(1..<10, id:\.self){ _ in
							ExerciseMuscleRowPlaceholder()
						}
						
					}else {
						ForEach(MuscleList, id: \.MuscleGroupID){ muscle in
							NavigationLink(
								destination:
									ExerciseChoose(Muscle: muscle),
								label: {
									ExerciseMuscleRowView(muscle: muscle)
								})
								.foregroundColor(.primary)
								.transition(.scale)
						}
					}
				}
				.onAppear(perform: {
					if MuscleList.isEmpty{
						
						getMuscleGroups(complete: fillMuscles)
						
					}
				})
				.navigationTitle("Мышцы")
				.background(Color("Background"))
				
			//}
		}
		
		
	}
	
}


struct MuscleChoose_Previews: PreviewProvider {
	static var previews: some View {
		MuscleChoose()
	}
}

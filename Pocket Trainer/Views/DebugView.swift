//
//  DebugView.swift
//  Pocket Trainer
//
//  Created by vladukha on 13.09.2021.
//

import SwiftUI

struct DebugView: View {
    var body: some View {
		VStack{
			Button(action: {
				getWorkoutDays(complete: {(cum: [WorkoutDay]) -> () in
					print(cum)
				})
			}, label: {
				Text("Get MuscleGroups")
			})
		}
    }
}
extension AnyTransition {
	static var moveAndScale: AnyTransition {
		AnyTransition.move(edge: .leading).combined(with: .scale)
	}
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
		DebugView()
    }
}

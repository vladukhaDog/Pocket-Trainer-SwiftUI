//
//  WorkoutRowPlaceholder.swift
//  Pocket Trainer
//
//  Created by vladukha on 22.09.2021.
//

import SwiftUI

struct WorkoutRowPlaceholder: View {
	
	var body: some View {
		
			VStack{
				HStack{
					AnimatedGradient()
                        .frame(width: 100, height: 100)
                        .cornerRadius(15)
						.padding()
					.cornerRadius(15)
					
					VStack{
						AnimatedGradient()
                            .cornerRadius(15)
					}
					
					Spacer()
					Image(systemName:  "chevron.down")
						.foregroundColor(.blue)
						.padding(.leading)
					
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

struct WorkoutRowPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutRowPlaceholder()
    }
}

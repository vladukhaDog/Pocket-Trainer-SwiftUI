//
//  AnimatedGradient.swift
//  Pocket Trainer
//
//  Created by vladukha on 22.09.2021.
//

import SwiftUI
import SDWebImageSwiftUI


struct AnimatedGradient: View{
	let UpdateDataTimer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
	
	var gradient: [Color] {
		let cum2 = cum+30
		return [Color(red: cum/256, green: cum/256, blue: cum/256), Color(red: cum2/256, green: cum2/256, blue: cum2/256)]
		
	}
	@State var startPoint = UnitPoint(x: 0, y: 0)
	@State var endPoint = UnitPoint(x: 1, y: 0)
	@State var cum = 10.0
	@State var toggler = false
	
	var body: some View {
		ZStack{
			
		RoundedRectangle(cornerRadius: 0)
				.fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: startPoint, endPoint: endPoint))
				.onReceive(UpdateDataTimer, perform: { _ in
					if toggler{
						if cum <= 50.0 {
							cum += 1.0
						}else{
							toggler.toggle()
						}
					}else{
						if cum >= 10.0 {
							cum -= 1.0
						}else{
							toggler.toggle()
							
						}
					}
					
				})
				
				}
		}
	}

//https://gist.github.com/sergeytimoshin/1dc887d0f51b0d18f7bdcbf4bd21e181

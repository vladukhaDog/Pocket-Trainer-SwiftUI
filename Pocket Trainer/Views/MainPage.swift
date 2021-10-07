//
//  MainPage.swift
//  Pocket Trainer
//
//  Created by vladukha on 14.09.2021.
//

import SwiftUI

struct MainPage: View {
	
    var body: some View {
		TabView{
			CalendarView()
				.tabItem {
					Image(systemName: "calendar")
					Text("Календарь") }
			MuscleChoose()
				.tabItem {
					Image(systemName: "list.dash")
					Text("Упражнения") }
			WorkoutsView()
				.tabItem {
					Image(systemName: "chart.bar.doc.horizontal")
					Text("Программы") }
		}
    }
}



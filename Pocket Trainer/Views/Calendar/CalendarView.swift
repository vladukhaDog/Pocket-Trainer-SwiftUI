//
//  CalendarView.swift
//  Pocket Trainer
//
//  Created by vladukha on 16.09.2021.
//

import SwiftUI

struct CalendarView: View {
	
	@StateObject var ModelView = CalendarViewModel()
	@State private var ShowExerciseChooseSheet = false
	@State private var ExerciseToAdd = SavedExercise()
	@State private var ShowClear = false
	@State private var ShowAlert = false

	
	@State private var ExerciseList = [Exercise]()
	
	func fillExercise(_ exercises: [Exercise]){
		ExerciseList = exercises
		
	}
	
	var body: some View {
		NavigationView{
			ZStack{
				Color("Background")
				.ignoresSafeArea()
				VStack{
					ZStack{
						DatePicker("Дата", selection: $ModelView.lookingDate, displayedComponents: .date)
							.datePickerStyle(GraphicalDatePickerStyle())
					}
					HStack{
						Text(ModelView.lookingDate, style: .date)
							.font(.title)
						Button {
							withAnimation{
								ShowExerciseChooseSheet.toggle()
							}
						} label: {
							VStack{
								Image(systemName: "plus.square.fill.on.square.fill")
								Text("Добавить")
								
							}
							.transition(.opacity)
						}
						.disabled(ExerciseList.isEmpty)
						
						Button {
							withAnimation{
								ShowClear.toggle()
								UIImpactFeedbackGenerator(style: .rigid).impactOccurred(intensity: 1.0)
							}
						} label: {
							Image(systemName: "chevron.up")
								.rotationEffect(.degrees(ShowClear ? 90 : -90))
								.foregroundColor(.red)
								.padding()
						}
						.hidden()
						//TODO: сделать удаление рабочим бы надо
						
						
					}
					if ShowClear{
						Button{
							ShowAlert.toggle()
							UINotificationFeedbackGenerator().notificationOccurred(.warning)
						} label: {
							Text("Стереть все данные")
								.font(.title)
								.foregroundColor(.red)
						}
						.transition(.move(edge: .trailing).combined(with: .opacity))
						.alert(isPresented:$ShowAlert) {
							Alert(
								title: Text("Вы точно хотите стереть все данные?"),
								message: Text("Это действие отменить нельзя"),
								primaryButton: .destructive(Text("Удалить")) {
									ModelView.clear()
								},
								secondaryButton: .cancel()
							)
						}
					}
					ScrollView{
						if ModelView.SavedExercises.isEmpty {
							HStack{
								Spacer()
							Text("На этот день нет записанных упражнений")
								.font(.title2)
								
								Spacer()
							}
							.transition(.move(edge: .leading))
						}
						ForEach(ModelView.SavedExercises, id:\.id){ exercise in
							ExerciseInCalenderRows(SaveExercise: exercise, vM: ModelView)
								.transition(.move(edge: .leading))
						}
					}
					
					
					Spacer()
				}
				.sheet(isPresented: $ShowExerciseChooseSheet) {
					ExerciseChooseSheet(ModelView: ModelView, ExerciseList: ExerciseList, showingSheet: $ShowExerciseChooseSheet)
						}
				.onAppear(perform: {
					if ExerciseList.isEmpty{
						getExercises(complete: fillExercise)
					}
				})
				.navigationTitle("")
				.navigationBarHidden(true)
			}
		}
		
	}
}

struct ExerciseChooseSheet: View{
	
	@State var ModelView: CalendarViewModel
	@State var ExerciseList: [Exercise]
	
	@Binding var showingSheet: Bool
	
	@State var search = ""
	
	var FilteredExercises: [Exercise]{
		ExerciseList.filter { exercise in
			return (search.isEmpty || exercise.Name.lowercased().contains(search.lowercased()))
		}
		
	}
	
	var body: some View {
		ZStack{
			Color("Background")
				.ignoresSafeArea()
			VStack{
				TextField("Поиск упражнения", text: $search)
					.padding(.trailing)
					.padding(.leading)
					.textFieldStyle(RoundedBorderTextFieldStyle())
				ScrollView{
					ForEach(FilteredExercises, id: \.ExerciseId) { exercise in
						Button {
							ModelView.add(exerciseID: exercise.ExerciseId, date: ModelView.lookingDate, weights: [], repsNumber: [])
							showingSheet.toggle()
						} label: {
						ExerciseButtonRowView(exercise: exercise)
						}
					}
				}
			}
			.padding()
			
		}
	}
}

extension View {
	func hideKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}

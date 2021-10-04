//
//  CalendarView.swift
//  Pocket Trainer
//
//  Created by vladukha on 16.09.2021.
//

import SwiftUI

struct CalendarView: View {
	
	@StateObject var ModelView = CalendarViewModel()
	@State var ShowAdder = false
	@State var ExerciseToAdd = SavedExercise(Exercise: ExerciseSavedData(ExerciseID: 1, RepsNumber: [Int]()), date: Date(), Weights: [Int]())
	
	@State var ExercId: Int = 1
	@State var SetNumber = "1"
	@State var RepNumber = "1"
	@State var search = ""
	
	@State var ShowClear = false
	@State var ShowAlert = false
	
	@Environment(\.colorScheme) var colorScheme
	
	var backColor: Color{
		return colorScheme == .dark ? Color(red: 30/256, green: 32/256, blue: 34/256) : Color.white
	}
	
	
	@State private var ExerciseList = [Exercise]()
	
	
	func fillExercise(_ exercises: [Exercise]){
		ExerciseList = exercises
		
	}
	
	var FilteredExercises: [Exercise]{
		ExerciseList.filter { exercise in
			return (search.isEmpty || exercise.Name.lowercased().contains(search.lowercased()))
		}
		
	}
	
	
	var body: some View {
		NavigationView{
			ZStack{
				backColor
				.ignoresSafeArea()
				VStack{
					ZStack{
						DatePicker("Дата", selection: $ModelView.lookingDate, displayedComponents: .date)
							.datePickerStyle(GraphicalDatePickerStyle())
							.blur(radius: ShowAdder ? 15 : 0)
							.disabled(ShowAdder)
						
						if ShowAdder{
							ZStack{
								RoundedRectangle(cornerRadius: 40)
									.fill(Color.clear)
									.overlay(
										RoundedRectangle(cornerRadius: 40)
											.stroke(Color.orange, lineWidth: 4.0)
									)
								VStack{
									
									TextField("Поиск упражнения", text: $search)
										.padding(.trailing)
										.padding(.leading)
										.textFieldStyle(RoundedBorderTextFieldStyle())
									ScrollView{
										ForEach(FilteredExercises, id: \.ExerciseId) { exercise in
											ExerciseButtonRowView(exercise: exercise, chosen: $ExercId)
										}
									}
									
									Text("Выбран: \(ExerciseList.first(where: {$0.ExerciseId == ExercId})?.Name ?? "")")
									Button {
										withAnimation{
											ModelView.add(SavedExercise(Exercise:
																			ExerciseSavedData(ExerciseID: ExercId, RepsNumber: [Int]()),
																		date: ModelView.lookingDate,
																		Weights: [Int]()))
											
											ShowAdder.toggle()
										}
									} label: {
										Text("Добавить")
											.bold()
											.padding(14)
											.overlay(
												RoundedRectangle(cornerRadius: 20)
													.stroke(Color.blue, lineWidth: 4.0)
											)
									}
									
								}
								.padding()
								
							}
							.padding()
							.transition(.move(edge: .top))
						}
					}
					HStack{
						Text(ModelView.lookingDate, style: .date)
							.font(.title)
						Button {
							withAnimation{
								ShowAdder.toggle()
							}
						} label: {
							VStack{
								Image(systemName: ShowAdder ? "arrow.down.forward.and.arrow.up.backward.circle.fill" : "plus.square.fill.on.square.fill")
								Text(ShowAdder ? "Скрыть" : "Добавить")
								
							}
							.transition(.opacity)
						}
						
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

extension View {
	func hideKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}

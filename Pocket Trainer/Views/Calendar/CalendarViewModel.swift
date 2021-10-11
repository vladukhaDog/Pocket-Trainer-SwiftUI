//
//  CalendarViewModel.swift
//  Pocket Trainer
//
//  Created by vladukha on 16.09.2021.
//

import Foundation
import SwiftUI

let generator = UINotificationFeedbackGenerator()


/**
 вью модель для календаря с упражнениями
 */
class CalendarViewModel: ObservableObject {
	let db = DataBase()
	/**Отображаемые упражнение в этом дне
	 */
	@Published var SavedExercises = [SavedExercise]()
	
	/**день, который надо отображать
	 */
	@Published var lookingDate = Date() {
		didSet{
			UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
			///дата поменялась - получаем новый список
			load()
			
		}
	}
	
	
	init(){
		load()
	}
	
	/**
	 Заполняет массив отобраэаемых упражнений из базы по дате указанной в lookingDate
	 */
	func load() {
		withAnimation{
			
			self.SavedExercises = db.getExercisesByDate(lookingDate)		}
	}
	
	/**
	 Добавляет упражнение в базу
	 - Parameter recipient:SavedExercise который будет добавлен в базу
	 */
	func add(_ exercise: SavedExercise){
		db.addExerciseToDB(exercise)
		SavedExercises.append(exercise)
		generator.notificationOccurred(.success)
	}
	
	/**
	 Изменяет существующую запись в базе данных по совпадению .id
	 - Parameter recipient: измененный SavedExercise
	 - Throws: `dbError.noEntryById(UUID)`
	 Если в базе не было найдено записи по id
	 */
	func edit(exercise: SavedExercise) throws{
		do{
			try db.edit(exercise)
		}catch{
			generator.notificationOccurred(.error)
			throw dbError.noEntryById(exercise.id)
		}
		guard let indexInArray = SavedExercises.firstIndex(where: {$0.id == exercise.id}) else {
			generator.notificationOccurred(.error)
			throw dbError.noEntryById(exercise.id)
		}
		SavedExercises[indexInArray] = exercise
		UIImpactFeedbackGenerator(style: .rigid).impactOccurred(intensity: 1.0)
		
	}
	
	/**
	 удаляет существующую запись в базе данных по совпадению .id
	 - Parameter recipient: SavedExercise который нужно удалить, ищет по .id
	 - Throws: `dbError.noEntryById(UUID)`
	 Если в базе не было найдено записи по id
	 */
	func remove(_ exercise: SavedExercise) throws{
		
		do{try db.remove(exercise)}catch{
			generator.notificationOccurred(.error)
			throw dbError.noEntryById(exercise.id)
		}
		guard let indexInArray = SavedExercises.firstIndex(where: {$0.id == exercise.id}) else {
			generator.notificationOccurred(.error)
			throw dbError.noEntryById(exercise.id)
		}
		SavedExercises.remove(at: indexInArray)
		
		UIImpactFeedbackGenerator(style: .rigid).impactOccurred(intensity: 1.0)
		
	}
	
	func clear()
	{
		db.clear()
		generator.notificationOccurred(.success)
		load()
	}
}

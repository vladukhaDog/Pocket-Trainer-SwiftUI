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
 ошибки выдаваемые базой данных
 */
enum dbError: Error {
	case noEntryById(UUID)
}

/**
 вью модель для календаря с упражнениями
 */
class CalendarViewModel: ObservableObject {
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
		if(Storage.fileExists("Exercises.json", in: .caches)){
		let temp = Storage.retrieve("Exercises.json", from: .caches, as: [SavedExercise].self)
		self.SavedExercises = temp.filter { Calendar.current.isDate($0.date, inSameDayAs: self.lookingDate)}
		}else{
			self.SavedExercises = [SavedExercise]()
		}
		}
	}
	
	/**
	 Добавляет упражнение в базу
	 - Parameter recipient:SavedExercise который будет добавлен в базу
	 */
	func add(_ exercise: SavedExercise){
		var temp = [SavedExercise]()
		if(Storage.fileExists("Exercises.json", in: .caches)){
		temp = Storage.retrieve("Exercises.json", from: .caches, as: [SavedExercise].self)
		}
		temp.append(exercise)
		Storage.store(temp, to: .caches, as: "Exercises.json")
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
		var temp = Storage.retrieve("Exercises.json", from: .caches, as: [SavedExercise].self)
		guard let indexInDB = temp.firstIndex(where: {$0.id == exercise.id}) else {
			generator.notificationOccurred(.error)
			throw dbError.noEntryById(exercise.id)
		}
		
		temp[indexInDB] = exercise
		Storage.store(temp, to: .caches, as: "Exercises.json")
		
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
		var temp = Storage.retrieve("Exercises.json", from: .caches, as: [SavedExercise].self)
		guard let indexInDB = temp.firstIndex(where: {$0.id == exercise.id}) else {
			generator.notificationOccurred(.error)
			throw dbError.noEntryById(exercise.id)
		}
		temp.remove(at: indexInDB)
		
		guard let indexInArray = SavedExercises.firstIndex(where: {$0.id == exercise.id}) else {
			generator.notificationOccurred(.error)
			throw dbError.noEntryById(exercise.id)
		}
		SavedExercises.remove(at: indexInArray)
		
		Storage.store(temp, to: .caches, as: "Exercises.json")
		UIImpactFeedbackGenerator(style: .rigid).impactOccurred(intensity: 1.0)
		
	}
	
	func clear()
	{
		Storage.clear(.caches)
		generator.notificationOccurred(.success)
		load()
	}
}

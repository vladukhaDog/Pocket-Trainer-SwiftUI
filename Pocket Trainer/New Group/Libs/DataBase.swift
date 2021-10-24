//
//  DataBase.swift
//  Pocket Trainer
//
//  Created by vladukha on 11.10.2021.
//

import Foundation

/**
 ошибки выдаваемые базой данных
 */
enum dbError: Error {
	case noEntryById(UUID)
}


class DataBase{
	
	/**
	 Возвращает из базы упражнения по указанной дате
	 - Parameter recipient: Дата по которой искать упражнения
	 */
	func getExercisesByDate(_ date: Date) -> [SavedExercise]{
		if(Storage.fileExists("Exercises.json", in: .caches)){
			let temp = Storage.retrieve("Exercises.json", from: .caches, as: [SavedExercise].self)
			return temp.filter { Calendar.current.isDate($0.date, inSameDayAs: date)}
		}else{
			return [SavedExercise]()
		}
	}
	
	/**
	 Добавляет упражнение в базу
	 - Parameter recipient:SavedExercise который будет добавлен в базу
	 */
	func addExerciseToDB(_ exercise: SavedExercise){
		var temp = [SavedExercise]()
		if(Storage.fileExists("Exercises.json", in: .caches)){
		temp = Storage.retrieve("Exercises.json", from: .caches, as: [SavedExercise].self)
		}
		temp.append(exercise)
		Storage.store(temp, to: .caches, as: "Exercises.json")
		
		
	}
	
	/**
	 Изменяет существующую запись в базе данных по совпадению .id
	 - Parameter recipient: измененный SavedExercise
	 - Throws: `dbError.noEntryById(UUID)`
				Если в базе не было найдено записи по id
	 */
	func edit(_ exercise: SavedExercise) throws{
		
		var temp = Storage.retrieve("Exercises.json", from: .caches, as: [SavedExercise].self)
		guard let indexInDB = temp.firstIndex(where: {$0.id == exercise.id}) else {
			generator.notificationOccurred(.error)
			throw dbError.noEntryById(exercise.id)
		}
		
		temp[indexInDB] = exercise
		Storage.store(temp, to: .caches, as: "Exercises.json")
		
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
		Storage.store(temp, to: .caches, as: "Exercises.json")
		
		
	}
	
	/**
	 Полностью очищает базу
	 */
	
	func clear(){
		Storage.clear(.caches)
	}
	
}



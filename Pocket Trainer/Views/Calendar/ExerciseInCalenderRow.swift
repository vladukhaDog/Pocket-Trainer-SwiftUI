//
//  ExerciseInCalenderRow.swift
//  Pocket Trainer
//
//  Created by vladukha on 18.09.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ExerciseInCalenderRows: View {
    
    @State private var ExerciseList = [Exercise]()
    @State var SaveExercise: SavedExercise
    @State var RepsToAdd = "8"
    @State var WeightToAdd = "20"
    
    @ObservedObject var vM: CalendarViewModel
    
    let columns = [
        GridItem(.adaptive(minimum: 70))
    ]
    
    var EditedExercise: SavedExercise {
        get{
            return SaveExercise
        }
        set{
            do {
                try vM.edit(exercise: newValue)
            }catch{
                
            }
        }
    }
    
    func AddRepToExercise(){
        let Exerc = SaveExercise
        Exerc.weights.append(Int(WeightToAdd) ?? 0)
        Exerc.repsNumber.append(Int(RepsToAdd) ?? 0)
        withAnimation{
            do{
                try vM.edit(exercise: Exerc)
                
            }catch dbError.noEntryById(let id){
                print("Не получилось изменить запись, так как переданный id не был найден: \(id)")
            }catch{
                print("Died")
            }
        }
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
    func RemoveRepFromExercise(){
        let Exerc = SaveExercise
        Exerc.weights.removeLast()//append(Int(WeightToAdd) ?? 0)
        Exerc.repsNumber.removeLast()//append(Int(RepsToAdd) ?? 0)
        withAnimation{
            do{
                try vM.edit(exercise: Exerc)
                
            }catch dbError.noEntryById(let id){
                print("Не получилось изменить запись, так как переданный id не был найден: \(id)")
            }catch{
                print("Died")
            }
        }
    }
    
    func fillExercise(_ exercises: [Exercise]){
        withAnimation{
            ExerciseList = exercises
        }
        
    }
    
    var ExerciseToShow: Exercise? {
        
        let exerc = ExerciseList.first(where: {$0.ExerciseId == SaveExercise.exerciseID})
        return exerc
    }
    var body: some View {
        ZStack{
            
            VStack{
                if (ExerciseToShow != nil) {
                    HStack{
                        NavigationLink(
                            destination:
                                ExerciseDetailView(exercise: ExerciseToShow!),
                            label: {
                                AnimatedImage(url: URL(string: ExerciseToShow!.ImagePath!)!)
                                    .purgeable(true)
                                    .resizable()
                                    .indicator(SDWebImageActivityIndicator.medium)
                                    .frame(width: 100, height: 100)
                                    .scaledToFit()
                                    .cornerRadius(15)
                                Text(ExerciseToShow?.Name ?? "")
                                    .font(.title3)
                                    .lineLimit(2)
                            })
                            .foregroundColor(.primary)
                            .padding(.leading)
                        Spacer()
                        VStack{
                            HStack{
                                TextField("Повторений", text: $RepsToAdd)
                                    .keyboardType(.numberPad)
                                    .disableAutocorrection(true)
                                    .textFieldStyle(.roundedBorder)
                                    .frame(width: 40)
                                Image(systemName: "repeat.circle")
                            }
                            
                            HStack{
                                TextField("Вес", text: $WeightToAdd)
                                    .keyboardType(.numberPad)
                                    .disableAutocorrection(true)
                                    .textFieldStyle(.roundedBorder)
                                    .frame(width: 40)
                                Image(systemName: "scalemass.fill")
                            }
                            
                        }
                        Button {
                            AddRepToExercise()
                        } label: {
                            Image(systemName: "plus.rectangle.fill")
                                .scaledToFit()
                        }
                        
                    }
                    .padding(.trailing)
                    
                    
                    
                    LazyVGrid(columns: columns, spacing: 30) {
                        ForEach(0..<EditedExercise.repsNumber.count, id: \.self){ i in
                            
                            VStack{
                                HStack{
                                    Spacer()
                                    Text("\(EditedExercise.weights[i])")
                                    Text("кг")
                                    Spacer()
                                }
                                Text("\(SaveExercise.repsNumber[i]) раз")
                            }
                            .transition(.move(edge: .leading).combined(with: .opacity))
                            .background(Color("Block2"))
                            .cornerRadius(16)
                            //.overlay(
                            //    RoundedRectangle(cornerRadius: 16)
                            //        .stroke(Color.gray, lineWidth: 2.0)
                            //)
                        }
                        if EditedExercise.repsNumber.count > 0 {
                            Button {
                                withAnimation{
                                    RemoveRepFromExercise()
                                }
                            } label: {
                                Image(systemName: "minus.rectangle.fill")
                                    .foregroundColor(.red)
                                    .scaledToFit()
                            }
                            .transition(.move(edge: .leading).combined(with: .opacity))
                        }
                    }
                    .padding()
                    
                    
                }else
                {
                    AnimatedGradient()
                        .transition(.opacity)
                }
                Text("\(EditedExercise.comment)")
                    .font(.footnote)
            }
            .background(Color("Block"))
            .cornerRadius(16)
            //.overlay(
            //    RoundedRectangle(cornerRadius: 16)
            //        .stroke(Color.gray, lineWidth: 4.0)
            //)
            
            .onAppear(perform: {
                if ExerciseList.isEmpty{
                    getExercises(complete: fillExercise)
                }
            })
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button {
                        withAnimation{
                            do{
                                try vM.remove(SaveExercise)
                            }catch dbError.noEntryById(let id){
                                print("Не получилось изменить запись, так как переданный id не был найден: \(id)")
                            }catch{
                                print("Died")
                            }
                        }
                    } label: {
                        Image(systemName: "trash.slash.fill")
                            .foregroundColor(.red)
                    }
                    
                }
                
            }
            .padding()
        }
        .padding(.trailing)
        .padding(.leading)
    }
}

//
//  ExerciseDetailView.swift
//  Pocket Trainer
//
//  Created by vladukha on 14.09.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ExerciseDetailView: View {
    @State var exercise: Exercise
    @State var MuscleGroupsList = [MuscleGroup]()
    @EnvironmentObject var ModelView: CalendarViewModel
    @State var comment = ""
    
    
    func FillMuscles(_ muscles: [MuscleGroup]){
        withAnimation {
            MuscleGroupsList = muscles
        }
        
    }
    var musclesForExercise: [MuscleGroup] {
        
        let musc = MuscleGroupsList.filter { muscle in
            exercise.MuscleGroups.contains {$0.MuscleGroupID == muscle.MuscleGroupID}
        }
        
        return musc
    }
    
    var body: some View {
        //ZStack{
        //	Color("Background")
        //		.ignoresSafeArea()
        ScrollView{
            AnimatedImage(url: URL(string: exercise.ImagePath!)!)
                .purgeable(true)
                .resizable()
                .indicator(SDWebImageActivityIndicator.medium)
                .scaledToFit()
                .frame(width: 300, height: 300, alignment: .center)
                .padding()
                .transition(.opacity)
            HStack{
                if musclesForExercise.isEmpty{
                    ProgressView()
                        .padding()
                        .transition(.opacity)
                    //.animation(.easeInOut(duration: 0.5))
                }else{
                    ForEach(musclesForExercise, id: \.MuscleGroupID) {muscle in
                        Text(muscle.Name ?? "cum")
                            .padding()
                            .foregroundColor(.gray)
                            .background(Color("Block"))
                            .cornerRadius(16)
                        //.overlay(
                        //	RoundedRectangle(cornerRadius: 16)
                        //		.stroke(Color.gray, lineWidth: 4.0)
                        //)
                    }
                    //.animation(.easeInOut(duration: 0.5))
                }
            }
            HStack{
                Button {
                    ModelView.add(exerciseID: exercise.ExerciseId, date: ModelView.lookingDate, weights: [], repsNumber: [], comment: comment)
                    hideKeyboard()
                } label: {
                    Text("Добавить")
                        .foregroundColor(.primary)
                        .padding(4)
                        .background(Color.gray)
                        .cornerRadius(8)
                }
                TextField("Комментарий", text: $comment)
                    .textFieldStyle(.roundedBorder)
                    .padding(20)
            }
            .padding()
            Text("Описание")
                .font(.title)
                .foregroundColor(.gray)
            Text(exercise.Description)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding()
        }
        .onAppear(perform: {
            if MuscleGroupsList.isEmpty{
                getMuscleGroups(complete: FillMuscles)
            }
        })
        .navigationTitle(exercise.Name)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color("Background"))
        //}
    }
}

struct ExerciseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseDetailView(exercise: Exercise(ExerciseId: 1, Name: "Name", Description: "Dexc", ImagePath: nil, MuscleGroups: [MuscleGroup(MuscleGroupID: 1, Name: nil, ImagePath: nil)]), MuscleGroupsList: [MuscleGroup(MuscleGroupID: 1, Name: "MyGroup", ImagePath: nil)])
    }
}

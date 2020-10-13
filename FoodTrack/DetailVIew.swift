//
//  DetailView.swift
//  FoodTrack
//
//  Created by Cedric Bahirwe on 8/18/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @State var food: Food
    @State var textForField: String = ""
    @State var barTitle = "NewMeal"
    @State var allowSaving = false
    @State var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    @EnvironmentObject var dataManager: DataManager

    var body: some View {
        GeometryReader { geometry in
            VStack {
                TextField(self.food.name, text: self.$textForField) {
                    self.food.name = self.textForField.trimmingCharacters(in: .whitespaces).count >= 2 ? self.textForField :  self.food.name
                    self.allowSaving = self.textForField.count >= 1 ? true : false
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Image(uiImage: self.food.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width - 20, height: geometry.size.width - 20 )
                    .clipped()
                
                    .onTapGesture {
                        self.showingImagePicker.toggle()
                }
                
                StarsView(rating: self.$food.rating, starsize: CGSize(width: 50, height: 50))
                
                
                if self.food.rating  == 0 && self.food.imageName == "defaultPhoto" {
                
                    Button(action: {
                        let newFood = Food(image: self.food.image, name: self.food.name, rating: self.food.rating)
                            self.dataManager.food = newFood
                            self.presentationMode.wrappedValue.dismiss()
                    }) {
                        
                        Text("Save")
                            .padding()
                            .padding(.horizontal, 50)
                            .foregroundColor(.white)
                            .background(self.food.imageName != "defaultPhoto" && self.food.name.trimmingCharacters(in: .whitespaces) != "" ? Color.blue : Color.gray)
                            .font(.system(size: 18, weight: .medium))
                    }
                    .cornerRadius(30)
                    .padding(.top, 15)
                    .allowsHitTesting(self.food.imageName != "defaultPhoto" && self.food.name.trimmingCharacters(in: .whitespaces) != "" )
                }

            }
    
            .padding(.top, 25)
            .padding(.horizontal, 10)
            Spacer()
            .navigationBarTitle(self.food.name)
            .sheet(isPresented: self.$showingImagePicker, onDismiss: self.loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .navigationBarItems(trailing:
                    Button(action: {
                        let newFood = Food(image: self.food.image, name: self.food.name, rating: self.food.rating)
                        self.dataManager.food = newFood
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }) {
                        Text("Save")
                    }
                    .disabled(self.allowSaving ? false : true)
            )
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        food.image = inputImage
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(food: Food(imageName: "defaultPhoto", name: "Enter a meal name", rating: 0)).environmentObject(DataManager())
    }
}

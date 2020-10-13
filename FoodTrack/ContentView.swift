//
//  ContentView.swift
//  FoodTrack
//
//  Created by Cedric Bahirwe on 8/18/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
import SwiftUI
import Foundation

struct ContentView: View {
    
    @State var allowEditing = false
    @State private var overText = false

    
    @EnvironmentObject var dataManager: DataManager
    
    @State var showingDetailView = false
    
    @State var foods = [Food]()
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(foods, id: \.self) { food in
                    NavigationLink(destination: DetailView(food: food)) {
                        FoodRow(food: food)
                    }
                }
            .onDelete(perform: delete)
            }
        
            .onAppear {
                  UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 85, bottom: 0, right: 0)
                self.reload()
            }
            .onReceive(dataManager.objectWillChange, perform: { _ in
                self.reload()
            })
            .navigationBarTitle("Your Meals \(foods.count)", displayMode: .inline)
                .sheet(isPresented: self.$showingDetailView, onDismiss: self.saveFood) {
                    DetailView(food: self.dataManager.food)
            }
            .navigationBarItems(leading:
                EditButton()
                , trailing:
                Button(action: {
                    self.showingDetailView.toggle()
                }) {
                    Image(systemName: "plus")
                }
            )
        }
    }
    
    func saveFood() {
        self.dataManager.food = self.dataManager.food
    }
    
     func reload() {
        print(self.dataManager.foods)

        self.foods = dataManager.foods
    }
    
    func delete(at offsets: IndexSet) {
        withAnimation {
            dataManager.foods.remove(atOffsets: offsets)
            foods.remove(atOffsets: offsets)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(DataManager())
    }
}


struct FoodRow: View {
    @State var food: Food
    @State private var overText = false

    var body: some View {
        HStack {
            Image(uiImage: food.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipped()
            VStack(alignment: .leading, spacing: 5) {
                
                Text(food.name)
                    .font(.system(size: 18, weight: .light, design: .default))
                    .foregroundColor(.green)
                    .onHover { over in
                        self.overText = over
                    }
                StarsView(rating: $food.rating)
                .allowsHitTesting(false)
            }
        }
    }
}


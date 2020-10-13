//
//  DataManager.swift
//  FoodTrack
//
//  Created by Cedric Bahirwe on 8/18/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class DataManager: ObservableObject {
    let objectWillChange = PassthroughSubject<DataManager, Never >()

    
    @Published var foods = [Food(imageName: "meal1", name: "Chicken and Potatoes", rating: 5), Food(imageName: "meal2", name: "Pasta with MeatBalls", rating: 3), Food(imageName: "meal3", name: "Sambusa", rating: 0)]
        {
        didSet {
            objectWillChange.send(self)
        }
    }
    @Published var food = Food(imageName: "defaultPhoto", name: "Enter a meal name", rating: 0) {
        didSet {
            self.append()
        }
    }
    func append() {
        self.foods.append(food)
    }
}


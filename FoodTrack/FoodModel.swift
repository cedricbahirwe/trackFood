//
//  FoodModel.swift
//  FoodTrack
//
//  Created by Cedric Bahirwe on 8/18/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import Foundation
import SwiftUI

struct Food: Identifiable, Hashable {
    let id = UUID()
    var imageName: String
    var name: String
//    {
//        didSet {
//            image = #imageLiteral(resourceName: name)
//        }
//    }
    var rating: Int
    var image: UIImage
    
    
    init(imageName: String, name: String, rating: Int) {
        self.imageName = imageName
        self.name = name
        self.rating = rating
        self.image = UIImage(imageLiteralResourceName: imageName)
    }
    
     init(image: UIImage, name: String, rating: Int) {
        self.image = image
        self.name = name
        self.rating = rating
        self.imageName =  name + "\(rating)_" + String(name.first!) + String(name.last!)

    }
}



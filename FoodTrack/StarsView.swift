//
//  StarsView.swift
//  FoodTrack
//
//  Created by Cedric Bahirwe on 8/18/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import SwiftUI


struct StarsView: View {
    @Binding var rating: Int
    @State var starsize: CGSize = CGSize(width: 30, height: 30)
    var body: some View {
        HStack {
            ForEach(0..<5) { index in
                Image(index + 1 > self.rating ? "emptyStar" : "filledStar")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: self.starsize.width, height: self.starsize.height)
                    .foregroundColor(Color.yellow)
                    .onTapGesture {
                        self.rate(at: index + 1)
                }
            }
        }
    }
    
    func rate(at index: Int) {
        
        self.rating = index == self.rating ? 0 : index
    }
}

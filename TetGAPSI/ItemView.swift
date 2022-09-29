//
//  ItemView.swift
//  TetGAPSI
//
//  Created by Sebastian TC on 28/09/22.
//

import Foundation
import SwiftUI

struct ItemView: View {
    private let model: Item
    init(model: Item) {
        self.model = model
    }
    
    var body: some View {
        ZStack {
            HStack {
                AsyncImage(
                    url: URL(string: model.image),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 80, maxHeight: 80)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                
                Spacer()
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    Text(model.name)
                        .font(.system(size: 12))
                    Text(String(model.price))
                        .font(.system(size: 14))
                        .multilineTextAlignment(.trailing)
                }
                .padding(.leading, 24)
            }
            .padding(.all, 8)
        }
    }
}

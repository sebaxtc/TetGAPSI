//
//  SuggestionView.swift
//  TetGAPSI
//
//  Created by Sebastian TC on 29/09/22.
//

import SwiftUI

struct SuggestionView: View {
    @Binding var nameSuggestions: [String]

  var body: some View {
    ForEach(
        nameSuggestions,
      id: \.self) { suggestion in
        Text(suggestion)
          .searchCompletion(suggestion)
    }
  }
}

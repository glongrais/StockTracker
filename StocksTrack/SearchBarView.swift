//
//  SearchBarView.swift
//  StocksTrack
//
//  Created by Guillaume Longrais on 23/08/2019.
//  Copyright © 2019 Guillaume Longrais. All rights reserved.
//

import SwiftUI

struct SearchBarView : UIViewRepresentable {
    
    func makeUIView(context: Context) -> UISearchBar {
        UISearchBar(frame: .zero)
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.placeholder = "Search Stocks"
    }
}

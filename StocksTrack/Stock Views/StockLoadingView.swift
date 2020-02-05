//
//  StockLoadingView.swift
//  StocksTrack
//
//  Created by Guillaume Longrais on 22/08/2019.
//  Copyright © 2019 Guillaume Longrais. All rights reserved.
//

import SwiftUI

struct StockLoadingView: View {
    var body: some View {
        HStack{
            Text("LOADING")
            ActivityIndicator(isAnimating: .constant(true), style: .large)
        }
    }
}

struct StockLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        StockLoadingView()
    }
}

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

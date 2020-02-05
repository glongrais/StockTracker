//
//  StockChartView.swift
//  StocksTrack
//
//  Created by Guillaume Longrais on 23/08/2019.
//  Copyright © 2019 Guillaume Longrais. All rights reserved.
//

import SwiftUI

struct StockChartView: View {
    
    var val: [Double]
    var keys: [String]
    @Binding var displayLegend: Bool
    var lineWidth: CGFloat
    
    var fillColor: Color {
        if(self.val.last! < self.val.first!){
            return Color.red
        }else{
            return Color.green
        }
    }
    
    var body: some View {
        
        ZStack{
            if(self.displayLegend){
                VStack(spacing: 0){
                    ZStack{
                        Rectangle()
                            .fill(Color(red: 0.95, green: 0.95, blue: 0.95))
                        GeometryReader{ geometry in
                            LineView(geometry: geometry, val: self.val)
                            PathView(geometry: geometry, fillColor: self.fillColor, val: self.val, lineWidth: self.lineWidth)
                            
                            TextView(geometry: geometry, val: self.val)
                        }
                    }
                    ZStack{
                        Rectangle()
                            .fill(Color(red: 0.85, green: 0.85, blue: 0.85))
                            .frame(height: 10)
                        GeometryReader{ geometry in
                            dateView(geometry: geometry, dates: self.keys)
                                .frame(height: 10)
                                .position(CGPoint(x:geometry.size.width/2, y: geometry.size.height))
                        }
                        .frame(height: 10)
                    }
                }
            }else{
                GeometryReader{ geometry in
                    PathView(geometry: geometry, fillColor: self.fillColor, val: self.val, lineWidth: self.lineWidth)
                }
            }
        }
    }
}

struct PathView: View {
    let geometry: GeometryProxy
    let fillColor: Color
    var val: [Double]
    let lineWidth: CGFloat
    
    var body: some View{
        let marge = (self.val.max()! - self.val.min()!)*0.05
        let val = self.val.map({self.map(x: $0, minBefore: self.val.min()!-marge, maxBefore: self.val.max()!+marge, minAfter: 0, maxAfter: Double(self.geometry.size.height))})
        return ZStack{
            Path { path in
                let step = geometry.size.width/CGFloat(self.val.count-1)
                path.move(to: CGPoint(x: 0, y: geometry.size.height))
                for i in 0..<self.val.count{
                    let point = CGPoint(x: CGFloat(i)*step,
                                        y: CGFloat(geometry.size.height) - CGFloat(val[i]))
                    path.addLine(to: point)
                }
                path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
            }.fill(LinearGradient(gradient: Gradient(colors: [self.fillColor, self.fillColor.opacity(0.1)]), startPoint: .top, endPoint: .bottom))
            
            Path { path in
                for i in 0..<self.val.count{
                    let step = geometry.size.width/CGFloat(self.val.count-1)
                    let point = CGPoint(x: CGFloat(i)*step, y: CGFloat(geometry.size.height) -  CGFloat(val[i]))
                    if(i==0){
                        path.move(to: point)
                    }else{
                        path.addLine(to: point)
                    }
                }
                
                for i in 0..<self.val.count{
                    let step = geometry.size.width/CGFloat(self.val.count-1)
                    let point = CGPoint(x: CGFloat((self.val.count-1)-i)*step, y: CGFloat(geometry.size.height) -  CGFloat(val[(self.val.count-1)-i]))
                    
                    path.addLine(to: point)
                }
                
            }
            .stroke(lineWidth: self.lineWidth)
            .fill(self.fillColor)
            
        }
    }
    
    func map(x: Double, minBefore: Double, maxBefore: Double, minAfter: Double, maxAfter: Double) -> Double{
        return (x - minBefore) * (maxAfter - minAfter) / (maxBefore - minBefore) + minAfter
    }
}

struct TextView : View {
    let geometry: GeometryProxy
    let val: [Double]
    
    var body : some View {
        let marge = (self.val.max()! - self.val.min()!)*0.05
        let val = self.val.map({self.map(x: $0, minBefore: self.val.min()!-marge, maxBefore: self.val.max()!+marge, minAfter: 0, maxAfter: Double(self.geometry.size.height))})
        let pointMax = CGPoint(x: 25, y: CGFloat(geometry.size.height) - CGFloat(val.max()!) + CGFloat(10))
        var pointMin = CGPoint(x: 25, y: CGFloat(geometry.size.height) - CGFloat(val.min()!) - CGFloat(10))
        if(pointMin.y - pointMax.y < 40){
            pointMin = CGPoint(x: 25, y: CGFloat(geometry.size.height) - CGFloat(val.min()!) + CGFloat(10))
        }
        return ZStack{
            Text(String(self.val.max()!)).font(.system(size: 10))
                .frame(width: 50, height: 20)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(5)
                .position(pointMax)
            Text(String(self.val.min()!)).font(.system(size: 10))
                .frame(width: 50, height: 20)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(5)
                .position(pointMin)
        }
    }
    
    func map(x: Double, minBefore: Double, maxBefore: Double, minAfter: Double, maxAfter: Double) -> Double{
        return (x - minBefore) * (maxAfter - minAfter) / (maxBefore - minBefore) + minAfter
    }
}

struct LineView : View {
    let geometry: GeometryProxy
    let val: [Double]
    
    var body : some View {
        let marge = (self.val.max()! - self.val.min()!)*0.05
        let val = self.val.map({self.map(x: $0, minBefore: self.val.min()!-marge, maxBefore: self.val.max()!+marge, minAfter: 0, maxAfter: Double(self.geometry.size.height))})
        return ZStack{
            Path { path in
                
                path.move(to: CGPoint(x: 0,
                                      y: CGFloat(geometry.size.height) - CGFloat(val.min()!)))
                path.addLine(to: CGPoint(x: geometry.size.width,
                                         y: CGFloat(geometry.size.height) - CGFloat(val.min()!)))
            }
            .stroke(Color.black.opacity(0.9), lineWidth: 2.5)
            
            Path { path in
                
                path.move(to: CGPoint(x: 0,
                                      y: CGFloat(geometry.size.height) - CGFloat(val.max()!)))
                path.addLine(to: CGPoint(x: geometry.size.width,
                                         y: CGFloat(geometry.size.height) - CGFloat(val.max()!)))
                
            }
            .stroke(Color.black.opacity(0.9), lineWidth: 2.5)
            
            Path { path in
                
                path.move(to: CGPoint(x: 0,
                                      y: CGFloat(geometry.size.height) - CGFloat(self.map(x: 1, minBefore: 0, maxBefore: 4, minAfter: val.min()!, maxAfter: val.max()!))))
                path.addLine(to: CGPoint(x: geometry.size.width,
                                         y: CGFloat(geometry.size.height) - CGFloat(self.map(x: 1, minBefore: 0, maxBefore: 4, minAfter: val.min()!, maxAfter: val.max()!))))
                
            }
            .stroke(Color.black.opacity(0.7))
            
            Path { path in
                
                path.move(to: CGPoint(x: 0,
                                      y: CGFloat(geometry.size.height) - CGFloat(self.map(x: 2, minBefore: 0, maxBefore: 4, minAfter: val.min()!, maxAfter: val.max()!))))
                path.addLine(to: CGPoint(x: geometry.size.width,
                                         y: CGFloat(geometry.size.height) - CGFloat(self.map(x: 2, minBefore: 0, maxBefore: 4, minAfter: val.min()!, maxAfter: val.max()!))))
                
            }
            .stroke(Color.black.opacity(0.7))
            
            Path { path in
                
                path.move(to: CGPoint(x: 0,
                                      y: CGFloat(geometry.size.height) - CGFloat(self.map(x: 3, minBefore: 0, maxBefore: 4, minAfter: val.min()!, maxAfter: val.max()!))))
                path.addLine(to: CGPoint(x: geometry.size.width,
                                         y: CGFloat(geometry.size.height) - CGFloat(self.map(x: 3, minBefore: 0, maxBefore: 4, minAfter: val.min()!, maxAfter: val.max()!))))
                
            }
            .stroke(Color.black.opacity(0.7))
            
        }
    }
    func map(x: Double, minBefore: Double, maxBefore: Double, minAfter: Double, maxAfter: Double) -> Double{
        return (x - minBefore) * (maxAfter - minAfter) / (maxBefore - minBefore) + minAfter
    }
}

struct dateView : View {
    let geometry: GeometryProxy
    let dates: [String]
    
    var body : some View {
        let step = geometry.size.width/CGFloat(dates.count-1)
        let count = self.dates.count
        let dates = self.dates.map({$0[8..<10]})
        return ZStack{
            ForEach(0..<count, id: \.self){ i in
                dateTextView(text: dates[i], posX: CGFloat(i)*step, display: self.display(prevDate: (i == 0 ? "" : dates[i-1]), date: dates[i]))
            }
        }
    }
    
    func display(prevDate: String, date: String) -> Bool {
        if(!prevDate.elementsEqual(date)){
            return true
        }else{
            return false
        }
    }
}

struct dateTextView : View {
    let text: String
    let posX: CGFloat
    let display: Bool
    
    var body : some View{
        Group{
        if(self.display){
        Text(self.text)
            .font(.system(size: 10))
            .frame(height: 10)
            .position(CGPoint(x: self.posX < 8 ? 8 : self.posX, y: 0))
        }
        }
    }
}

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
    }
}

/*struct StockChartView_Previews: PreviewProvider {
 static var previews: some View {
 StockChartView(val: [30.5, 30.0, 29.8, 10.0, 29.8, 30.0, 33.0, 30.0, 30.5, 30.0, 30.1], keys: ["2019-08-21","2019-08-22"], displayLegend: false, lineWidth: 4.0)
 }
 }*/


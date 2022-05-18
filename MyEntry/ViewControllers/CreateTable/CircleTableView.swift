//
//  CircleTableView.swift
//  MyEntry
//
//  Created by Kinjal panchal on 20/02/22.
//

import Foundation
import SwiftUI
import Combine

class Sheat: ObservableObject {
    @Published var title: String
    @Published var isFilled: Bool
    
    init(title: String = "", isFilled: Bool = false) {
        self.title = title
        self.isFilled = isFilled
    }
}

struct CircleTableView: View {
    let seats: [Sheat]
    let onClickSheet: (_ index: Int, _ sheat: Sheat) -> Void
    
    func sheetSize(_ totalSize: CGFloat) -> CGFloat {
        totalSize / 6
    }
    func circleSize(_ totalSize: CGFloat) -> CGFloat  {
        totalSize - (sheetSize(totalSize) * 2)
    }
    var totalSeats: Int {
        seats.count
    }
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ForEach(0..<totalSeats) { index in
                    SheetView(index: index, totalSeats: totalSeats, sheetSize: sheetSize(proxy.size.width), seat: seats[index], onClickSheet: onClickSheet)
                   
                }
                Color.white
                    .frame(width: circleSize(proxy.size.width), height: circleSize(proxy.size.width), alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.blue, lineWidth: 2))
            }
            .frame(width: proxy.size.width, height: proxy.size.width, alignment: .center)
            
        }
        
        
    }
}

@available(iOS 14.0, *)
struct SheetView: View {
    let index: Int
    let totalSeats: Int
    let sheetSize: CGFloat
    @StateObject var seat: Sheat
    let onClickSheet: (_ index: Int, _ sheat: Sheat) -> Void
    var body: some View {
         VStack {
            ZStack {
                Text(seat.title)
            }
            .frame(width: sheetSize, height: sheetSize)
            .padding(.top, 3)
            .cornerRadius(16, corners: [.topLeft, .topRight],
                         fill: seat.isFilled ? Color.blue : Color.clear)
            .onTapGesture {
                onClickSheet(index, seat)
            }
            Spacer()
        }
        .rotationEffect(Angle.degrees(Double(index)/Double((totalSeats)) * 360))
    }
}

struct CircleTableView_Previews: PreviewProvider {
    static var previews: some View {
        CircleTableView(seats: [.init(title: "1", isFilled: false), .init(title: "2", isFilled: true), .init(title: "3", isFilled: false), .init(title: "VIP", isFilled: false)], onClickSheet: {
            index, sheet in
            sheet.isFilled.toggle()
        }).frame(width: 300, height: 300)
    }
}


struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner, fill: Color) -> some View {
        background( RoundedCorner(radius: radius,
                                   corners: corners)
                        .stroke(Color.blue, lineWidth: 2)
                        .background(RoundedCorner(radius: radius,
                                                  corners: corners).fill(fill)))
    }
}

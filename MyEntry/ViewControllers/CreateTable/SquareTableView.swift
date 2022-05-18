//
//  SquareTableView.swift
//  MyEntry
//
//  Created by Vipul Dungranee on 23/02/22.
//

import Foundation
import SwiftUI

struct SquareTableView: View {
    
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
                    SheetViewForSquareTable(index: index, totalSeats: totalSeats, sheetSize: sheetSize(proxy.size.width), seat: seats[index], onClickSheet: onClickSheet)
                   
                }
                Color.white
                    .frame(width: circleSize(proxy.size.width), height: circleSize(proxy.size.width), alignment: .center)
                    .clipShape(Rectangle())
                    .overlay(Rectangle().stroke(Color.blue, lineWidth: 5))
            }
            .frame(width: proxy.size.width, height: proxy.size.width, alignment: .center)
            
        }
        
        
    }
}

struct SquareTableView_Previews: PreviewProvider {
    static var previews: some View {
        SquareTableView(seats: [
            .init(title: "1", isFilled: false),
            .init(title: "2", isFilled: false),
            .init(title: "3", isFilled: false),
            .init(title: "4", isFilled: false),
            .init(title: "5", isFilled: false),
            .init(title: "6", isFilled: false),
            .init(title: "7", isFilled: false),
            .init(title: "8", isFilled: false)
         ], onClickSheet: {
            index, sheet in
            sheet.isFilled.toggle()
        }).frame(width: 300, height: 300)
    }
}



@available(iOS 14.0, *)
struct SheetViewForSquareTable: View {
    let index: Int
    var totalSeats: Int
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
         .rotationEffect(Angle.degrees(getRotationValue()))
         .offset(x: getOffSet().x, y: getOffSet().y)
    }
    
    func getRotationValue() -> Double {
        print("totalSeats : \(totalSeats)")
        switch (totalSeats) {
        case (1...4):
            return setUptoFourSeatTableAngel()

        case 5:
            return setUptoFiveSeatTableAngel()
        case 6:
            return setUptoSixSeatTableAngel()
        case 7:
            return setUptoSevenSeatTableAngel()
        case 8:
            return setUptoEightSeatTableAngel()
        default:
            print("return as it is")
            return 0
        }
    }
    
    func setUptoFourSeatTableAngel() -> Double {
        let value = (360 / totalSeats)
        return Double((value - (value % 90)) * index)
    }
    
    func setUptoFiveSeatTableAngel() -> Double {
        
        if index < 2 {
            return 0
        }
        
        let value = 90
        return Double((value - (value % 90)) * (index - 1))
    }
    
    func setUptoSixSeatTableAngel() -> Double {
        
        if index < 2 {
            return 0
        } else if index < 4 {
            return 90
        }
        
        
        let value = 90
        return Double((value - (value % 90)) * (index - 2))
    }
    func setUptoSevenSeatTableAngel() -> Double {
        
        switch index {
        case 0...1 :
            return 0
        case 2...3 :
            return 90
        case 4...5 :
            return 180
        case 6...7 :
            return 270
        default :
            return 0
        }
        
    }
    
    func setUptoEightSeatTableAngel() -> Double {
        switch index {
        case 0...1 :
            return 0
        case 2...3 :
            return 90
        case 4...5 :
            return 180
        case 6...7 :
            return 270
        default :
            return 0
        }
    }
    
    /// change value of multiplier if you want to adjust space between seats
    func getOffSet(multiplier: CGFloat = 1.2) -> CGPoint {
        if totalSeats > 4 {
            
            switch totalSeats {
            case 5:
                switch index {
                case 0:
                    return CGPoint(x: -( sheetSize / multiplier), y: 0)
                case 1:
                    return CGPoint(x: ( sheetSize / multiplier), y: 0)
                default:
                    return CGPoint(x: 0, y: 0)
                }
            case 6:
                    switch index {
                    case 0:
                        return CGPoint(x: -( sheetSize / multiplier), y: 0)
                    case 1:
                        return CGPoint(x: ( sheetSize / multiplier), y: 0)
                    case 2:
                        return CGPoint(x: 0, y: -( sheetSize / multiplier))
                    case 3:
                        return CGPoint(x: 0, y: ( sheetSize / multiplier))
                    default:
                        return CGPoint(x: 0, y: 0)
                    }
            case 7:
                switch index {
                case 0:
                    return CGPoint(x: -( sheetSize / multiplier), y: 0)
                case 1:
                    return CGPoint(x: ( sheetSize / multiplier), y: 0)
                case 2:
                    return CGPoint(x: 0, y: -( sheetSize / multiplier))
                case 3:
                    return CGPoint(x: 0, y: ( sheetSize / multiplier))
                case 4:
                    return CGPoint(x: ( sheetSize / multiplier), y: 0)
                case 5:
                    return CGPoint(x: -( sheetSize / multiplier), y: 0)
                default:
                    return CGPoint(x: 0, y: 0)
                }
            case 8:
                
                    switch index {
                    case 0:
                        return CGPoint(x: -( sheetSize / multiplier), y: 0)
                    case 1:
                        return CGPoint(x: ( sheetSize / multiplier), y: 0)
                    case 2:
                        return CGPoint(x: 0, y: -( sheetSize / multiplier))
                    case 3:
                        return CGPoint(x: 0, y: ( sheetSize / multiplier))
                    case 4:
                        return CGPoint(x: ( sheetSize / multiplier), y: 0)
                    case 5:
                        return CGPoint(x: -( sheetSize / multiplier), y: 0)
                    case 6:
                        return CGPoint(x: 0, y: ( sheetSize / multiplier))
                    case 7:
                        return CGPoint(x: 0, y: -( sheetSize / multiplier))

                    default:
                        return CGPoint(x: 0, y: 0)
                    }
            default:
                return CGPoint(x: 0, y: 0)
            }
            
        }
        return CGPoint(x: 0,y: 0)
    }
}


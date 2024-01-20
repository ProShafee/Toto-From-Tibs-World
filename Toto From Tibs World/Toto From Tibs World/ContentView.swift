//
//  ContentView.swift
//  Toto From Tibs World
//
//  Created by Shafee Rehman on 20/01/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Circle()
                    .fill(Color("Orange1"))
                    .padding()
                    .frame(width: UIScreen.main.bounds.size.width)
                VStack {
                    BrowsView()
                    EyesView()
                    MouthView()
                }
            }
            ClockView()
            Spacer()
        }
        .background(
            Color.black.ignoresSafeArea(.all)
        )
    }

    struct EyesView: View {
        
        @State var leftEyeRound = 240.0
        let timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
        
        var body: some View {
            HStack {
                //left eye
                ZStack {
                    Circle()
                        .fill(Color.white)
                    Circle()
                        .fill(Color.black)
                        .frame(width: UIScreen.main.bounds.size.width / 8)
                        .offset(x: -UIScreen.main.bounds.size.width / 16)
                        .rotationEffect(.degrees(leftEyeRound))
                        .animation(.spring(duration: 1), value: leftEyeRound)
                }
                .frame(width: UIScreen.main.bounds.size.width / 4)
                //right eye
                ZStack {
                    Circle()
                        .fill(Color.white)
                    Circle()
                        .fill(Color.black)
                        .frame(width: UIScreen.main.bounds.size.width / 8)
                        .offset(x: -UIScreen.main.bounds.size.width / 16)
                        .rotationEffect(.degrees(leftEyeRound))
                        .animation(.spring(duration: 1), value: leftEyeRound)
                }
                .frame(width: UIScreen.main.bounds.size.width / 4)
            }
            .onReceive(timer) {_ in
                leftEyeRound = randomEyePosition()
            }
        }
        
        func randomEyePosition() -> Double {
            return Double.random(in: 0.0 ... 360.0)
        }
    }

    struct BrowsView: View {

        //shall be between 40 - 20
        @State var leftBrowY = -UIScreen.main.bounds.size.width / 30
        @State var rightBrowY = -UIScreen.main.bounds.size.width / 30
        
        //shall be between -10 - 10
        @State var leftBrowRotate = -3.0
        
        //shall be between 10 - 10
        @State var rightBrowRotate = 3.0
        
        let timer = Timer.publish(every: 8, on: .main, in: .common).autoconnect()
        
        var body: some View {
            HStack {
                //left
                Rectangle()
                    .fill(Color.black)
                    .cornerRadius(5)
                    .offset(x: -UIScreen.main.bounds.size.width / 40, y: leftBrowY)
                    .rotationEffect(.degrees(leftBrowRotate))
                    .frame(width: UIScreen.main.bounds.size.width / 6, height: UIScreen.main.bounds.size.width / 30)
                    .animation(.easeOut(duration: 1), value: leftBrowY)
                    .animation(.easeOut(duration: 1), value: leftBrowRotate)
                
                //right
                Rectangle()
                    .fill(Color.black)
                    .cornerRadius(5)
                    .offset(x: UIScreen.main.bounds.size.width / 40, y: rightBrowY)
                    .rotationEffect(.degrees(rightBrowRotate))
                    .frame(width: UIScreen.main.bounds.size.width / 6, height: UIScreen.main.bounds.size.width / 30)
                    .animation(.easeOut(duration: 1), value: rightBrowY)
                    .animation(.easeOut(duration: 1), value: rightBrowRotate)
            }
            .onReceive(timer) {_ in
                leftBrowY = randomBrowY()
                rightBrowY = randomBrowY()
                leftBrowRotate = randomBrowRotate()
                rightBrowRotate = randomBrowRotate()
            }
        }
        
        func randomBrowX() -> Double {
            return Double.random(in: -UIScreen.main.bounds.size.width / 30 ... -UIScreen.main.bounds.size.width / 50)
        }
        
        func randomBrowY() -> Double {
            return Double.random(in: -UIScreen.main.bounds.size.width / 20 ... -UIScreen.main.bounds.size.width / 40)
        }
        
        func randomBrowRotate() -> Double {
            return Double.random(in: -10.0 ... 10.0)
        }
    }

    struct MouthView: View {
        
        @State var smile: (topLeading: CGFloat, bottomLeading: CGFloat, bottomTrailing: CGFloat, topTrailing: CGFloat, size: SmileSize) = (50.0,50.0,50.0,50.0,.small)
        let timer = Timer.publish(every: 12, on: .main, in: .common).autoconnect()
        
        var body: some View {
            VStack{
                ZStack(alignment: .bottom){
                    UnevenRoundedRectangle(cornerRadii: .init(
                        topLeading: smile.topLeading,
                        bottomLeading: smile.bottomLeading,
                        bottomTrailing: smile.bottomTrailing,
                        topTrailing: smile.topTrailing), style: .continuous)
                    .fill(Color("Red1"))
                    .frame(width: getSmileSize(size: smile.size).width, height: getSmileSize(size: smile.size).height)
                    .animation(.easeOut(duration: 2), value: smile.topLeading)
                    .animation(.easeOut(duration: 2), value: smile.bottomLeading)
                    .animation(.easeOut(duration: 2), value: smile.bottomTrailing)
                    .animation(.easeOut(duration: 2), value: smile.topTrailing)
                    .animation(.easeOut(duration: 2), value: smile.size)
                }
            }
            .frame(height: UIScreen.main.bounds.size.width / 4)
            .onReceive(timer) {_ in
                smile = randomSmile()
            }
        }
        
        func randomSmile() -> (topLeading: CGFloat, bottomLeading: CGFloat, bottomTrailing: CGFloat, topTrailing: CGFloat, size: SmileSize) {
            let x = Int.random(in: 1...10)
            if x == 1 {
                return smallSmile()
            } else if x == 2 {
                return bigWorry()
            } else if x == 3 {
                return smallWorry()
            }
            else if x == 4 {
                return bigSmile()
            }
            else if x == 5 {
                return regularWorry()
            }
            else if x == 6 || x == 7 {
                return regularStill()
            }
            else if x == 8 || x == 9 {
                return smallStill()
            }
            else {
                return regularSmile()
            }
        }
        
        func bigSmile() -> (topLeading: CGFloat, bottomLeading: CGFloat, bottomTrailing: CGFloat, topTrailing: CGFloat, size: SmileSize) {
            return (topLeading: 5.0, bottomLeading: 100.0, bottomTrailing: 100.0, topTrailing: 5.0, size: .extraLarge)
        }
        
        func bigWorry() -> (topLeading: CGFloat, bottomLeading: CGFloat, bottomTrailing: CGFloat, topTrailing: CGFloat, size: SmileSize) {
            return (topLeading: 100.0, bottomLeading: 5.0, bottomTrailing: 5.0, topTrailing: 100.0, size: .extraLarge)
        }
        
        func smallSmile() -> (topLeading: CGFloat, bottomLeading: CGFloat, bottomTrailing: CGFloat, topTrailing: CGFloat, size: SmileSize) {
            return (topLeading: 5.0, bottomLeading: 100.0, bottomTrailing: 100.0, topTrailing: 5.0, size: .small)
        }
        
        func smallWorry() -> (topLeading: CGFloat, bottomLeading: CGFloat, bottomTrailing: CGFloat, topTrailing: CGFloat, size: SmileSize) {
            return (topLeading: 100.0, bottomLeading: 5.0, bottomTrailing: 5.0, topTrailing: 100.0, size: .small)
        }
        
        func regularSmile() -> (topLeading: CGFloat, bottomLeading: CGFloat, bottomTrailing: CGFloat, topTrailing: CGFloat, size: SmileSize) {
            return (topLeading: 5.0, bottomLeading: 100.0, bottomTrailing: 100.0, topTrailing: 5.0, size: .regular)
        }
        
        func regularWorry() -> (topLeading: CGFloat, bottomLeading: CGFloat, bottomTrailing: CGFloat, topTrailing: CGFloat, size: SmileSize) {
            return (topLeading: 100.0, bottomLeading: 5.0, bottomTrailing: 5.0, topTrailing: 100.0, size: .regular)
        }
        
        func regularStill() -> (topLeading: CGFloat, bottomLeading: CGFloat, bottomTrailing: CGFloat, topTrailing: CGFloat, size: SmileSize) {
            return (topLeading: 50.0, bottomLeading: 50.0, bottomTrailing: 50.0, topTrailing: 50.0, size: .regular)
        }
        
        func smallStill() -> (topLeading: CGFloat, bottomLeading: CGFloat, bottomTrailing: CGFloat, topTrailing: CGFloat, size: SmileSize) {
            return (topLeading: 50.0, bottomLeading: 50.0, bottomTrailing: 50.0, topTrailing: 50.0, size: .small)
        }
        
        func getSmileSize(size: SmileSize) -> (width: CGFloat, height: CGFloat) {
            switch size {
            case .small:
                return (UIScreen.main.bounds.size.width / 12,UIScreen.main.bounds.size.width / 18)
            case .regular:
                return (UIScreen.main.bounds.size.width / 5,UIScreen.main.bounds.size.width / 14)
            case .large:
                return (UIScreen.main.bounds.size.width / 3, UIScreen.main.bounds.size.width / 8)
            case .extraLarge:
                return (UIScreen.main.bounds.size.width / 2, UIScreen.main.bounds.size.width / 4)
            }
        }
        
        enum SmileSize {
            case small
            case regular
            case large
            case extraLarge
        }
    }
    
    struct ClockView: View {

        let timer = Timer.publish(
            every: 1, // second
            on: .main,
            in: .common
        ).autoconnect()

        @State var date = Date()
        
        var body: some View {
            HStack {
                Spacer()
                Text(date, style: .time)
                    .foregroundColor(.white)
                    .padding(.trailing)
                    .onReceive(timer) { (_) in
                        self.date = Date()
                    }
            }
        }
    }

}

extension Date {
    func relativeTime(in locale: Locale = .current) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}

#Preview {
    ContentView()
}

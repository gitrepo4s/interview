//
//  ContentView.swift
//

import SwiftUI
import MediaPlayer
import WebKit

struct ContentView: View {
    var timerA = PercentTimer(duration: 5) { timer, val in
        print("brightness :\(val)")
        
        if val > 20 {
            UIScreen.main.brightness = CGFloat(val / 100.0)
        }
        
        if val >= 100.0 {
            timer.restart()
        }
    }
    var timerB = PercentTimer(duration: 5) { timer, val in
        print("volume :\(val)")
        
        let volumeView = MPVolumeView()
        if let view = volumeView.subviews.first as? UISlider {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                view.value = Float(val / 100.0)
            }
        }
        
        if val >= 100.0 {
            timer.restart()
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TimerLabelView(title: "Brightness Timer", timer: timerA)
                TimerLabelView(title: "Volume Timer", timer: timerB)
                SafariView().border(.primary)
            }
            .padding(EdgeInsets(top: 100, leading: 40, bottom: 0, trailing: 40))
            
            Spacer()
        }
        .onAppear(perform: {
            
        })
    }
}

struct TimerLabelView: View {
    var title: String
    @ObservedObject var timer: PercentTimer
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.tertiary)
                .frame(maxWidth: .infinity, minHeight: 55, maxHeight: 55)
            .border(.primary)
            .overlay {
                Text(title)
            }
            .overlay(alignment: .trailing, content: {
                Text("\(Int($timer.percent.wrappedValue))%" )
                    .foregroundStyle(Color.primary)
                    .padding()
            })
            .background(alignment: .leading, content: {
                GeometryReader { geo in
                    Rectangle()
                        .fill(.primary.opacity(0.3))
                        .frame(width: geo.size.width * (CGFloat(timer.percent) / 100.0))
                }
            })
            .onTapGesture {
                if timer.running {
                    timer.stop()
                }
                else {
                    timer.start()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

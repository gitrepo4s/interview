//
//  ContentView.swift
//  InterviewCode
//

import SwiftUI
import MediaPlayer

struct ContentView: View {
    var timerA = PercentTimer(duration: 0) { val in
        if val > 20 {
            UIScreen.main.brightness = CGFloat(val / 100.0)
        }
    }
    var timerB = PercentTimer(duration: 9) { val in
        let volumeView = MPVolumeView()
        if let view = volumeView.subviews.first as? UISlider {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                view.value = Float(val / 100.0)
            }
        }
    }
    var timerC = PercentTimer(duration: 12) { val in
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                    NavigationLink(destination: DetailView(timer: timerA)) {
                        TimerLabelView(title: "Timer A", timer: timerA)
                    }
                    NavigationLink(destination: DetailView(timer: timerB)) {
                        TimerLabelView(title: "Timer B", timer: timerB)
                    }
                    NavigationLink(destination: DetailView(timer: timerC)) {
                        TimerLabelView(title: "Timer C", timer: timerC)
                    }
            }
            .padding(EdgeInsets(top: 100, leading: 40, bottom: 0, trailing: 40))
            
            Spacer()
        }
    }
}

struct TimerLabelView: View {
    var title: String
    @ObservedObject var timer: PercentTimer
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                Text(title)
                Spacer()
                
            }
            .frame(height: 55)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            
            HStack {
                Spacer()
                Text("\(Int($timer.percent.wrappedValue))%" ).padding()
            }
        }
    }
}

struct DetailView: View {
    @ObservedObject var timer: PercentTimer
    var body: some View {
        VStack {
            Button(action: {
                if timer.running {
                    timer.stop()
                }
                else {
                    timer.start()
                }
            }, label: {
                HStack {
                    Spacer()
                    Text($timer.running.wrappedValue ? "Pause" : "Start")
                    Spacer()
                }
                .contentShape(Rectangle())
                .frame(height: 55)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            })
           
            Text("\(Int($timer.percent.wrappedValue))%")
        }
        .padding(EdgeInsets(top: 100, leading: 40, bottom: 0, trailing: 40))
        Spacer()
    }
}

#Preview {
    ContentView()
}

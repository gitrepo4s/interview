//
//  Timer.swift
//  InterviewCode
//

import Foundation

class PercentTimer: ObservableObject {
    @Published var running = false
    @Published var percent: Float = 0.0
    var onTimerValueChange: ((PercentTimer, Float)->Void)?
    
    private
    var timer: Timer?,
        duration: UInt = 0,
        durationCounter = 0,
        step: Float = 0.0
    
    init(duration: UInt, onTimerValueChange: ((PercentTimer, Float) -> Void)? = nil) {
        self.duration = duration
        if duration > 0 {
            self.step = 100.0 / Float(duration)
        }
        else {
            self.step = 100.0
        }
        self.onTimerValueChange = onTimerValueChange
    }
    
    func start() {
        guard !percentReachMax() else { return }
        guard duration > 0 else {
            nextStepPercent()
            self.onTimerValueChange?(self, percent)
            return
        }
        
        let timeInterval = 1
        self.timer = Timer.scheduledTimer(withTimeInterval: Double(timeInterval), repeats: true, block: { [weak self] t in
            guard let self = self else {
                self?.timer?.invalidate()
                return
            }
            
            durationCounter += timeInterval
            nextStepPercent()
            self.onTimerValueChange?(self, percent)
            
            if percentReachMax() {
                stop()
            }
        })
        
        running = true
    }
    
    func restart() {
        stop()
        percent = 0
        durationCounter = 0
        start()
    }
    
    func nextStepPercent() {
        let nextPercent = percent + step
        if nextPercent <= 100.0 {
            percent = nextPercent
        }
        
        if duration == durationCounter {
            percent = 100.0
        }
    }
    
    func percentReachMax() -> Bool {
        return 100.0 - percent < Float.leastNormalMagnitude
    }
    
    func stop() {
        self.timer?.invalidate()
        self.timer = nil
        running = false
    }
}

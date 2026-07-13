//
        //
    //  Project: Simmer_Alarmkitdemo
    //  File: AlarmPresentation.swift
    //  Created by Noah Carpenter 
    //
    //  📺 YouTube: Noah Does Coding
    //  https://www.youtube.com/@NoahDoesCoding
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Dream Big. Code Bigger 🚀
    //

   
import AlarmKit
import SwiftUI

func makePresentation(for dishName: String) -> AlarmPresentation {
    let snoozeButton = AlarmButton(text: "5 more mins", textColor: .white, systemImageName: "clock.arrow.circlepath")
    
    let pauseButton = AlarmButton(text: "Pause", textColor: .white, systemImageName: "pause.circle.fill")
    
    let resumeButton = AlarmButton(text: "Resume", textColor: .white, systemImageName: "play.circle.fill")
    
    let alertPresentation = AlarmPresentation.Alert(title: LocalizedStringResource(stringLiteral: "\(dishName) is ready"),
                                                    secondaryButton: snoozeButton, secondaryButtonBehavior: .countdown)
    
    let countdownPresentation = AlarmPresentation.Countdown(title: LocalizedStringResource(stringLiteral: dishName), pauseButton: pauseButton)
    
    let pausedPresentation = AlarmPresentation.Paused(title: LocalizedStringResource(stringLiteral: dishName), resumeButton: resumeButton)
    
    return AlarmPresentation(alert: alertPresentation, countdown: countdownPresentation, paused: pausedPresentation)
}


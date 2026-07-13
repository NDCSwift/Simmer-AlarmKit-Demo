//
        //
    //  Project: Simmer_Alarmkitdemo
    //  File: AlarmSetup.swift
    //  Created by Noah Carpenter 
    //
    //  📺 YouTube: Noah Does Coding
    //  https://www.youtube.com/@NoahDoesCoding
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Dream Big. Code Bigger 🚀
    //

    
import AlarmKit
import SwiftUI
import AppIntents
import ActivityKit

struct StopTimerIntent: LiveActivityIntent {
    static var title: LocalizedStringResource = "Dismiss"
    @Parameter(title: "Alarm ID") var alarmID: String
    init() {}
    init(alarmID: String) { self.alarmID = alarmID }
    func perform() async throws -> some IntentResult {
        try AlarmManager.shared.stop(id: UUID(uuidString: alarmID)!)
        return .result()
    }
}


struct SnoozeTimerIntent: LiveActivityIntent {
    static var title: LocalizedStringResource = "Snooze"
    @Parameter(title: "Alarm ID") var alarmID: String
    init() {}
    init(alarmID: String) { self.alarmID = alarmID }
    func perform() async throws -> some IntentResult {
        try AlarmManager.shared.countdown(id: UUID(uuidString: alarmID)!)
        return .result()
    }
}

func makeConfiguration(id: UUID, dishName: String, method: CookingData.Method, duration: TimeInterval) -> AlarmManager.AlarmConfiguration<CookingData> {
    let metadata = CookingData(dishName: dishName, method: method)
    let presentation = makePresentation(for: dishName)
    let attributes = AlarmAttributes<CookingData>( presentation: presentation, metadata: metadata, tintColor: .purple)
    
    let countdownDuration = Alarm.CountdownDuration(preAlert: duration, postAlert: 5 * 60)
    
    return AlarmManager.AlarmConfiguration(
        countdownDuration: countdownDuration, attributes: attributes,
        stopIntent: StopTimerIntent(alarmID: id.uuidString), secondaryIntent: SnoozeTimerIntent(alarmID: id.uuidString),
        sound: .default
    )
}

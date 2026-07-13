//
        //
    //  Project: Simmer_Alarmkitdemo
    //  File: ContentView.swift
    //  Created by Noah Carpenter 
    //
    //  📺 YouTube: Noah Does Coding
    //  https://www.youtube.com/@NoahDoesCoding
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Dream Big. Code Bigger 🚀
    //

    

import SwiftUI
import AlarmKit

struct SimmerView: View {
    @State private var dishName = "Pasta"
    @State private var method = CookingData.Method.boiling
    @State private var durationMinutes = 20
    @State private var alarmID: UUID?
    @State private var isAlarmActive = false
    var body: some View {
   
        NavigationStack{
            Form{
                Section("What are you cooking "){
                    TextField("Dish Name", text: $dishName)
                    
                    Picker("Method", selection: $method){
                        Label("Boiling", systemImage: "drop.fill")
                            .tag(CookingData.Method.boiling)
                        Label("Frying", systemImage: "flame.fill")
                            .tag(CookingData.Method.frying)
                        Label("Baking", systemImage: "oven.fill")
                            .tag(CookingData.Method.baking)
                    }
                }
                Section("Timer Duration"){
                    Stepper("\(durationMinutes) minutes", value: $durationMinutes, in: 1...120)
                }
                
                Section {
                    if isAlarmActive {
                        Button("Cancel Timer", role: .destructive){
                            cancelAlarm()
                        }
                    } else {
                        Button("Start Timer"){
                            startAlarm()
                        }
                    }
                }
            }
            .navigationTitle("Simmer")
            .task { await monitorAlarms() }
            .onAppear { checkAuthorization() }
        }
        
    }
    private func checkAuthorization() {
        switch AlarmManager.shared.authorizationState {
        case .notDetermined:
            Task { try await AlarmManager.shared.requestAuthorization() }
        case .denied:
            break
        case .authorized:
            break
        @unknown default:
            break
        }
    }
    
    
    private func startAlarm() {
        let id = UUID()
        alarmID = id

        let configuration = makeConfiguration(id: id, dishName: dishName, method: method, duration: TimeInterval(durationMinutes * 60))

        Task {
            do {
                try await AlarmManager.shared.schedule(id: id, configuration: configuration)
            } catch {
                print("Failed to schedule alarm: \(error)")
                alarmID = nil
            }
        }
    }
    
    private func cancelAlarm() {
        guard let id = alarmID else { return }
        do {
            try AlarmManager.shared.cancel(id: id)
            alarmID = nil
        } catch {
            //
        }
    }
    
    private func monitorAlarms() async {
        for await alarms in AlarmManager.shared.alarmUpdates {
            if let id = alarmID {
                isAlarmActive = alarms.contains { $0.id == id }
            }
        }
    }
}

#Preview {
    SimmerView()
}

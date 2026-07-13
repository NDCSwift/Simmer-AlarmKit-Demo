//
        //
    //  Project: Simmer_Alarmkitdemo
    //  File: SimmerWidgetLiveActivity.swift
    //  Created by Noah Carpenter 
    //
    //  📺 YouTube: Noah Does Coding
    //  https://www.youtube.com/@NoahDoesCoding
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Dream Big. Code Bigger 🚀
    //

    

import ActivityKit
import WidgetKit
import SwiftUI
import AlarmKit

struct SimmerWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: AlarmAttributes<CookingData>.self) { context in
            lockScreenView(context: context)
                .padding()
                .activityBackgroundTint(Color.purple.opacity(0.15))
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading){
                    alarmIcon(context: context)
                }
                DynamicIslandExpandedRegion(.center) {
                    Text(context.attributes.metadata?.dishName ?? "Cooking")
                        .font(.headline)
                        .lineLimit(1)
                }
                DynamicIslandExpandedRegion(.trailing){
                    timerText(context: context)
                }
            }compactLeading: {
                alarmIcon(context: context)
                    .imageScale(.small)
            }
            compactTrailing: {
                timerText(context: context)
                
            } minimal: {
                alarmIcon(context: context)
                    .imageScale(.small)
            }
        }
    }
}


private extension SimmerWidgetLiveActivity {
    func alarmIcon(context: ActivityViewContext<AlarmAttributes<CookingData>>) -> some View {
        let symbolName = context.attributes.metadata?.method.rawValue ?? "flame.fill"
        return Image(systemName: symbolName)
            .foregroundStyle(.purple)
        
    }
    
    @ViewBuilder
    func timerText(context: ActivityViewContext<AlarmAttributes<CookingData>>) -> some View {
        switch context.state.mode {
        case .alert(let info):
            EmptyView()
        case .countdown(let info):
            Text(info.fireDate, style: .timer)
                .monospacedDigit()
                .font(.caption)
        case .paused(let info):
            let remaining = info.totalCountdownDuration - info.previouslyElapsedDuration
            Text(Duration.seconds(remaining), format: .time(pattern: .minuteSecond))
                .monospacedDigit()
                .font(.caption)
            
        @unknown default:
            Text("--:--")
                .font(.caption)
        }
    }
    
    @ViewBuilder
    func lockScreenView(context: ActivityViewContext<AlarmAttributes<CookingData>>) -> some View {
        switch context.state.mode {
        case .alert(let alert):
            EmptyView()
        case .countdown(let countdown):
            countdownLockScreen(context: context)
        case .paused(let paused):
            pausedLockScreen(context: context)
            @unknown default:
            EmptyView()
        }
    }
    
    func countdownLockScreen(context: ActivityViewContext<AlarmAttributes<CookingData>>) -> some View {
        HStack{
            alarmIcon(context: context)
                .font(.callout)
            VStack{
                Text(context.attributes.metadata?.dishName ?? "Cooking")
                    .font(.headline)
                Text("Time Remaining")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            timerText(context: context)
                .font(.title)
                .fontWeight(.semibold)
        }
    }
    
    func pausedLockScreen(context: ActivityViewContext<AlarmAttributes<CookingData>>) -> some View {
        HStack{
            alarmIcon(context: context)
                .font(.callout)
            VStack{
                Text(context.attributes.metadata?.dishName ?? "Cooking")
                    .font(.headline)
                Text("Paused")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "pause.circle.fill")
                .foregroundStyle(.orange)
                .font(.title2)
        }
    }
 
}

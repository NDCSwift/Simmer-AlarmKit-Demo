# ⏲️ Simmer — AlarmKit Cooking Timer Demo

A SwiftUI demo app that uses Apple's **AlarmKit** framework to turn a simple cooking timer into a system-level alarm with Live Activity, Dynamic Island, and Lock Screen support.

---

## 🤔 What this is

Simmer is a minimal cooking timer built to demonstrate **AlarmKit** (iOS 26+) end to end — scheduling a countdown timer, presenting it through a widget extension on the Lock Screen and Dynamic Island, and handling Stop/Snooze actions via App Intents. It's the companion project for the AlarmKit tutorial on the NoahDoesCoding YouTube channel.

## ✅ Why you'd use it

- **Real AlarmKit configuration** — see a working `AlarmManager.AlarmConfiguration` with a countdown duration, snooze (postAlert) support, and custom stop/secondary intents, instead of a toy example.
- **Widget extension included** — a full `ActivityConfiguration` implementation showing Lock Screen and Dynamic Island (compact/minimal/expanded) layouts driven by `AlarmPresentationState`.
- **A real bug fixed in the open** — this repo includes the fix for a subtle AlarmKit timing bug (see Notes below) that caused timers to fire late and never show a Live Activity, so you can avoid it in your own project.

## 📺 Watch on YouTube

[![Watch on YouTube](https://img.shields.io/badge/YouTube-Watch%20the%20Tutorial-red?style=for-the-badge&logo=youtube)](https://youtu.be/mxm9hF1wSlA)

> This project was built for the [NoahDoesCoding YouTube channel](https://www.youtube.com/@NoahDoesCoding).

---

## 🚀 Getting Started

### 1. Clone

```bash
git clone https://github.com/NDCSwift/Simmer-AlarmKit-Demo.git
```

### 2. Open

Open `Simmer_Alarmkitdemo.xcodeproj` in Xcode.

### 3. Team

Select the `Simmer_Alarmkitdemo` and `SimmerWidgetExtension` targets and set **Signing & Capabilities → Team** to your own Apple Developer account.

### 4. Bundle ID

Update the bundle identifiers (`com.example.Simmer-Alarmkitdemo` and `com.example.Simmer-Alarmkitdemo.SimmerWidget`) to your own reverse-DNS prefix — the widget extension's ID must stay nested under the app's ID.

## 🛠️ Notes

- **AlarmKit is unreliable on Simulator.** Dynamic Island, Lock Screen Live Activities, and even alarm sound/vibration behave inconsistently in the iOS Simulator. Always test AlarmKit features on a physical device running iOS 26+.
- **The late-firing / missing Live Activity fix:** the original `makeConfiguration` set both `schedule: .fixed(Date().addingTimeInterval(duration))` *and* `countdownDuration.preAlert = duration`. Since `schedule` controls when the alarm starts counting down and `preAlert` controls how long that countdown lasts, stacking both roughly **doubled** the wait before the alarm fired — and the widget shows nothing at all until the countdown state actually begins, so the Live Activity appeared to be missing for that entire first wait. The fix: for a pure duration-based timer, leave `schedule` as `nil` and only set `countdownDuration`, so the countdown starts immediately and fires after exactly `preAlert` seconds.
- Also make sure `NSSupportsLiveActivities` is set to `true` in the host app's Info.plist — AlarmKit's countdown/paused UI is a real Live Activity under the hood and won't render reliably without it.

## 📦 Requirements

- Xcode 17+
- iOS 26+ / iPadOS 26+ (AlarmKit is unavailable on earlier versions)
- A physical iPhone or iPad for testing Live Activities and Dynamic Island

---

📺 [Watch the guide on YouTube](https://youtu.be/mxm9hF1wSlA)

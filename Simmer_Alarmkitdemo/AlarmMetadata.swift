//
        //
    //  Project: Simmer_Alarmkitdemo
    //  File: AlarmMetadata.swift
    //  Created by Noah Carpenter 
    //
    //  📺 YouTube: Noah Does Coding
    //  https://www.youtube.com/@NoahDoesCoding
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Dream Big. Code Bigger 🚀
    //

   
import AlarmKit

struct CookingData: AlarmMetadata {
    let dishName: String
    let method: Method
    
    enum Method: String, Codable {
        case frying = "flame.fill"
        case boiling = "drop.fill"
        case baking = "oven.fill"
    }
}


//
//  Current.swift
//  Stormy
//
//  Created by David Thompson on 16/11/2014.
//  Copyright (c) 2014 VS. All rights reserved.
//

import Foundation
import UIKit

struct Current {
    
    var currentTime: String?
    var temperature: Int?
    var humidity: Double
    var precipProbability: Double
    var summary: String
    var icon: UIImage?
    
    init(weatherDictionary: NSDictionary) {
        let currentWeather = weatherDictionary["currently"] as NSDictionary
        
        humidity = currentWeather["humidity"] as Double
        precipProbability = currentWeather["precipProbability"] as Double
        summary = currentWeather["summary"] as String
        
        let tempratureInFarenheit = currentWeather["temperature"] as Int
        temperature = convertFarenheitToCelsius(tempratureInFarenheit)
        
        let currentTimeIntValue = currentWeather["time"] as Int
        currentTime = dateStringFromUnixTime(currentTimeIntValue)
        
        let iconString = currentWeather["icon"] as String
        icon = weatherIconFromString(iconString)
    }
    
    func dateStringFromUnixTime(unixTime: Int) -> String {
        let timeInSeconds = NSTimeInterval(unixTime)
        let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter.stringFromDate(weatherDate)
    }
    
    func weatherIconFromString(stringIcon: String) -> UIImage {
        var imageName: String
        switch stringIcon {
            case "clear-day": imageName = "clear-day"
            case "clear-night": imageName = "clear-night"
            case "rain": imageName = "rain"
            case "snow": imageName = "snow"
            case "sleet": imageName = "sleet"
            case "wind": imageName = "wind"
            case "fog": imageName = "fog"
            case "cloudy": imageName = "cloudy"
            case "partly-cloudy-day": imageName = "partly-cloudy"
            case "partly-cloudy-night": imageName = "cloudy-night"
            default: imageName = "default"
        }
        var iconImage = UIImage(named: imageName)!
        return iconImage
    }
    
    func convertFarenheitToCelsius(temperature: Int) -> Int {
        return (temperature - 32) * 5 / 9
    }
    
    
}
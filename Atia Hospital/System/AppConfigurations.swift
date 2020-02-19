//
//  AppConfigurations.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 10/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import Foundation

/// Main configurations for the app containing the logic from loading the properties from `Info.plist` file.
/// Contains main access point for the API keys, network urls, etc.
final class AppConfigurations {
    
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
    
    lazy var appVersion: String? = {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }()
    
}

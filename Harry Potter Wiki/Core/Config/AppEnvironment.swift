//
//  Environment.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import Foundation

enum AppEnvironment {
    enum Keys {
        static let apiBaseURL = "API_BASE_URL"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    static var apiBaseURL: URL {
        guard let urlString = infoDictionary[Keys.apiBaseURL] as? String else {
            fatalError("API_BASE_URL not set in Info.plist")
        }
        
        guard let url = URL(string: urlString) else {
            fatalError("API_BASE_URL is not a valid URL")
        }
        
        return url
    }
}

//
//  AppNavigation.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 25/11/25.
//

import SwiftUI

@Observable
class Router {
    var path: NavigationPath = .init()
    
    func navigateTo(route: AppRoute) {
        path.append(route)
    }
    
    func backToHome() {
        path = .init()
    }
}

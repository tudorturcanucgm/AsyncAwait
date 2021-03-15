//
//  AsyncAwaitApp.swift
//  AsyncAwait
//
//  Created by Tudor Turcanu on 15.03.2021.
//

import SwiftUI

@main
struct AsyncAwaitApp: App {
    let motivation = Motivation()
    init() {
        runExample()
    }
    func runExample() {
        motivation.greetUserAwait()
        motivation.greetUserAsync()
        NetworkRequest.init().getData()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

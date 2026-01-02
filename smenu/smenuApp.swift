import SwiftUI
import AppKit

@main
struct SpotlightSearchApp:  App {
    // Connect our AppDelegate
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        // Return Settings to prevent a default window from spawning
        Settings {}
    }
}

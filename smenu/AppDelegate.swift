//
//  AppDelegate.swift
//  smenu
//
//  Created by Anton Hölscher on 2026-01-02.
//


// AppDelegate.swift
import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var panel: NSPanel!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create the panel (floating window)
        panel = NSPanel(
            contentRect: NSRect(x: 0, y: 0, width: 600, height: 80),
            styleMask: [.nonactivatingPanel, .titled, .resizable, .closable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        
        // Spotlight-like styling
        panel.isFloatingPanel = true
        panel.titleVisibility = .hidden
        panel.titlebarAppearsTransparent = true
        panel.isMovableByWindowBackground = false // Fixed position like Spotlight
        panel.standardWindowButton(.closeButton)?.isHidden = true
        panel.standardWindowButton(.miniaturizeButton)?.isHidden = true
        panel.standardWindowButton(.zoomButton)?.isHidden = true
        panel.backgroundColor = .clear // Important for the glass effect
        panel.level = .floating // Keep it above other windows
        panel.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        
        // Set the SwiftUI content
        let contentView = SpotlightView(window: panel)
        panel.contentView = NSHostingView(rootView: contentView)
        
        // Center and show
        panel.center()
        panel.orderFront(nil)
        panel.makeKey()
    }
}

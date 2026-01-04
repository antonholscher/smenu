import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var panel: NSPanel!
    var database: [String] = []
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Read from stdin
        database = readStdin()
        
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
        panel.isMovableByWindowBackground = false
        panel.standardWindowButton(.closeButton)?.isHidden = true
        panel.standardWindowButton(.miniaturizeButton)?.isHidden = true
        panel.standardWindowButton(.zoomButton)?.isHidden = true
        panel.backgroundColor = .clear
        panel.level = .floating
        panel.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        
        // Set the SwiftUI content
        let contentView = SpotlightView(window: panel, database: database)
        panel.contentView = NSHostingView(rootView: contentView)

        // Center and show
        panel.center()
        panel.orderFront(nil)
        panel.makeKey()
        panel.makeFirstResponder(panel.contentView)

    }
    
    private func readStdin() -> [String] {
        var lines: [String] = []
        
        // Check if stdin is a pipe/file (not a terminal)
        if isatty(fileno(stdin)) == 0 {
            while let line = readLine() {
                let trimmed = line.trimmingCharacters(in: .whitespaces)
                if !trimmed.isEmpty {
                    lines.append(trimmed)
                }
            }
        }
        
        return lines.isEmpty ? defaultDatabase() : lines
    }

    
    private func defaultDatabase() -> [String] {
        [
            "System Settings", "Terminal", "Activity Monitor", "Xcode",
            "Safari", "Notes", "Messages", "Mail", "Photos", "Calendar",
            "Music", "Podcasts", "TV", "News", "Stocks", "Weather"
        ]
    }
}


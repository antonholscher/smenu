import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var panel: NSPanel!
    var database: [String] = []
    var isPasswordMode: Bool = false
    var placeholderText: String = "Select something"
    var iconName: String = "bolt.fill"
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Check for -e flag
        isPasswordMode = CommandLine.arguments.contains("-e")
        
        // Check for -t flag with custom placeholder
        if let tIndex = CommandLine.arguments.firstIndex(of: "-t"),
           tIndex + 1 < CommandLine.arguments.count {
            placeholderText = CommandLine.arguments[tIndex + 1]
        }
        
        // Check for -i flag with custom placeholder
        if let iIndex = CommandLine.arguments.firstIndex(of: "-i"),
           iIndex + 1 < CommandLine.arguments.count {
            iconName = CommandLine.arguments[iIndex + 1]
        }
        
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
        panel.standardWindowButton(.closeButton)?.isHidden = true
        panel.standardWindowButton(.miniaturizeButton)?.isHidden = true
        panel.standardWindowButton(.zoomButton)?.isHidden = true
        // Hide title bar completely
        if let titlebarView = panel.standardWindowButton(.closeButton)?.superview?.superview {
            titlebarView.isHidden = true
        }
        
        panel.isMovableByWindowBackground = false
        panel.standardWindowButton(.closeButton)?.isHidden = true
        panel.standardWindowButton(.miniaturizeButton)?.isHidden = true
        panel.standardWindowButton(.zoomButton)?.isHidden = true
        panel.backgroundColor = .clear
        panel.level = .floating
        panel.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        
        // Set the SwiftUI content
        let contentView = SpotlightView(window: panel, database: database, isSearchMode: database.isEmpty, isPasswordMode: isPasswordMode, placeholderText: placeholderText, iconName: iconName)
        panel.contentView = NSHostingView(rootView: contentView)
        
        // Center and show
        panel.center()
        panel.orderFront(nil)
        panel.makeKey()
        panel.makeFirstResponder(panel.contentView)
        panel.delegate = self
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
        
        return lines
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}


extension AppDelegate: NSWindowDelegate {
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSApplication.shared.terminate(NSNumber(value: -1))
        return false
    }
}

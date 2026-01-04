// SpotlightView.swift
import SwiftUI
import Combine

struct SpotlightView: View {
    let window: NSPanel?
    let database: [String]
    let isSearchMode: Bool
    let isPasswordMode: Bool
    let placeholderText: String
    
    @State private var searchText = ""
    @State private var contentSize: CGSize = CGSize(width: 600, height: 10)
    @State private var selectedIndex: Int = 0
    @FocusState private var isFocused: Bool
    
    // Filter logic
    var results: [String] {
        if isSearchMode {
            // In search mode, just return the input text
            return searchText.isEmpty ? [] : [searchText]
        } else {
            // In filter mode, filter the database
            if searchText.isEmpty { return [] }
            return database.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Input Field
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.secondary)
                
                if isPasswordMode {
                    SecureField(placeholderText, text: $searchText)
                            .textFieldStyle(.plain)
                            .font(.system(size: 22, weight: .light))
                            .frame(height: 40)
                            .focused($isFocused)
                } else {
                    SecureField(placeholderText, text: $searchText)
                            .textFieldStyle(.plain)
                            .font(.system(size: 22, weight: .light))
                            .frame(height: 40)
                            .focused($isFocused)
                }
            }
            .padding(10)
            
            // Results List
            if !results.isEmpty && !isSearchMode {
                Divider()
                    .background(Color.white.opacity(0.2))
                
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(Array(results.enumerated()), id: \.offset) { index, item in
                        HStack {
                            Image(systemName: "app.fill")
                                .foregroundColor(.blue)
                            Text(item)
                                .font(.title3)
                            Spacer()
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(selectedIndex == index ? Color.white.opacity(0.2) : Color.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            print(item)
                            fflush(stdout)
                            NSApplication.shared.terminate(nil)
                        }
                    }
                }
                .padding(.vertical, 10)
            }
        }
        .frame(width: 600)
        .background(VisualEffectView(material: .hudWindow, blendingMode: .behindWindow))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
            updateWindowSize()
        }
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
            updateWindowSize()
        }
        .onKeyPress { press in
            if press.key == .upArrow {
                selectedIndex = max(0, selectedIndex - 1)
                return .handled
            } else if press.key == .downArrow {
                selectedIndex = min(results.count - 1, selectedIndex + 1)
                return .handled
            } else if press.key == .return && selectedIndex >= 0 {
                print(results[selectedIndex])
                fflush(stdout)
                NSApplication.shared.terminate(nil)
                return .handled
            }
            return .ignored
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isFocused = true
            }
        }
    }
    
    private func updateWindowSize() {
        guard let window = window else { return }
        
        // Calculate size with padding
        let estimatedHeight = calculateContentHeight()
        
        let newSize = CGSize(width: 600, height: estimatedHeight)
        guard newSize != contentSize else { return }
        
        contentSize = newSize
        
        let currentFrame = window.frame
        let newY = currentFrame.maxY - estimatedHeight
        
        window.setFrame(
            NSRect(x: currentFrame.minX, y: newY, width: 600, height: estimatedHeight),
            display: true,
            animate: true
        )
    }
    
    private func calculateContentHeight() -> CGFloat {
        let inputHeight: CGFloat = 80 // 40 height + 20 padding top + 20 bottom
        
        if results.isEmpty {
            return inputHeight
        }
        
        let dividerHeight: CGFloat = 1
        let itemHeight: CGFloat = CGFloat(results.count) * 40 // 10 padding + ~20 text + 10 padding
        let resultsPadding: CGFloat = 20 // 10 top + 10 bottom
        
        return inputHeight + dividerHeight + itemHeight + resultsPadding
    }
}

// The "Glass" Background Effect
struct VisualEffectView: NSViewRepresentable {
    var material: NSVisualEffectView.Material
    var blendingMode: NSVisualEffectView.BlendingMode
    
    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = material
        view.blendingMode = blendingMode
        view.state = .active
        return view
    }
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        nsView.material = material
        nsView.blendingMode = blendingMode
    }
}

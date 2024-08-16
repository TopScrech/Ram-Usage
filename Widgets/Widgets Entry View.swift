import SwiftUI
import WidgetKit

struct WidgetsEntryView: View {
    var entry: Provider.Entry
    
    var version: String {
        let dick = Bundle.main.infoDictionary
        let version = dick?["CFBundleShortVersionString"] as? String ?? ""
        let build = dick?["CFBundleVersion"] as? String ?? ""
        
        return "\(version) (B\(build))"
    }
    
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
            
            HStack(alignment: .bottom) {
                VStack {
                    Text("Memory")
                        .title(.semibold)
                        .rounded()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ProgressView(value: 1, total: 2)
                        .scaleEffect(x: 1, y: 2)
                }
                
                let used = "5 GB"
                RamSpec("Usage", ram: used)
                    .offset(y: 10)
                
                let free = "5 GB"
                RamSpec("Free", ram: free)
                    .offset(y: 10)
            }
            
            Divider()
            
            HStack(spacing: 15) {
                let appMemory = "5 GB"
                RamSpec("App", ram: appMemory)
                
                let wired = "5 GB"
                RamSpec("Wired", ram: wired)
                
                let compressed = "5 GB"
                RamSpec("Compressed", ram: compressed)
                
                Divider()
                    .frame(maxHeight: 40)
                
                let cachedFiles = "5 GB"
                RamSpec("Cached Files", ram: cachedFiles)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .top) {
            HStack {
                Text(version)
                
                Spacer()
                
                Text(entry.date, format: .dateTime.hour().minute().second())
            }
            .footnote()
            .foregroundStyle(.tertiary)
        }
    }
}

struct RamSpec: View {
    private let name: String
    private let ram: String
    
    init(_ name: String, ram: String) {
        self.name = name
        self.ram = ram
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
                .footnote()
                .foregroundStyle(.secondary)
            
            Text(ram)
        }
        .padding(5)
    }
}

//#Preview(as: .systemMedium) {
//    Widgets()
//} timeline: {
//    MemoryEntry(date: Date(), configuration: .init())
//}

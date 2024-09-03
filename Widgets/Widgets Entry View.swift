import SwiftUI
import WidgetKit

struct WidgetsEntryView: View {
    var entry: Provider.Entry
    
    var version: String {
        let dick = Bundle.main.infoDictionary
        let version = dick?["CFBundleShortVersionString"] as? String ?? ""
        let build = dick?["CFBundleVersion"] as? String ?? ""
        
        return "v\(version) (B\(build))"
    }
    
    var ram: MemoryUsage {
        entry.memory
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
                        .frame(maxWidth: 200)
                }
                
                RamSpec("Usage", ram: ram.used)
                    .offset(y: 10)
                
                RamSpec("Free", ram: ram.free)
                    .offset(y: 10)
            }
            
            Divider()
            
            HStack(spacing: 15) {
                RamSpec("App", ram: ram.appMemory)
                
                RamSpec("Wired", ram: ram.wired)
                
                RamSpec("Compressed", ram: ram.compressed)
                
                Divider()
                    .frame(maxHeight: 40)
                
                RamSpec("Cache", ram: ram.cachedFiles)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .top) {
            HStack(alignment: .top, spacing: 0) {
                HStack {
                    Text(entry.date, format: .dateTime.hour().minute().second())
                    
                    Text(version)
                }
                .foregroundStyle(.tertiary)
                
                Spacer()
                
                Button(intent: RefreshIntent()) {
                    Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                }
                .clipShape(.circle)
                .offset(x: 12, y: -8)
            }
            .caption2()
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

import SwiftUI
import WidgetKit

struct SmallWidgetView: View {
    private var entry: Provider.Entry
    
    init(_ entry: Provider.Entry) {
        self.entry = entry
    }
    
#warning("Used twice")
    private var version: String {
        let dick = Bundle.main.infoDictionary
        let version = dick?["CFBundleShortVersionString"] as? String ?? ""
        let build = dick?["CFBundleVersion"] as? String ?? ""
        
        return "v\(version) (B\(build))"
    }
    
#warning("Used twice")
    private var ram: MemoryUsage {
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
                    
                    ProgressView(value: ram.graph_used, total: ram.graph_total)
                        .scaleEffect(x: 1, y: 2)
                        .frame(maxWidth: 200)
                }
            }
            
            HStack(spacing: 15) {
                RamSpec("Usage", ram: ram.used)
                
                RamSpec("Free", ram: ram.free)
            }
            .offset(y: 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .top) {
            HStack(alignment: .top, spacing: 0) {
                HStack {
                    if entry.configuration.showRefreshTime {
                        Text(entry.date, format: .dateTime.hour().minute())
                    }
                    
                    if entry.configuration.showBuildNumber {
                        Text(version)
                    }
                }
                .tertiary()
                
                Spacer()
                
                if entry.configuration.showRefreshButton {
                    Button(intent: RefreshIntent()) {
                        Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                    }
                    .clipShape(.circle)
                    .offset(x: 12, y: -8)
                }
            }
            .caption2()
        }
    }
}

//#Preview(as: .systemSmall) {
//    Widgets()
//} timeline: {
//    MemoryEntry(date: Date(), configuration: .init())
//}

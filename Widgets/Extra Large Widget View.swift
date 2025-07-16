import SwiftUI
import WidgetKit

struct ExtraLargeWidgetView: View {
    private var entry: Provider.Entry
    
    init(_ entry: Provider.Entry) {
        self.entry = entry
    }
    
    private var ram: MemoryUsage {
        entry.memory
    }
    
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
            
            HStack(alignment: .bottom) {
                VStack {
                    Text("Memory")
                        .largeTitle(design: .rounded)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ProgressView(value: ram.graph_used, total: ram.graph_total)
                        .scaleEffect(x: 1, y: 2)
                }
                
                ExtraLargeRamSpec("Usage", ram: ram.used)
                    .offset(y: 10)
                
                ExtraLargeRamSpec("Free", ram: ram.free)
                    .offset(y: 10)
            }
            
            Divider()
            
            HStack(spacing: 32) {
                ExtraLargeRamSpec("App", ram: ram.appMemory)
                
                ExtraLargeRamSpec("Wired", ram: ram.wired)
                
                ExtraLargeRamSpec("Compressed", ram: ram.compressed)
                
                Divider()
                    .frame(maxHeight: 40)
                
                ExtraLargeRamSpec("Cache", ram: ram.cachedFiles)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .top) {
            HStack(alignment: .top, spacing: 0) {
                HStack {
                    if entry.configuration.showRefreshTime {
                        Text(entry.date, format: .dateTime.hour().minute().second())
                    }
                    
                    if entry.configuration.showBuildNumber {
                        Text(Bundle.versionAndBuild)
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
        }
    }
}

//#Preview(as: .systemMedium) {
//    Widgets()
//} timeline: {
//    MemoryEntry(date: Date(), configuration: .init())
//}

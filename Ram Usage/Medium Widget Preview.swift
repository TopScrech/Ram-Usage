import SwiftUI

struct MediumWidgetPreview: View {
    private var version: String {
        let dick = Bundle.main.infoDictionary
        let version = dick?["CFBundleShortVersionString"] as? String ?? ""
        let build = dick?["CFBundleVersion"] as? String ?? ""
        
        return "v\(version) (B\(build))"
    }
    
    private let ram: MemoryUsage
    
    init(_ ram: MemoryUsage) {
        self.ram = ram
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
            HStack {
                HStack(alignment: .top, spacing: 0) {
                    Text(Date(), format: .dateTime.hour().minute().second())
                    
                    Text(version)
                }
                .foregroundStyle(.tertiary)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                        .foregroundStyle(.blue)
                }
                .clipShape(.circle)
                .offset(x: 12, y: -8)
            }
            .caption2()
        }
    }
}

#Preview {
    MediumWidgetPreview(
        .init(
            used: "",
            free: "",
            appMemory: "",
            wired: "",
            compressed: "",
            cachedFiles: "",
            graph_used: 1,
            graph_total: 1
        )
    )
}

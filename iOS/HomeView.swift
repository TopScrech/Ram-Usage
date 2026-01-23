import ScrechKit

struct HomeView: View {
    @State private var vm = MemoryVM()
    
    private let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    @State private var safariCover = false
    
    var body: some View {
        List {
            LabeledContent("Total", value: vm.formattedTotalRam)
            
            LabeledContent("Used", value: vm.formattedUsedRam)
                .animation(.default, value: vm.formattedUsedRam)
            
            LabeledContent("Free", value: vm.formattedFreeRam)
                .animation(.default, value: vm.formattedFreeRam)
            
            Section("FAQ") {
                DisclosureGroup("What is RAM?") {
                    Text("RAM (Random Access Memory) is a type of volatile memory that temporarily stores data and instructions for quick access by the CPU, enabling fast processing and multitasking. Unlike storage drives, RAM loses its data when the device is powered off")
                        .secondary()
                }
                
                Button("How to add and edit widgets") {
                    safariCover = true
                }
                
                DisclosureGroup("Is there also a macOS app?") {
                    Text("Yes, it can be downloaded from the [App Store](https://apps.apple.com/app/id6636466492)")
                        .secondary()
                }
            }
        }
        .navigationTitle("RAM Usage")
        .monospacedDigit()
        .foregroundStyle(.foreground)
        .safariCover($safariCover, url: "https://support.apple.com/en-us/118610")
        .onReceive(timer) { _ in
            vm.getMemoryUsage()
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .darkSchemePreferred()
}

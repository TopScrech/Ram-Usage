import SwiftUI

struct HomeView: View {
    @Environment(RamVM.self) private var vm
    
    var body: some View {
        List {
            MediumWidgetPreview(vm.memoryUsage)
                .padding()
                .background(.ultraThickMaterial, in: .rect(cornerRadius: 16))
            
            Button("Quit", role: .destructive) {
                NSApplication.shared.terminate(nil)
            }
            //                .padding(4)
            //                .background(.ultraThickMaterial, in: .rect(cornerRadius: 16))
            
            //            Section {
            //                VStack(alignment: .leading) {
            //                    Text("You can quit this window and add RAM Usage widgets to the home screen")
            //
            //                    Button("Quit") {
            //                        exit(16)
            //                    }
            //                }
            //            }
            //
            //            Section {
            //                Text("Active \(vm.active)")
            //                Text("Inactive \(vm.inactive)")
            //            }
            //
            //            Section {
            //                Text("AllFree \(vm.allFree) (\(vm.allFreePercentage.shorten())%)")
            //
            //                Text("Free \(vm.free)")
            //                Text("FreeString \(vm.freeString)")
            //                Text("Total \(vm.total)")
            //                Text("UsageHistory \(vm.usageHistory)")
            //                Text("Used \(vm.used)")
            //                Text("UsedPercentage \(vm.usedPercentage)")
            //                Text("UsedPercentageString \(vm.usedPercentageString)")
            //                Text("UsedString \(vm.usedString)")
            //            }
            //
            //            Section {
            //                Text("CachedFiles \(vm.cachedFiles)")
            //            }
            //
            //            Section {
            //                Text("AppMemory \(vm.appMemory)")
            //                Text("Compressed \(vm.compressed)")
            //                Text("Wired \(vm.wired)")
            //            }
            
            //            Button("Test") {
            //                runVMStat()
            //            }
            //
            //            HStack {
            //                let used = vm.used.shorten()
            //                Text("Usage \(used) GB")
            //
            //                let free = vm.allFree.shorten()
            //                Text("Free \(free) GB")
            //            }
            //
            //            HStack {
            //                let cachedFiles = vm.cachedFiles.shorten()
            //                Text("cachedFiles \(cachedFiles) GB")
            //
            //                let appMemory = vm.appMemory.shorten()
            //                Text("appMemory \(appMemory) GB")
            //
            //                let wired = vm.wired.shorten()
            //                Text("wired \(wired) GB")
            //
            //                let compressed = vm.compressed.shorten()
            //                Text("compressed \(compressed) GB")
            //            }
        }
        .navigationTitle("RAM Usage")
        .navigationSubtitle("You can add this widget to your desktop")
        .scrollIndicators(.never)
        .listStyle(.plain)
        .task {
            vm.startUpdating()
        }
    }
}

func runVMStat() {
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/vm_stat")
    
    let pipe = Pipe()
    process.standardOutput = pipe
    process.standardError = pipe
    
    do {
        try process.run()
        process.waitUntilExit()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        
        if let output = String(data: data, encoding: .utf8) {
            print(output)
        }
    } catch {
        print("Error running command:", error.localizedDescription)
    }
}

private extension String {
    func shorten(_ symbolsAfterComma: Int = 1) -> String {
        String(format: "%0.\(symbolsAfterComma)f", self)
    }
}

extension Double {
    func shorten(_ symbolsAfterComma: Int = 1) -> String {
        String(format: "%0.\(symbolsAfterComma)f", self)
    }
}

#Preview {
    HomeView()
        .darkSchemePreferred()
        .environment(RamVM())
        .padding(20)
}

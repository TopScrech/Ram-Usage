import SwiftUI

struct RAMInfo: View {
    @Environment(RamVM.self) private var vm
    
    var body: some View {
        VStack {
            Button("Test") {
                runVMStat()
            }
            
            HStack {
                let used = vm.used.shorten()
                Text("Usage \(used) GB")
                
                let free = vm.allFree.shorten()
                Text("Free \(free) GB")
            }
            
            HStack {
                let cachedFiles = vm.cachedFiles.shorten()
                Text("cachedFiles \(cachedFiles) GB")
                
                let appMemory = vm.appMemory.shorten()
                Text("appMemory \(appMemory) GB")
                
                let wired = vm.wired.shorten()
                Text("wired \(wired) GB")
                
                let compressed = vm.compressed.shorten()
                Text("compressed \(compressed) GB")
            }
        }
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
        print("Error running command: \(error.localizedDescription)")
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
    RAMInfo()
}

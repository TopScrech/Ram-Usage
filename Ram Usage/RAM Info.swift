import SwiftUI

struct RAMInfo: View {
    @State private var vm = MemoryStore()
    
    var body: some View {
        VStack {
            Button("Test") {
                runCommand()
            }
            
            Button("Test2") {
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
    }
}

func runCommand() {
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/sbin/sysctl")
    process.arguments = ["vm.swapusage"]

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

extension String {
    func shorten(_ symbolsAfterComma: Int = 1) -> String {
        String(format: "%0.\(symbolsAfterComma)f", self)
    }
}

extension Double {
    func shorten(_ symbolsAfterComma: Int = 1) -> String {
        String(format: "%0.\(symbolsAfterComma)f", self)
    }
}

extension View {
    public func onShortcut(
        _ key: KeyEquivalent,
        modifiers: EventModifiers = .command,
        perform: @escaping () -> Void
    ) -> some View {
        ZStack {
            Button("") {
                perform()
            }
            .opacity(0)
            .keyboardShortcut(key, modifiers: modifiers)
            
            self
        }
    }
}

//struct KeyboardShortcutModifier: ViewModifier {
//    let key: KeyEquivalent
//    let modifiers: EventModifiers
//
//    func body(content: Content) -> some View {
//        content
//            .keyboardShortcut((Character(key)), modifiers: modifiers)
//    }
//}
//
//extension View {
//    func keyboardShortcut(key: String, modifiers: EventModifiers) -> some View {
//        self.modifier(KeyboardShortcutModifier(key: key, modifiers: modifiers))
//    }
//}
#Preview {
    RAMInfo()
}

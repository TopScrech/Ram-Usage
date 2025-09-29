import SystemKit
import WidgetKit

@Observable
final class RamVM {
    var free = 0.0
    var active = 0.0
    var inactive = 0.0
    
    var wired = 0.0
    var compressed = 0.0
    var appMemory = 0.0
    
    var cachedFiles = 0.0
    var usageHistory: [Double] = []
    
    var memoryUsage: MemoryUsage {
        MemoryUsage(
            used: usedString,
            free: freeString,
            appMemory: appMemoryString,
            wired: wiredString,
            compressed: compressedString,
            cachedFiles: cachedFilesString,
            graph_used: used,
            graph_total: total
        )
    }
    
    var used: Double {
        appMemory + wired + compressed
    }
    
    var usedPercentage: Double {
        used / total * 100
    }
    
    var usedPercentageString: String {
        (used / total).percentageString
    }
    
    var total: Double {
        free + inactive + active + wired + compressed
    }
    
    var allFree: Double {
        total - used
    }
    
    var allFreePercentage: Double {
        allFree / total * 100
    }
    
    var freeString: String {
        (total - used).memoryString
    }
    
    var usedString: String {
        used.memoryString
    }
    
    var wiredString: String {
        wired.memoryString
    }
    
    var compressedString: String {
        compressed.memoryString
    }
    
    var cachedFilesString: String {
        cachedFiles.memoryString
    }
    
    var appMemoryString: String {
        appMemory.memoryString
    }
    
    func refresh() {
        let ram = System.memoryUsage()
        (free, active, inactive, wired, compressed, appMemory, cachedFiles) = ram
    }
    
    func updateWidgets() {
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func startUpdating() {
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
            self.refresh()
        }
    }
    
    // MARK: - SWAP
    
    func fetchSwap() -> String? {
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
                return output
            }
        } catch {
            print("Error running command:", error.localizedDescription)
        }
        
        return nil
    }
    
    func parseSwapUsage(_ string: String) -> SwapUsage? {
        // Regular expression pattern
        let pattern = #"total = ([\d.]+M)\s+used = ([\d.]+M)\s+free = ([\d.]+M)"#
        
        // Create regular expression
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return nil
        }
        
        // Search for matches
        let range = NSRange(string.startIndex..<string.endIndex, in: string)
        
        // Extract values
        if let match = regex.firstMatch(in: string, options: [], range: range),
           let totalRange = Range(match.range(at: 1), in: string),
           let usedRange = Range(match.range(at: 2), in: string),
           let freeRange = Range(match.range(at: 3), in: string) {
            
            let total = String(string[totalRange])
            let used = String(string[usedRange])
            let free = String(string[freeRange])
            
            return SwapUsage(
                total: total,
                used: used,
                free: free
            )
        }
        
        return nil
    }
}

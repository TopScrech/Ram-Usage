import Foundation

extension RamVM {
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

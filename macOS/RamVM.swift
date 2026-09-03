import Darwin
import WidgetKit
import OSLog

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
        guard let memory = memoryStatistics() else {
            return
        }

        let stats = memory.stats
        free = gigabytes(forPageCount: UInt64(stats.free_count), pageSize: memory.pageSize)
        active = gigabytes(forPageCount: UInt64(stats.active_count), pageSize: memory.pageSize)
        inactive = gigabytes(forPageCount: UInt64(stats.inactive_count), pageSize: memory.pageSize)
        wired = gigabytes(forPageCount: UInt64(stats.wire_count), pageSize: memory.pageSize)
        compressed = gigabytes(forPageCount: UInt64(stats.compressor_page_count), pageSize: memory.pageSize)
        appMemory = gigabytes(
            forPageCount: Self.appMemoryPageCount(
                internalPageCount: UInt64(stats.internal_page_count),
                purgeablePageCount: UInt64(stats.purgeable_count)
            ),
            pageSize: memory.pageSize
        )
        cachedFiles = gigabytes(
            forPageCount: UInt64(stats.external_page_count) + UInt64(stats.purgeable_count),
            pageSize: memory.pageSize
        )
    }

    static func appMemoryPageCount(internalPageCount: UInt64, purgeablePageCount: UInt64) -> UInt64 {
        guard internalPageCount >= purgeablePageCount else {
            return 0
        }

        return internalPageCount - purgeablePageCount
    }

    private func memoryStatistics() -> (stats: vm_statistics64, pageSize: UInt64)? {
        var stats = vm_statistics64()
        var count = mach_msg_type_number_t(
            MemoryLayout<vm_statistics64_data_t>.size / MemoryLayout<integer_t>.size
        )
        var pageSize: vm_size_t = 0
        let host = mach_host_self()
        defer {
            mach_port_deallocate(mach_task_self_, host)
        }

        let result = withUnsafeMutablePointer(to: &stats) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                host_statistics64(host, HOST_VM_INFO64, $0, &count)
            }
        }

        guard result == KERN_SUCCESS, host_page_size(host, &pageSize) == KERN_SUCCESS else {
            return nil
        }

        return (stats, UInt64(pageSize))
    }

    private func gigabytes(forPageCount pageCount: UInt64, pageSize: UInt64) -> Double {
        let bytesPerGigabyte = 1_073_741_824.0
        return Double(pageCount) * Double(pageSize) / bytesPerGigabyte
    }

    func updateWidgets() {
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func startUpdating() {
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
            Task { @MainActor in
                self.refresh()
            }
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
            Logger().error("Error running command: \(error)")
        }
        
        return nil
    }
    
    func parseSwapUsage(_ string: String) -> SwapUsage? {
        let pattern = #"total = ([\d.]+M)\s+used = ([\d.]+M)\s+free = ([\d.]+M)"#
        
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return nil
        }
        
        // Search for matches
        let range = NSRange(string.startIndex..<string.endIndex, in: string)
        
        // Extract values
        guard
            let match = regex.firstMatch(in: string, options: [], range: range),
            let totalRange = Range(match.range(at: 1), in: string),
            let usedRange = Range(match.range(at: 2), in: string),
            let freeRange = Range(match.range(at: 3), in: string)
        else {
            return nil
        }
        
        let total = String(string[totalRange])
        let used = String(string[usedRange])
        let free = String(string[freeRange])
        
        return SwapUsage(total: total, used: used, free: free)
    }
}

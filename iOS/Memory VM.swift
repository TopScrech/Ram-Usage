import ScrechKit

@Observable
final class MemoryVM {
    var totalRam: UInt64 = 0
    var usedRam: UInt64 = 0
    var freeRam: UInt64 = 0
    
    var formattedTotalRam: String {
        formatBytes(totalRam)
    }
    
    var formattedUsedRam: String {
        format(Int(totalRam), Int(usedRam))
    }
    
    var formattedFreeRam: String {
        format(Int(totalRam), Int(freeRam))
    }
    
    init() {
        getMemoryUsage()
    }
    
    func getMemoryUsage() {
        var stats = vm_statistics64()
        var size = mach_msg_type_number_t(MemoryLayout.size(ofValue: stats) / MemoryLayout<Int32>.stride)
        let host = mach_host_self()
        
        let status = withUnsafeMutablePointer(to: &stats) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(size)) {
                host_statistics64(host, HOST_VM_INFO64, $0, &size)
            }
        }
        
        guard status == KERN_SUCCESS else {
            return
        }
        
        let totalMemory = ProcessInfo.processInfo.physicalMemory
        var pageSize: vm_size_t = 0
        host_page_size(host, &pageSize)
        
        let usedMemory = (UInt64(stats.active_count) + UInt64(stats.wire_count)) * UInt64(pageSize)
        let freeMemory = totalMemory - usedMemory
        
        totalRam = totalMemory
        usedRam = usedMemory
        freeRam = freeMemory
    }
    
    private func format(_ total: Int, _ value: Int) -> String {
        let percentage = Double(value) / Double(total) * 100
        let percentageString = String(format: " (%.1f%%)", percentage)
        
        return formatBytes(value) + percentageString
    }
}

import ScrechKit

@Observable
final class MemoryVM {
    var totalRam = ""
    var usedRam = ""
    var freeRam = ""
    
    init() {
        getMemoryUsage()
    }
    
    func getMemoryUsage() {
        var size = mach_msg_type_number_t(MemoryLayout<vm_statistics_data_t>.size / MemoryLayout<integer_t>.size)
        let host = mach_host_self()
        var stats = vm_statistics_data_t()
        
        let status = withUnsafeMutablePointer(to: &stats) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(size)) {
                host_statistics(host, HOST_VM_INFO, $0, &size)
            }
        }
        
        if status == KERN_SUCCESS {
            let totalMemory = ProcessInfo.processInfo.physicalMemory
            
            let pageSize = vm_kernel_page_size
            let usedMemory = (UInt64(stats.active_count) + UInt64(stats.inactive_count) + UInt64(stats.wire_count)) * UInt64(pageSize)
            let freeMemory = totalMemory - usedMemory
            
            totalRam = formatBytes(totalMemory)
            
            usedRam = format(Int(totalMemory), Int(usedMemory))
            freeRam = format(Int(totalMemory), Int(freeMemory))
        }
    }
    
    private func format(_ total: Int, _ value: Int) -> String {
        let percentage = Double(value) / Double(total) * 100
        let percentageString = String(format: " (%.1f%%)", percentage)
        
        return formatBytes(value) + percentageString
    }
}

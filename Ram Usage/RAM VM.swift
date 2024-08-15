import SystemKit
import WidgetKit

@Observable
final class MemoryStore {
    init() {
        startUpdating()
    }
    
    var free = 0.0
    var active = 0.0
    var inactive = 0.0
    var wired = 0.0
    var compressed = 0.0
    var appMemory = 0.0
    var cachedFiles = 0.0
    var usageHistory: [Double] = []
    
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
}

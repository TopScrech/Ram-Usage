import WidgetKit

struct MemoryEntry: TimelineEntry {
    let configuration: ConfigurationAppIntent
    
    let date: Date
    let memory: MemoryUsage
}

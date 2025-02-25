import WidgetKit

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    var totalRam = 0.0
    var usedRam = 0.0
    var freeRam = 0.0
}

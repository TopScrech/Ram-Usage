import SwiftUI
import WidgetKit

struct RamUsageWidget: Widget {
    let kind = "Widgets"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) {
            WidgetsEntryView($0)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

//#Preview(as: .systemSmall) {
//    Widgets_iOS()
//} timeline: {
//    SimpleEntry(date: .now, configuration: .smiley)
//    SimpleEntry(date: .now, configuration: .starEyes)
//}

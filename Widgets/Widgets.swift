import SwiftUI
import WidgetKit

struct Widgets: Widget {
    private let kind = "Widgets"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            DiskUsageWidgetView(entry)
                .containerBackground(.ultraThinMaterial, for: .widget)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

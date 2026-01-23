import SwiftUI
import WidgetKit

struct Widgets: Widget {
    private let kind = "Widgets"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) {
            DiskUsageWidgetView($0)
                .containerBackground(.ultraThinMaterial, for: .widget)
        }
#if DEBUG
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge])
#else
        .supportedFamilies([.systemSmall, .systemMedium])
#endif
    }
}

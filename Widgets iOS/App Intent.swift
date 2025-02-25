import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description: IntentDescription = ""
    
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
}

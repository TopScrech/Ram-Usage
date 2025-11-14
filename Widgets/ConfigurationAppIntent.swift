import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static let title: LocalizedStringResource = "Configuration"
    static let description: IntentDescription = ""
    
    @Parameter(title: "Show refresh button", default: true)
    var showRefreshButton: Bool
    
    @Parameter(title: "Show refresh time", default: true)
    var showRefreshTime: Bool
    
    @Parameter(title: "Show build number", default: false)
    var showBuildNumber: Bool
}

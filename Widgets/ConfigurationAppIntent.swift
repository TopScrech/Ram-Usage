import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description: IntentDescription = ""
    
    @Parameter(title: "Show refresh button", default: true)
    var showRefreshButton: Bool
    
    @Parameter(title: "Show refresh time", default: true)
    var showRefreshTime: Bool
    
    @Parameter(title: "Show build number", default: false)
    var showBuildNumber: Bool
}

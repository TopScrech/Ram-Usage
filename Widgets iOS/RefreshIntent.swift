import AppIntents

struct RefreshIntent: AppIntent {
    static var title: LocalizedStringResource = "Refresh"
    
    func perform() async throws -> some IntentResult {
        .result()
    }
}

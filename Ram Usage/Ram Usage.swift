import ScrechKit

@main
struct RamUsage: App {
    var body: some Scene {
        WindowGroup {
            AppContainer()
        }
        
        Settings {
            AppSettings()
        }
    }
}

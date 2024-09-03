import ScrechKit

@main
struct RamUsage: App {
    @State private var vm = RamVM()
    
    var body: some Scene {
        WindowGroup {
            AppContainer()
                .environment(vm)
        }
        
        //        Settings {
        //            AppSettings()
        //                .environment(vm)
        //        }
    }
}

import ScrechKit

@main
struct RamUsage: App {
    @State private var vm = RamVM()
    
    var body: some Scene {
        //        WindowGroup {
        //            AppContainer()
        //                .environment(vm)
        //        }
        
        MenuBarExtra("Menu Bar Extra", systemImage: "externaldrive") {
            AppContainer()
                .environment(vm)
                .frame(width: 300, height: 500)
        }
        .menuBarExtraStyle(.window)
        
        //        Settings {
        //            AppSettings()
        //                .environment(vm)
        //        }
    }
}

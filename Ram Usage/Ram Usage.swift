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
                .frame(width: 400)
                .frame(minHeight: 250, maxHeight: 300)
        }
        .menuBarExtraStyle(.window)
        
        //        Settings {
        //            AppSettings()
        //                .environment(vm)
        //        }
    }
}

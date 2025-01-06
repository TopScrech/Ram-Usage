import SwiftUI
import LaunchAtLogin

struct AppSettings: View {
    //    @Environment(RamVM.self) private var vm
    
    var body: some View {
        LaunchAtLogin.Toggle()
            .padding()
        
        //        List {
        //            Text("Active \(vm.active)")
        //            Text("AllFree \(vm.allFree)")
        //            Text("allFreePercentage \(vm.allFreePercentage)")
        //            Text("appMemory \(vm.appMemory)")
        //            Text("cachedFiles \(vm.cachedFiles)")
        //            Text("compressed \(vm.compressed)")
        //            Text("free \(vm.free)")
        //            Text("freeString \(vm.freeString)")
        //            Text("inactive \(vm.inactive)")
        //            Text("total \(vm.total)")
        //            Text("usageHistory \(vm.usageHistory)")
        //            Text("used \(vm.used)")
        //            Text("usedPercentage \(vm.usedPercentage)")
        //            Text("usedPercentageString \(vm.usedPercentageString)")
        //            Text("usedString \(vm.usedString)")
        //            Text("wired \(vm.wired)")
        //        }
    }
}

#Preview {
    AppSettings()
    //        .environment(RamVM())
}

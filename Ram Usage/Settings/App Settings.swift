import SwiftUI
import LaunchAtLogin

struct AppSettings: View {
    //    @Environment(RamVM.self) private var vm
    
    var body: some View {
        Form {
            LaunchAtLogin.Toggle()
            
            //Section {
            //    Text("Active \(vm.active)")
            //    Text("AllFree \(vm.allFree)")
            //    Text("allFreePercentage \(vm.allFreePercentage)")
            //    Text("appMemory \(vm.appMemory)")
            //    Text("cachedFiles \(vm.cachedFiles)")
            //    Text("compressed \(vm.compressed)")
            //    Text("free \(vm.free)")
            //    Text("freeString \(vm.freeString)")
            //    Text("inactive \(vm.inactive)")
            //    Text("total \(vm.total)")
            //    Text("usageHistory \(vm.usageHistory)")
            //    Text("used \(vm.used)")
            //    Text("usedPercentage \(vm.usedPercentage)")
            //    Text("usedPercentageString \(vm.usedPercentageString)")
            //    Text("usedString \(vm.usedString)")
            //    Text("wired \(vm.wired)")
            //}
        }
        .navigationTitle("Settings")
        .buttonStyle(.plain)
        .formStyle(.grouped)
        .frame(width: 500, height: 600)
    }
}

#Preview {
    AppSettings()
    //        .environment(RamVM())
}

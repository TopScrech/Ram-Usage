import SwiftUI

struct AppSettings: View {
    @State private var vm = MemoryStore()
    
    var body: some View {
        List {
            Text("Active \(vm.active)")
            Text("AllFree \(vm.allFree)")
            Text("allFreePercentage \(vm.allFreePercentage)")
            Text("appMemory \(vm.appMemory)")
            Text("cachedFiles \(vm.cachedFiles)")
            Text("compressed \(vm.compressed)")
            Text("free \(vm.free)")
            Text("freeString \(vm.freeString)")
            Text("inactive \(vm.inactive)")
            Text("total \(vm.total)")
            Text("usageHistory \(vm.usageHistory)")
            Text("used \(vm.used)")
            Text("usedPercentage \(vm.usedPercentage)")
            Text("usedPercentageString \(vm.usedPercentageString)")
            Text("usedString \(vm.usedString)")
            Text("wired \(vm.wired)")
        }
        .refreshableTask {
            vm.refresh()
        }
    }
}

#Preview {
    AppSettings()
}

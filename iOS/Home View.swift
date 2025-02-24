import ScrechKit

struct HomeView: View {
    @State private var vm = MemoryVM()
    
    private let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    var body: some View {
        List {
            ListParam("Total", param: vm.totalRam)
            
            ListParam("Used", param: vm.usedRam)
                .animation(.default, value: vm.usedRam)
            
            ListParam("Free", param: vm.freeRam)
                .animation(.default, value: vm.freeRam)
        }
        .monospacedDigit()
        .onReceive(timer) { _ in
            vm.getMemoryUsage()
        }
    }
}

#Preview {
    HomeView()
}

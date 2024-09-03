import WidgetKit

struct Provider: AppIntentTimelineProvider {
    let previewMemoryUsage = MemoryUsage(
        used: "100 GB",
        free: "200 GB",
        appMemory: "40 GB",
        wired: "20 GB",
        compressed: "10 GB",
        cachedFiles: "100 GB",
        graph_used: 1,
        graph_total: 2
    )
    
    func placeholder(
        in context: Context
    ) -> MemoryEntry {
        MemoryEntry(
            configuration: ConfigurationAppIntent(),
            date: Date(),
            memory: previewMemoryUsage
        )
    }
    
    func snapshot(
        for configuration: ConfigurationAppIntent,
        in context: Context
    ) async -> MemoryEntry {
        let vm = RamVM()
        vm.refresh()
        
        return MemoryEntry(
            configuration: configuration,
            date: Date(),
            memory: vm.memoryUsage
        )
    }
    
    func timeline(
        for configuration: ConfigurationAppIntent,
        in context: Context
    ) async -> Timeline<MemoryEntry> {
        var entries: [MemoryEntry] = []
        
        let vm = RamVM()
        vm.refresh()
        
        entries = [
            .init(
                configuration: configuration,
                date: Date(),
                memory: vm.memoryUsage
            )
        ]
        
        return Timeline(entries: entries, policy: .atEnd)
    }
    
    //    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
    //        // Generate a list containing the contexts this widget is relevant in.
    //    }
}

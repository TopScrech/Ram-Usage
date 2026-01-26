import ScrechKit
import Testing
import OSLog

struct UnitTests {
    private var vm = RamVM()
    
    @Test func test() async throws {
        let bytes = Int64(1_000_000_000_000_000)
        
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = .useAll
        formatter.countStyle = .binary
        formatter.includesUnit = true
        
        Logger().info("\(formatter.string(fromByteCount: bytes))")
        
        let formatter2 = ByteCountFormatter()
        formatter.allowedUnits = .useAll
        formatter.countStyle = .decimal
        formatter.includesUnit = true
        
        Logger().info("\(formatter2.string(fromByteCount: bytes))")
        
        let formatter3 = ByteCountFormatter()
        formatter.allowedUnits = .useAll
        formatter.countStyle = .file
        formatter.includesUnit = true
        
        Logger().info("\(formatter3.string(fromByteCount: bytes))")
        
        let formatter4 = ByteCountFormatter()
        formatter.allowedUnits = .useAll
        formatter.countStyle = .memory
        formatter.includesUnit = true
        
        Logger().info("\(formatter4.string(fromByteCount: bytes))")
    }
    
    @Test func example() async throws {
        if let data = vm.fetchSwap(),
           let swap = vm.parseSwapUsage(data) {
            Logger().error("Free: \(swap.free), Total: \(swap.total), Used: \(swap.used)")
        }
        // Write your test here and use APIs like `#expect(...)` to check expected conditions
    }
}

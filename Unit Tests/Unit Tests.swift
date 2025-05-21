import Testing
import ScrechKit

struct UnitTests {
    private var vm = RamVM()
    
    @Test func test() async throws {
        let bytes = Int64(1_000_000_000_000_000)
        
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = .useAll
        formatter.countStyle = .binary
        formatter.includesUnit = true
        
        print(formatter.string(fromByteCount: bytes))
        
        let formatter2 = ByteCountFormatter()
        formatter.allowedUnits = .useAll
        formatter.countStyle = .decimal
        formatter.includesUnit = true
        
        print(formatter2.string(fromByteCount: bytes))
        
        let formatter3 = ByteCountFormatter()
        formatter.allowedUnits = .useAll
        formatter.countStyle = .file
        formatter.includesUnit = true
        
        print(formatter3.string(fromByteCount: bytes))
        
        let formatter4 = ByteCountFormatter()
        formatter.allowedUnits = .useAll
        formatter.countStyle = .memory
        formatter.includesUnit = true
        
        print(formatter4.string(fromByteCount: bytes))
    }
    
    @Test func example() async throws {
        if let data = vm.fetchSwap(),
           let swap = vm.parseSwapUsage(data) {
            print(swap)
        }
        // Write your test here and use APIs like `#expect(...)` to check expected conditions
    }
}

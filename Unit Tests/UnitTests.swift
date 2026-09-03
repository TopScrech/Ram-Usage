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

    @Test func appMemoryPageCountClampsUnderflow() {
        let pageCount = RamVM.appMemoryPageCount(internalPageCount: 10, purgeablePageCount: 11)

        #expect(pageCount == 0)
    }

    @Test func appMemoryPageCountSubtractsPurgeablePages() {
        let pageCount = RamVM.appMemoryPageCount(internalPageCount: 11, purgeablePageCount: 10)

        #expect(pageCount == 1)
        #expect(RamVM.appMemoryPageCount(internalPageCount: 10, purgeablePageCount: 10) == 0)
    }

    @Test func refreshProducesValidMemoryValues() {
        for _ in 0 ..< 100 {
            vm.refresh()
        }

        let values = [vm.free, vm.active, vm.inactive, vm.wired, vm.compressed, vm.appMemory, vm.cachedFiles]
        let valuesAreFinite = values.allSatisfy { $0.isFinite }
        let valuesAreNonnegative = values.allSatisfy { $0 >= 0 }

        #expect(valuesAreFinite)
        #expect(valuesAreNonnegative)
        #expect(vm.total > 0)
    }
}

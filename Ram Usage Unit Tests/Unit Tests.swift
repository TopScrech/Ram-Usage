import Testing

struct UnitTests {
    private var vm = RamVM()
    
    @Test func example() async throws {
        if let data = vm.fetchSwap() {
            if let swap = vm.parseSwapUsage(data) {
                print(swap)
            }
        }
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
}

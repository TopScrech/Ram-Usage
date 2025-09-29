import SwiftUI

struct RamSpec: View {
    private let name: String
    private let ram: String
    
    init(_ name: String, ram: String) {
        self.name = name
        self.ram = ram
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
                .footnote()
                .secondary()
            
            Text(ram)
                .monospacedDigit()
        }
    }
}

extension Double {
    var percentageString: String {
        (isNaN || isInfinite) ? "N/A" : String(format: "%.0f%%", self * 100)
    }
    
    var memoryString: String {
        if isNaN || isInfinite {
            "N/A"
        } else {
            self < 1.0 ? String(Int(self * 1000.0)) + " MB" : String(format: "%.1f", self) + " GB"
        }
    }
    
    func toFixed(_ decimal: Int) -> String {
        String(format: "%.\(decimal)f", self)
    }
    
    var zeroOrAbove: Double {
        isNaN || isLess(than: 0) ? 0 : self
    }
}

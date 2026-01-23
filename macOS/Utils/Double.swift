extension Double {
    var percentageString: String {
        (isNaN || isInfinite) ? "N/A" : self.formatted(.percentRounded)
    }
    
    var memoryString: String {
        if isNaN || isInfinite {
            "N/A"
        } else {
            self < 1.0 ? String(Int(self * 1000.0)) + " MB" : self.formatted(.fractionDigits(1)) + " GB"
        }
    }
    
    var zeroOrAbove: Double {
        isNaN || isLess(than: 0) ? 0 : self
    }
    
    func toFixed(_ decimal: Int) -> String {
        String(format: "%.\(decimal)f", self)
    }
    
    func shorten(_ symbolsAfterComma: Int = 1) -> String {
        String(format: "%0.\(symbolsAfterComma)f", self)
    }
}

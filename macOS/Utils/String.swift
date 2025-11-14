private extension String {
    func shorten(_ symbolsAfterComma: Int = 1) -> String {
        String(format: "%0.\(symbolsAfterComma)f", self)
    }
}

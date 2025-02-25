import SwiftUI
import WidgetKit

struct WidgetsEntryView : View {
    private var entry: Provider.Entry
    
    init(_ entry: Provider.Entry) {
        self.entry = entry
    }
    
    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)
            
            Text("Favorite Emoji:")
            Text(entry.configuration.favoriteEmoji)
        }
    }
}

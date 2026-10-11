
import SwiftUI

struct SiteMapView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView(
                "Site Map",
                systemImage: "map.fill",
                description: Text("The construction site map will appear here.")
            )
            .navigationTitle("Site Map")
        }
    }
}

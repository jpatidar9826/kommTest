import SwiftUI
import Kommunicate

@main
struct kommTestApp: App {
    init() {
            Kommunicate.setup(applicationId: "39d39b29578105a1a48b9aa2c35a181ee")
        }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

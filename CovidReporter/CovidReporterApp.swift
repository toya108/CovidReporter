import SwiftUI

@main
struct CovidReporterApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    var body: some Scene {
        WindowGroup {
            ChartListView()
        }
    }
}

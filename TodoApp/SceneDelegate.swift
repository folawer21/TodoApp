import SwiftUI
import CocoaLumberjackSwift
@main
struct TodoApp: App {
    init() {
        setupLogger()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
    func setupLogger() {
        DDLog.add(DDOSLogger.sharedInstance)
    }
}

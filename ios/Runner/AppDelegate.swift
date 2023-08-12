import UIKit
import Flutter
import GoogleMaps // 追加

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyB8lOb5W9g0Ir31TR6M2HZpzwQtm1HT_jE") // 追加
    GMSServices.setMetalRendererEnabled(true) // 詳細は後ほど
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

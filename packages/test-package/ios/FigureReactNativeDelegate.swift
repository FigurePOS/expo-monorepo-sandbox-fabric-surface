import React_RCTAppDelegate
import React

class FigureReactNativeDelegate: RCTDefaultReactNativeFactoryDelegate {
  /// Extension point for config-plugins
  override func sourceURL(for bridge: RCTBridge) -> URL? {
    // Needed to return the correct URL for expo-dev-client
    bridge.bundleURL ?? bundleURL()
  }

  override func bundleURL() -> URL? {
    #if DEBUG
      return RCTBundleURLProvider.sharedSettings().jsBundleURL(
        forBundleRoot: ".expo/.virtual-metro-entry")
    #else
      let frameworkBundle = Bundle(for: FigureReactNativeHostManager.self)
      return frameworkBundle.url(forResource: "main", withExtension: "jsbundle")
    #endif
  }
}

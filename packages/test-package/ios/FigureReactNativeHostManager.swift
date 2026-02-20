import ExpoModulesCore
import React_RCTAppDelegate
import Network
import UIKit

public class FigureReactNativeHostManager {
  public static let shared = FigureReactNativeHostManager()

  private var reactNativeDelegate: RCTReactNativeFactoryDelegate?
  private var reactNativeFactory: RCTReactNativeFactory?

  public func initialize() {
    // Prevent multiple initializations
    guard reactNativeDelegate == nil else {
      return
    }
    let delegate = FigureReactNativeDelegate()
    let factory = RCTReactNativeFactory(delegate: delegate)
    reactNativeDelegate = delegate
    reactNativeFactory = factory
  }

  public func loadView(
    moduleName: String,
    initialProps: [AnyHashable: Any]?,
    launchOptions: [AnyHashable: Any]?
  ) throws -> UIView {
    guard let reactNativeFactory else {
      fatalError("Trying to load view without initializing ReactNativeHostManager. Call initialize() first.")
    }

    return reactNativeFactory.rootViewFactory.view(
      withModuleName: moduleName,
      initialProperties: initialProps,
      launchOptions: launchOptions
    )
  }
}


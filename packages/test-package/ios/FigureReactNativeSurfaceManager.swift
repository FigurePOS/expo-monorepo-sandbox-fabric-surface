import ExpoModulesCore
import React
import React_RCTAppDelegate
import UIKit

// MARK: - Error Types

/// Errors that can occur when loading a React Native surface view.
public enum ReactNativeSurfaceError: Error {
    case appDelegateNotFound
    case reactHostNotFound

    var localizedDescription: String {
        switch self {
        case .appDelegateNotFound:
            return "Could not access ExpoAppDelegate from UIApplication"
        case .reactHostNotFound:
            return "Could not access reactHost from ExpoAppDelegate"
        }
    }
}

/// Manages React Native surface views that share the existing app's React host.
/// Instead of creating a new React Native instance, this uses `RCTFabricSurface`
/// to create surfaces that connect to the existing RCTHost, avoiding splash screen
/// and bundler restart issues.
public class FigureReactNativeSurfaceManager {
    public static let shared = FigureReactNativeSurfaceManager()

    // MARK: - Properties

    /// Stores active surfaces to maintain strong references while they're in use.
    /// Key is inputId, value is the surface.
    private var activeSurfaces: [String: RCTFabricSurface] = [:]

    // MARK: - Initialization

    private init() {}

    // MARK: - Public Methods

    /// No longer needed - we use the existing React host from the app delegate.
    /// Kept for API compatibility but does nothing.
    public func initialize() {
        // No-op: We now use the existing React host from ExpoAppDelegate
        // instead of creating our own factory
    }

    /// Loads a React Native surface view that shares the existing app's React runtime.
    /// - Parameters:
    ///   - moduleName: The registered module name (e.g., "NativeKeyboardWrapper")
    ///   - initialProps: Initial properties to pass to the React component
    ///   - inputId: Unique identifier for this surface (used for lifecycle management)
    /// - Returns: A UIView containing the React Native surface
    /// - Throws: ReactNativeSurfaceError if the React host cannot be accessed
    public func loadView(
        moduleName: String,
        initialProps: [AnyHashable: Any]?,
        inputId: String
    ) throws -> UIView {
        // Access the existing RCTHost from the app delegate
        guard let appDelegate = UIApplication.shared.delegate as? (RCTAppDelegate),
              let reactHost = appDelegate.reactHost else {
            log("Failed to access RCTHost from app delegate")
            throw ReactNativeSurfaceError.reactHostNotFound
        }

        // Create a surface that shares the existing React instance
        let surface = RCTFabricSurface(
            host: reactHost,
            moduleName: moduleName,
            initialProperties: initialProps ?? [:]
        )

        // Store strong reference to the surface
        activeSurfaces[inputId] = surface

        // Create and return the hosting view
        let surfaceView = RCTSurfaceHostingView(surface: surface, sizeMeasureMode: RCTSurfaceSizeMeasureMode.heightAtMost)

        log("Created surface view for module: \(moduleName), inputId: \(inputId)")
        return surfaceView
    }

    /// Legacy loadView method for API compatibility.
    /// - Note: Prefer using loadView(moduleName:initialProps:inputId:) for proper surface lifecycle management.
    public func loadView(
        moduleName: String,
        initialProps: [AnyHashable: Any]?,
        launchOptions: [AnyHashable: Any]?
    ) throws -> UIView {
        // Generate a temporary ID for backwards compatibility
        let tempId = UUID().uuidString
        return try loadView(moduleName: moduleName, initialProps: initialProps, inputId: tempId)
    }

    /// Releases the surface associated with the given input ID.
    /// Should be called when the keyboard is detached to free resources.
    /// - Parameter inputId: The unique identifier of the surface to release
    public func releaseSurface(inputId: String) {
        if let surface = activeSurfaces.removeValue(forKey: inputId) {
           surface.stop()
            log("Released surface for inputId: \(inputId)")
        }
    }

    // MARK: - Private Methods

    private func log(_ message: String) {
        NSLog("[FigureReactNativeSurfaceManager] %@", message)
    }
}
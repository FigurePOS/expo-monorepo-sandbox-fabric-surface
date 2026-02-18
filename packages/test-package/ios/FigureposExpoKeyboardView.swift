import ExpoModulesCore
import UIKit
import React
import Foundation


public class FigureposExpoKeyboardView: ExpoView {

    private var firstSubview: UIView? = nil
    private var textInput: UITextField? = nil

    public var keyboardType: String? {
        didSet { attachBehavior() }
    }

    required init(appContext: AppContext? = nil) {
        super.init(appContext: appContext)

        //FigureReactNativeHostManager.shared.initialize()
        FigureReactNativeSurfaceManager.shared.initialize()
    }

    public override func mountChildComponentView(_ childComponentView: UIView, index: Int) {
        if index == 0 {
            self.firstSubview = childComponentView
        }
        super.mountChildComponentView(childComponentView, index: index)
        attachBehavior()
    }

    private func attachBehavior() {
        guard let subview = firstSubview,
              let textInput = findBackedTextField(subview) else {
            return
        }
        self.textInput = textInput

        // Use FigureReactNativeHostManager to load the React Native view
        // Creates new root view
        // guard let keyboardView = try? FigureReactNativeHostManager.shared.loadView(
        //     moduleName: "custom-keyboard",
        //     initialProps: nil,
        //     launchOptions: nil
        // ) else {
        //     print("loadView showcase (module not loaded with FigureReactNativeHostManager)")
        //     return
        // }

        // Use FigureReactNativeSurfaceManager to load the React Native view
        // Creates a surface that shares the existing React instance
        guard let keyboardView = try? FigureReactNativeSurfaceManager.shared.loadView(
            moduleName: "custom-keyboard",
            initialProps: nil,
            launchOptions: nil
        ) else {
            print("loadView showcase (module not loaded with FigureReactNativeSurfaceManager)")
            return
        }
        
        configureKeyboardView(keyboardView)
        textInput.inputView = createInputViewContainer(with: keyboardView, initialHeight: 364)        
    }


    private func findBackedTextField(_ view: UIView) -> UITextField? {
        if let textField = view as? UITextField { return textField }
        for subview in view.subviews {
            if let found = findBackedTextField(subview) { return found }
        }
        return nil
    }

        
    private func configureKeyboardView(_ keyboardView: UIView) {
        keyboardView.backgroundColor = UIColor.clear
        keyboardView.isOpaque = false
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure RCTRootView-specific properties for flexible sizing
        if let rootView = keyboardView as? RCTRootView {
            rootView.sizeFlexibility = RCTRootViewSizeFlexibility.height
        }
    }

    private func createInputViewContainer(with keyboardView: UIView, initialHeight: CGFloat) -> UIInputView {
        let inputView = UIInputView(frame: .zero, inputViewStyle: .keyboard)
        inputView.allowsSelfSizing = true
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.addSubview(keyboardView)
        
        // Create a temporary height constraint that will be removed once React Native measures the view
        let tmpConstraint = keyboardView.heightAnchor.constraint(equalToConstant: initialHeight)
        tmpConstraint.identifier = "tmp-height"
        
        NSLayoutConstraint.activate([
            keyboardView.leadingAnchor.constraint(equalTo: inputView.leadingAnchor),
            keyboardView.trailingAnchor.constraint(equalTo: inputView.trailingAnchor),
            keyboardView.topAnchor.constraint(equalTo: inputView.topAnchor),
            keyboardView.bottomAnchor.constraint(equalTo: inputView.bottomAnchor),
            tmpConstraint,
        ])
        
        return inputView
    }
}


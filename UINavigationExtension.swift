//
//  UINavigationControllerExtension.swift
//
//  Created by Paulo Henrique Leite on 10/11/16.
//

import Foundation

extension UINavigationController {

    internal func pop(completion: (() -> Void)? = nil) {
        self.popViewController(animated: true)
        completion?()
    }

    internal func pop(controller: UIViewController, completion: (() -> Void)? = nil) {
        self.popToViewController(controller, animated: true)
        completion?()
    }

    internal func root(completion: (() -> Void)? = nil) {
        self.popToRootViewController(animated: true)
        completion?()
    }

    internal func push(controller: UIViewController, completion: (() -> Void)? = nil) {
        self.pushViewController(controller, animated: true)
        completion?()
    }

    internal func dequeue<T>() -> T? where T: UIViewController {
        if let controller = self.viewControllers.first(where: { $0 is T }) as? T {
            return controller
        }

        return nil
    }

    internal func load<T>(_ type: StoryboardType) -> T where T: UIViewController {
        let storyboard = UIStoryboard(name: type.name, bundle: nil)

        guard let controller = storyboard.instantiateViewController(withIdentifier: T.identifier) as? T else {
            fatalError("Could not instantiate view controller with identifier: \(T.identifier)")
        }

        return controller
    }

    internal func push<T>(_ type: StoryboardType) -> T where T: UIViewController {
        let storyboard = UIStoryboard(name: type.name, bundle: nil)

        guard let controller = storyboard.instantiateViewController(withIdentifier: T.identifier) as? T else {
            fatalError("Could not instantiate view controller with identifier: \(T.identifier)")
        }

        self.push(controller: controller)

        return controller
    }

    internal func present<T>(_ type: StoryboardType, modal: Bool = false, autoDismissModal: Bool = false) -> T where T: UIViewController {
        let storyboard = UIStoryboard(name: type.name, bundle: nil)

        guard let controller = storyboard.instantiateViewController(withIdentifier: T.identifier) as? T else {
            fatalError("Could not instantiate view controller with identifier: \(T.identifier)")
        }

        controller.modalPresentationStyle = .overFullScreen
        if #available(iOS 13.0, *) {
            controller.isModalInPresentation = !autoDismissModal
        }
        
        if modal {
            self.present(controller, animated: true, completion: nil)
        } else {
            let navigation = UINavigationController(rootViewController: controller)
            self.present(navigation, animated: true, completion: nil)
        }

        return controller
    }

}

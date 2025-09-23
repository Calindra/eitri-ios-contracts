import UIKit

/// Parameters provided by the Eitri SDK when invoking an exposed module method.
///
/// Instances are constructed by the host Eitri SDK and delivered to a module's exposed
/// asynchronous function (`ModuleExposedMethod`).
public struct ModuleMethodParams {
    
    /// Arbitrary structured input payload for the invocation.
    public let data: [String: Any?]

    /// Metadata describing the method being executed and its contract version.
    public let invokingMethod: EitriAppInvokingMethod
    
    /// Current host UIViewController where the caller eitri-app resides
    public var currentViewController: UIViewController
    
    /// Current host UINavigationController where the caller eitri-app resides
    public var currentNavController: UINavigationController? = nil

    /// Creates a new parameter payload.
    /// - Parameters:
    ///   - data: Arbitrary structured payload for the invocation.
    ///   - invokingMethod: Describes the calling eitri-app.
    public init(
        data: [String: Any?],
        invokingMethod: EitriAppInvokingMethod,
        currentViewController: UIViewController,
        currentNavController: UINavigationController?
    ) {
        self.data = data
        self.invokingMethod = invokingMethod
        self.currentViewController = currentViewController
        self.currentNavController = currentNavController
    }

}

/// Contract implemented by a concrete module responsible for a specific capability (e.g., QR scanning).
///
/// Lifecycle expectations:
/// - A host application creates a type conforming to `EitriModule`.
/// - The application delivers the instance to the Eitri SDK by calling `EitriModuleRegistry.registerModule`.
/// - The SDK invokes `start(contextProvider:)`, giving the module access to the runtime `AppContext`
///   and an opportunity to expose callable methods.
public protocol EitriModule {
    /// Called by the Eitri SDK to initialise the module and register exposed methods.
    func start(contextProvider: EitriContextProvider) throws
}

/// Contract implemented by the Eitri SDK component responsible for module registration.
///
/// The host SDK (e.g., the Eitri Machine) implements this protocol. Applications hand their
/// modules to the registry so that the SDK can manage their lifecycle and expose methods.
public protocol EitriModuleRegistry {
    /// Registers a module instance under the provided namespace so that it can be started and invoked.
    func register(module: EitriModule, namespace: String) throws
}

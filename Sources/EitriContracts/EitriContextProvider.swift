/// Runtime bridge supplied by the Eitri SDK when a module starts.
///
/// A module uses the provider to obtain the immutable `AppContext` and to expose
/// asynchronous methods that the host can invoke on demand.
public protocol EitriContextProvider {
    /// Returns the current immutable application context.
    func context() -> AppContext

    /// Registers an exposed method that can be invoked from eitri-apps running on the host application.
    func exposeMethod(named methodName: String, method: @escaping ModuleExposedMethod) throws
}

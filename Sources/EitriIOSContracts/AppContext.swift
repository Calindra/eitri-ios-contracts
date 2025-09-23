import Foundation

/// Runtime context provided by the Eitri SDK to modules.
///
/// The context describes the environment in which a module operates, including the SDK version,
/// debug state, host bundle identifier, etc...
public struct AppContext {
   
    /// Version of the Eitri SDK or contracts visible to the module.
    public let version: String

    /// Indicates whether the host is running in a debug or development configuration.
    public let debugMode: Bool

    /// Bundle identifier of the host application.
    public let bundleIdentifier: String


    /// Creates a new `AppContext`.
    /// - Parameters:
    ///   - version: Version identifier of the contracts visible to the module.
    ///   - debugMode: Whether the host is currently in debug mode.
    ///   - bundleIdentifier: Bundle identifier of the host application.
    public init(
        version: String,
        debugMode: Bool = false,
        bundleIdentifier: String = Bundle.main.bundleIdentifier ?? "",
    ) {
        self.version = version
        self.debugMode = debugMode
        self.bundleIdentifier = bundleIdentifier
    }

}

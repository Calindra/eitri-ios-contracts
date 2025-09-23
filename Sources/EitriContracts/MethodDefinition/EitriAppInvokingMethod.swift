/// Metadata describing the eitri-app invoking a module method.
public struct EitriAppInvokingMethod {
    /// Identifier (slug) of the eitri-app.
    public let slug: String

    /// Version of the eitri-app.
    public let version: String

    public init(slug: String, version: String) {
        self.slug = slug
        self.version = version
    }
}


/// Signature for asynchronous functions that a module exposes to the Eitri SDK.
///
/// Implementations receive a `ModuleMethodParams` payload and may return an optional result that
/// the Eitri SDK forwards to the caller. Throwing propagates failures back to the eitri-app invoking the method.
public typealias ModuleExposedMethod = (ModuleMethodParams) async throws -> Any?

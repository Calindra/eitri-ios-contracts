# eitri-ios-contracts

Contracts for integrating Eitri iOS modules with the Eitri Machine runtime. The package
defines lightweight Swift protocols and value types that standardise how native modules report their
capabilities, expose callable methods, and gain access to runtime context supplied by the Eitri SDK.

## Requirements
- Swift 5.9 or later
- Xcode 15 or later (for local development and testing)
- iOS 13.0 minimum deployment target

## Core concepts

- `EitriModule`: Adopt this protocol in every native module exposed to the Eitri runtime. The runtime
  calls `start(contextProvider:)`, and the module must synchronously finish registering the methods it
  intends to expose. Defer long-running work; blocking `start` will stall host bootstrapping.

- `EitriContextProvider`: A runtime bridge returned to modules during `start`. Use it to read the
  immutable `AppContext` and to register asynchronous handlers via `exposeMethod(named:method:)`.

- `AppContext`: Immutable metadata about the host environment (SDK version, debug flag, bundle
  identifier). Treat it as read-only state that describes the runtime, not the business payload.

- `ModuleExposedMethod`: Type alias for asynchronous handlers. Handlers receive `ModuleMethodParams`
  and may return any JSON-serialisable result. Throwing propagates a failure back to the caller.

- `ModuleMethodParams`: Invocation payload containing structured `data`, the
  `EitriAppInvokingMethod` descriptor for the requesting app, and the `currentViewController` available
  to present UI.

The runtime also exposes an `EitriModuleRegistry` protocol that host applications implement to accept
modules. Modules should never retain the registry; use it only at initial registration time.

## Project structure

- `Sources/EitriContracts`: Protocols and value types that define the native contract surface.
- `Tests/EitriContractsTests`: Integration-style coverage that exercises a fake registry and module.

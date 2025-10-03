import XCTest
@testable import EitriContracts
import UIKit

final class ModulesIntegrationTests: XCTestCase {
    
    func testRegisterModuleAndInvokeMethodThroughRegistry() async throws {

        //setup registry
        let registry = StubModuleRegistry(context: AppContext(
            version: "1.2.3",
            debugMode: true,
            bundleIdentifier: "tech.eitri.tests"
        ))
        
        //register module
        try registry.register(module: MathModule(), namespace: "math")

        // invoke method
        let result = try await registry.invoke(
            namespace: "math",
            methodName: "sum",
            params: await ModuleMethodParams(
                data: ["a": 1.0, "b": 2.0],
                invokingMethod: EitriAppInvokingMethod(
                    slug: "dummy",
                    version: "1.0.0",
                ),
                currentViewController: getFakeUIViewController()
            )
        )

        let numericResult = try XCTUnwrap(result as? Double)
        XCTAssertEqual(numericResult, 3.0, accuracy: 0.000_1)
        XCTAssertNotNil(registry.providers["math"]?.methods["sum"])
    }
    
    @MainActor
    private func getFakeUIViewController() -> UIViewController {
        return UIViewController()
    }
    
    private final class MathModule: EitriModule {
        enum Error: Swift.Error {
            case invalidInput
        }


        func start(contextProvider: EitriContextProvider) throws {
            XCTAssertNotNil(contextProvider.context())
            
            try contextProvider.exposeMethod(named: "sum") { params in
                
                XCTAssertNotNil(params)
                XCTAssertNotNil(params.data)
                XCTAssertNotNil(params.currentViewController)
                XCTAssertEqual(params.invokingMethod.slug, "dummy")
                
                if let a = params.data["a"] as? Double, let b = params.data["b"] as? Double {
                    return a + b
                }
                throw NSError(domain: "math.sum.failed", code: 0)
            }
        }

    }

    private final class StubContextProvider: EitriContextProvider {
        private let appContext: AppContext
        private(set) var methods: [String: ModuleExposedMethod] = [:]

        init(context: AppContext) {
            self.appContext = context
        }

        func context() -> AppContext {
            appContext
        }

        func exposeMethod(named methodName: String, method: @escaping ModuleExposedMethod) {
            methods[methodName] = method
        }
    }

    private final class StubModuleRegistry: EitriModuleRegistry {
        
        private enum InvocationError: Error {
            case methodNotFound(namespace: String, method: String)
        }
        
        private let appContext: AppContext
        private(set) var providers: [String: StubContextProvider] = [:]

        init(context: AppContext) {
            self.appContext = context
        }

        func register(module: EitriModule, namespace: String?) throws {
            let resolvedNamespace = namespace ?? module.namespace()
            let provider = StubContextProvider(context: appContext)
            providers[resolvedNamespace] = provider
            try module.start(contextProvider: provider)
        }

        func invoke(namespace: String, methodName: String, params: ModuleMethodParams) async throws -> Any? {
            guard let method = providers[namespace]?.methods[methodName] else {
                throw InvocationError.methodNotFound(namespace: namespace, method: methodName)
            }
            return try await method(params)
        }
    }
    
}



//
//  Updatable.swift
//
//
//  Created by Maziar Saadatfar on 10/11/23.
//

import Foundation
import ControlKitBase
public protocol Updatable: AnyObject {
    var updateService: GenericServiceProtocol! { get }
}

extension Updatable {
    public func update(request: GenericRequest) async throws -> Result<UpdateResponse> {
        return try await updateService.execute(request: request)
    }
}

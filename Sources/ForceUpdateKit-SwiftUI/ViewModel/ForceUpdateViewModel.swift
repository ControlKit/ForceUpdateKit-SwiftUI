//
//  File.swift
//  
//
//  Created by Maziar Saadatfar on 9/29/23.
//

import Foundation
import SwiftUI
import ControlKitBase

public protocol ForceUpdateViewModel: Actionable {
    var response: UpdateResponse { get set }
    var actionService: GenericServiceProtocol { get set }
    var serviceConfig: UpdateServiceConfig { get set }
    func openLink()
}

public final class DefaultForceUpdateViewModel: ForceUpdateViewModel {
    public var serviceConfig: UpdateServiceConfig
    public var response: UpdateResponse
    public var actionService: GenericServiceProtocol
    public init(
        serviceConfig: UpdateServiceConfig,
        response: UpdateResponse,
        actionService: GenericServiceProtocol = GenericService()
    ) {
        self.serviceConfig = serviceConfig
        self.response = response
        self.actionService = actionService
    }
    public func openLink() {
        if let url = response.data?.link, let urlFinal = URL(string: url) {
            UIApplication.shared.open(urlFinal)
        }
    }
}


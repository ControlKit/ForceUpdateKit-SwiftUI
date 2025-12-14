//
//  UpdateRequest.swift
//
//
//  Created by Maziar Saadatfar on 10/12/23.
//

import Foundation
import ControlKitBase
public struct UpdateRequest: GenericRequest {
    public var route: ControlKitItem = .force_update
    public var itemId: String?
    public var extraParameter: String?
    public var httpMethod: HTTPMethod = .get
    public var appId: String
    
    public var applicationVersion: String = Bundle.main.releaseVersionNumber ?? String()
    public var deviceUUID: String = CKDeviceUUID
    public var sdkVersion: String = forceUpdateKit_Version
    
    public var headers: [String: String] {
        return ["x-app-id": appId,
                "x-version": applicationVersion,
                "x-sdk-version": sdkVersion,
                "x-device-uuid": deviceUUID]
    }
    
    public var body: [String : String] {
        return [:]
    }
}

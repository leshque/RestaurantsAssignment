//
//  AppEnvironment.swift
//  RestorauntsApp
//
//  Created by Aliaksei Prokharau on 21.05.22.
//

import Foundation

class AppEnvironment {
    
    static let shared: AppEnvironment = AppEnvironment()

    lazy var router: RouterProtocol = Router()
    lazy var storageClient: StorageClientProtocol = StorageClient()
    lazy var settingsProvider: SettingsProviderProtocol = UserDefaultsSettingsProvider()
    
}

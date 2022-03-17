//
//  RemoteConfigService.swift
//  Foodly
//
//  Created by apple on 07/07/2021.
//

import FirebaseRemoteConfig
import Foundation

class RemoteConfigService {
    
    var tax = 0.05
    
    func fetchValues(insertedCode: String, completion: @escaping (Result <String, Error>) -> Void ) {
        let defaults: [ String: NSObject] = [
            "Promo_Code": " " as NSObject
        ]
        
        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.setDefaults(defaults)
        
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        remoteConfig.fetch(withExpirationDuration: 0, completionHandler: { status, error in
            if status == .success, error == nil {
                remoteConfig.activate(completion: { _, error in
                    guard error == nil else {
                        return
                    }
                    let value = remoteConfig.configValue(forKey: "Promo_Code").stringValue
                    guard let checkPromo = value?.components(separatedBy: " ") else {
                        return
                    }
                    print(checkPromo)
                    let newTax = remoteConfig.configValue(forKey: "Tax").numberValue.doubleValue
                    self.tax = newTax
                    _ = remoteConfig.configValue(forKey: "Promo_Code_Value").numberValue
                    DispatchQueue.main.async {
                        if checkPromo.contains(insertedCode) {
                            completion(.success("Congrats! Promo Code is valid"))
                        } else {
                            completion(.failure(CustomError.init(errorMessage: "Promo Code does not match")))
                        }
                    }
                })
            } 
        })
    }
}

struct CustomError: LocalizedError {
    var errorDescription: String? {
        return errorMessage
    }
    
    let errorMessage: String?
}

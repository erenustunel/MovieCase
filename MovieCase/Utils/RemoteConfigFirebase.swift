//
//  RemoteConfigFirebase.swift
//  MovieCase
//
//  Created by Eren Üstünel on 15.03.2022.
//

import Foundation
import FirebaseRemoteConfig
import Firebase

enum ValueKey: String {
  case splashTitle
}

class RCValues {

    static let shared = RCValues()
    
    var loadingDoneCallback: (() -> Void)?
    var fetchComplete = false

    private init() {
      loadDefaultValues()
    }

    func loadDefaultValues() {
        let appDefaults: [String: Any?] = [
            ValueKey.splashTitle.rawValue : ""
        ]
      
        RemoteConfig.remoteConfig().setDefaults(appDefaults as? [String: NSObject])
        fetchCloudValues()
    }

    func fetchCloudValues() {
        RemoteConfig.remoteConfig().fetchAndActivate { [weak self] status, error in

            if let error = error {
                print ("Got an error fetching remote values \(error)")
                return
            }

            print ("Retrieved values from the cloud!")

            self?.fetchComplete = true
            self?.loadingDoneCallback?()
        }
    }
    
    func string(forKey key: ValueKey) -> String {
        return RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? ""
    }
}

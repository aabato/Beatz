//
//  Spotify.swift
//  MoodAlarmS
//
//  Created by Angelica Bato on 7/12/16.
//  Copyright © 2016 Angelica Bato. All rights reserved.
//

import UIKit

class Spotify {

    static let manager = Spotify()
    
    var session: SPTSession?
    let auth = SPTAuth.defaultInstance()
    
    init() {
        self.setupAuth()
        self.session = self.sessionFromUserDefaults()
        if let session = self.session where !session.isValid() {
            self.renewSession{ _ in }
        }
        
        let loginURL = auth.loginURL
        UIApplication.sharedApplication().performSelector(#selector(UIApplication.openURL), withObject: loginURL, afterDelay: 0.1)
        
    }
    
    func setupAuth() {
        let auth = SPTAuth.defaultInstance()
        auth.clientID = spotifyClientID
        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthUserLibraryReadScope, SPTAuthPlaylistReadPrivateScope]
        auth.redirectURL = NSURL.init(string: "moodalarm-app-scheme://oauth")
        auth.tokenSwapURL = NSURL.init(string: "https://polar-taiga-37562.herokuapp.com/swap")
        auth.tokenRefreshURL = NSURL.init(string: "https://polar-taiga-37562.herokuapp.com/refresh")
        auth.sessionUserDefaultsKey = "SpotifySession"

    }
    
    func sessionFromUserDefaults() -> SPTSession? {
        if let sessionData = NSUserDefaults.standardUserDefaults().objectForKey("SpotifySession") as? NSData,
            let session = NSKeyedUnarchiver.unarchiveObjectWithData(sessionData) as? SPTSession {
            return session
        }
        return nil
    }
    
    func renewSession(completion: (wasRenewed: Bool) -> Void) {
        if let session = self.session where !session.isValid() {
            self.auth.renewSession(session, callback: { error, session in
                if error != nil {
                    completion(wasRenewed: false)
                } else if let session = session {
                    self.session = session
                    completion(wasRenewed: true)
                }
            })
        } else {
            if let session = self.session where session.isValid() {
                completion(wasRenewed: true)
            } else {
                completion(wasRenewed: false)
            }
        }
    }
    
    
    
    
}

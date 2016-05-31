//
//  MASpotifyAPI.m
//  MoodAlarm
//
//  Created by Angelica Bato on 5/26/16.
//  Copyright © 2016 Angelica Bato. All rights reserved.
//

#import "MASpotifyAPIClient.h"

@implementation MASpotifyAPIClient

+ (void)setupSpotifyOAuth {
    
    SPTAuth *auth = [SPTAuth defaultInstance];
    auth.clientID = SpotifyClientID;
    auth.requestedScopes = @[SPTAuthStreamingScope,SPTAuthUserLibraryReadScope];
    auth.redirectURL = [NSURL URLWithString:@"moodalarm-app-scheme://oauth"];
    auth.tokenSwapURL = [NSURL URLWithString:@"https://polar-taiga-37562.herokuapp.com/swap"];
    auth.tokenRefreshURL = [NSURL URLWithString:@"https://polar-taiga-37562.herokuapp.com/refresh"];
    auth.sessionUserDefaultsKey = @"SpotifySession";
    
    NSURL *loginURL = [auth loginURL];
    
    [[UIApplication sharedApplication] performSelector:@selector(openURL:) withObject:loginURL afterDelay:0.1];
    
}






@end

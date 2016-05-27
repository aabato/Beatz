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
    [[SPTAuth defaultInstance] setClientID:SpotifyClientID];
    [[SPTAuth defaultInstance] setRedirectURL:[NSURL URLWithString:@"moodAlarm-app-scheme://oauth"]];
    [[SPTAuth defaultInstance] setRequestedScopes:@[SPTAuthStreamingScope,SPTAuthUserLibraryReadScope]];
    
    NSURL *loginURL = [[SPTAuth defaultInstance] loginURL];
    
    [[UIApplication sharedApplication] performSelector:@selector(openURL:) withObject:loginURL afterDelay:0.3];
}



@end

//
//  MASpotifyAPI.h
//  MoodAlarm
//
//  Created by Angelica Bato on 5/26/16.
//  Copyright © 2016 Angelica Bato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Spotify/Spotify.h>
#import "Secrets.h"

@interface MASpotifyAPIClient : NSObject

@property (strong, nonatomic) SPTSession *session;
@property (strong, nonatomic) SPTAudioStreamingController *player;

+ (void)setupSpotifyOAuth;

@end

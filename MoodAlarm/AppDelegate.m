//
//  AppDelegate.m
//  MoodAlarm
//
//  Created by Angelica Bato on 5/23/16.
//  Copyright © 2016 Angelica Bato. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    SPTAuth *auth = [SPTAuth defaultInstance];
    auth.clientID = SpotifyClientID;
    auth.requestedScopes = @[SPTAuthStreamingScope,SPTAuthUserLibraryReadScope];
    auth.redirectURL = [NSURL URLWithString:@"moodAlarm-app-scheme://oauth"];
    auth.tokenSwapURL = [NSURL URLWithString:@""];
    auth.tokenRefreshURL = [NSURL URLWithString:@""];
    auth.sessionUserDefaultsKey = @"SpotifySession";
    
    NSURL *loginURL = [auth loginURL];
    
    [application performSelector:@selector(openURL:) withObject:loginURL afterDelay:0.1];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    NSLog(@"APP DELEGATE WUT");
    
    SPTAuth *auth = [SPTAuth defaultInstance];
    
    SPTAuthCallback authCallBack = ^(NSError *error, SPTSession *session) {
        if (error) {
            NSLog(@"****Auth error: %@", error);
            return;
        }
        
        auth.session = session;
        NSLog(@"posting notification");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sessionUpdated" object:nil];
        
    };
    
    if([auth canHandleURL:url]) {
        [auth handleAuthCallbackWithTriggeredAuthURL:url callback:authCallBack];
        return YES;
    }
    NSLog(@"Spotify hates me...");
    return NO;
}

@end

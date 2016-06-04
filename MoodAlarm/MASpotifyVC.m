//
//  MASpotifyVC.m
//  MoodAlarm
//
//  Created by Angelica Bato on 5/26/16.
//  Copyright © 2016 Angelica Bato. All rights reserved.
//

#import "MASpotifyVC.h"

@interface MASpotifyVC ()

@end

@implementation MASpotifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionUpdatedNotification:) name:@"sessionUpdated" object:nil];

}

-(void)sessionUpdatedNotification:(NSNotification *)notification {
    NSLog(@"session is updated");
    SPTAuth *auth = [SPTAuth defaultInstance];
    NSLog(@"%@",auth.session);
    
    if (auth.session && [auth.session isValid]) {
        NSLog(@"valid session");
        
        NSString *name = [auth.session canonicalUsername];
        NSURLRequest *discoverRequest = [SPTPlaylistList createRequestForGettingPlaylistsForUser:name withAccessToken:auth.session.accessToken error:nil];
        
        [[SPTRequest sharedHandler] performRequest:discoverRequest callback:^(NSError *error, NSURLResponse *response, NSData *data) {
            
            SPTPlaylistList *playlists = [SPTPlaylistList playlistListFromData:data withResponse:response error:nil];

            for (SPTPartialPlaylist *playlist in playlists.items) {
                NSLog(@"PG1 -- Playlist name: %@",playlist.name);
                
                if ([playlist.name isEqualToString:@"Discover Weekly"]) {
                    
                    NSURLRequest *tracksSnapshotReq = [SPTPlaylistSnapshot createRequestForPlaylistWithURI:playlist.uri accessToken:auth.session.accessToken error:nil];
                    
                    [[SPTRequest sharedHandler] performRequest:tracksSnapshotReq callback:^(NSError *error2, NSURLResponse *response2, NSData *data2) {
                        
                        SPTPlaylistSnapshot *snap = [SPTPlaylistSnapshot playlistSnapshotFromData:data2 withResponse:response2 error:nil];
                        
                        NSMutableArray *trackIDs = [NSMutableArray new];
                        for (SPTPlaylistTrack *track in snap.firstTrackPage.tracksForPlayback) {
                            [trackIDs addObject:track.identifier];
                        }
                        
                        NSString *trackIDsCommaSep = [trackIDs componentsJoinedByString:@","];
                        NSLog(@"%@",trackIDsCommaSep);
                        
                        NSString *fullURLForReq = [NSString stringWithFormat:@"%@audio-features?ids=%@",SpotifyAPIBaseURL,trackIDsCommaSep];
                        NSLog(@"URL: %@",fullURLForReq);
                        
                        NSMutableURLRequest *req = [self authenticatedSpotifyRequestforURL:fullURLForReq];
                        
                        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                            
                            NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                            NSLog(@"%@",json);
                            
                        }];
                        
                        [task resume];
                        
                    }];
                    
                    break;
                }
                
            }
            
//            NSURLRequest *reqForPage2 = [playlists createRequestForNextPageWithAccessToken:auth.session.accessToken error:nil];
//            [[SPTRequest sharedHandler] performRequest:reqForPage2 callback:^(NSError *error2, NSURLResponse *response2, NSData *data2) {
//                SPTPlaylistList *playlists2 = [SPTPlaylistList playlistListFromData:data2 withResponse:response2 error:nil];
//                NSLog(@"Second req: %@",playlists2);
//                for (SPTPartialPlaylist *playlist2 in playlists2.items) {
//                    NSLog(@"PG2 -- Playlist name: %@",playlist2.name);
//                }
//                NSURLRequest *reqForPage3 = [playlists2 createRequestForNextPageWithAccessToken:auth.session.accessToken error:nil];
//                [[SPTRequest sharedHandler] performRequest:reqForPage3 callback:^(NSError *error3, NSURLResponse *response3, NSData *data3) {
//                    SPTPlaylistList *playlists3 = [SPTPlaylistList playlistListFromData:data3 withResponse:response3 error:nil];
//                    NSLog(@"Third req: %@", playlists3);
//                    for (SPTPartialPlaylist *playlist3 in playlists3.items) {
//                        NSLog(@"PG3 -- Playlist name: %@", playlist3.name);
//                    }
//                }];
//            }];
        }];
        
    }
    else if (auth.session && ![auth.session isValid]) {
        [auth renewSession:auth.session callback:^(NSError *error, SPTSession *session) {
            auth.session = session;
            NSLog(@"renewed session");
        }];
    }

}

-(NSMutableURLRequest *)authenticatedSpotifyRequestforURL:(NSString *)URLString {
    
    SPTAuth *auth = [SPTAuth defaultInstance];
    NSLog(@"auth session set");
    if ([auth.session isValid]) {
        NSLog(@"session is valid");
        
        NSString *token = auth.session.accessToken;
        NSLog(@"Token: %@", token);
        NSURL *url = [NSURL URLWithString:URLString];
        NSString *authorizationHeaderValue = [NSString stringWithFormat:@"Bearer %@",token];
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
        [req setValue:authorizationHeaderValue forHTTPHeaderField:@"Authorization"];
        
        NSLog(@"returning %@", req);
        
        return req;
    }
    
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

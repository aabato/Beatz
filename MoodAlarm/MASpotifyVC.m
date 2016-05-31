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
        
        [SPTPlaylistList playlistsForUserWithSession:auth.session callback:^(NSError *error, id object) {
            NSLog(@"Result: %@",object);
            SPTPlaylistList *list = object;
            for(SPTPartialPlaylist *track in list.items) {
                NSLog(@"Playlist: %@",track.name);
            }
        }];
        
    }
    else if (auth.session && ![auth.session isValid]) {
        [auth renewSession:auth.session callback:^(NSError *error, SPTSession *session) {
            auth.session = session;
            NSLog(@"renewed session");
        }];
    }

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

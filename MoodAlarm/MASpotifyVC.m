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
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(something:) name:@"sessionUpdated" object:nil];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)something:(NSNotification *)notification {
    NSLog(@"session is updated");
    SPTAuth *auth = [SPTAuth defaultInstance];
    if (auth.session && [auth.session isValid]) {
        //
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

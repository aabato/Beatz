//
//  MoodAlarmSetVC.m
//  Beatz
//
//  Created by Angelica Bato on 5/23/16.
//  Copyright © 2016 Angelica Bato. All rights reserved.
//

#import "MoodAlarmSetVC.h"
#import <INTULocationManager/INTULocationManager.h>

@interface MoodAlarmSetVC () <CLLocationManagerDelegate>

@property (retain, nonatomic) CLLocationManager *locationManager;
@property (assign, nonatomic) CGFloat latitude;
@property (assign, nonatomic) CGFloat longitude;


@end

@implementation MoodAlarmSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    UIButton *getLocationButton = [[UIButton alloc] init];
    [getLocationButton setTitle:@"Get Location" forState:UIControlStateNormal];
    [getLocationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    [self.view addSubview:getLocationButton];
    getLocationButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [getLocationButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [getLocationButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [getLocationButton.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.7].active = YES;
    [getLocationButton.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.1].active = YES;
    
    [getLocationButton addTarget:self action:@selector(getLocButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(IBAction)getLocButtonTapped:(id)sender {
    NSLog(@"Button tapped!");
    
    INTULocationManager *manager = [INTULocationManager sharedInstance];
    
    [manager requestLocationWithDesiredAccuracy:INTULocationAccuracyBlock timeout:0.0 block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        if (status == INTULocationStatusSuccess) {
            NSLog(@"%@",currentLocation);
            NSLog(@"%f,%f",currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
            self.latitude = currentLocation.coordinate.latitude;
            self.longitude = currentLocation.coordinate.longitude;
        }
        else if (status == INTULocationStatusTimedOut) {
            NSLog(@"Timed out");
        }
        else {
            NSLog(@"ERROR");
        }
    }];
    
    [manager subscribeToLocationUpdatesWithDesiredAccuracy:INTULocationAccuracyCity block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        if (status == INTULocationStatusSuccess) {
            NSLog(@"SUCCESS");
        }
        else {
            NSLog(@"ERROR");
        }
    }];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Failed to Get Your Location" message:@"Try again!" preferredStyle:UIAlertControllerStyleAlert];
                                     
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [errorAlert addAction:ok];
    
    [self presentViewController:errorAlert animated:YES completion:nil];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    NSLog(@"%@, %@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude],[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"HELLO:%@",locations[0]);
}

- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
            NSLog(@"User still thinking..");
        } break;
        case kCLAuthorizationStatusDenied: {
            NSLog(@"User hates you");
        } break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways: {
            [self.locationManager startUpdatingLocation];
        } break;
        default:
            break;
    }
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

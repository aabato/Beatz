//
//  MoodAlarmSetVC.m
//  Beatz
//
//  Created by Angelica Bato on 5/23/16.
//  Copyright © 2016 Angelica Bato. All rights reserved.
//

#import "MASetLocation.h"
@import CoreLocation;

//#import <INTULocationManager/INTULocationManager.h>

@interface MASetLocation () <CLLocationManagerDelegate>

@property (retain, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *state;

@end

@implementation MASetLocation

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.locationManager = [[CLLocationManager alloc] init];
//    self.locationManager.delegate = self;
    
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
    [self getLocation];
}

- (void)getLocation {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
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

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    self.currentLocation = [locations lastObject];
    self.latitude = [NSString stringWithFormat:@"%f",self.currentLocation.coordinate.latitude];
    self.longitude = [NSString stringWithFormat:@"%f",self.currentLocation.coordinate.longitude];
    
    [self.locationManager startUpdatingLocation];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:self.currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        NSUInteger count = placemarks.count;
        
        for (CLPlacemark *placemark in placemarks) {
            self.city = [placemark locality];
            self.state = [placemark administrativeArea];
            NSLog(@"%@, %@", self.city, self.state);
            count--;
        }
        if (count == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"locationInfoComplete" object:nil];
        }
    }];
    
//    NSLog(@"HELLO:%@",[locations lastObject]);
    
    
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

//
//  MoodAlarmSetVC.m
//  Beatz
//
//  Created by Angelica Bato on 5/23/16.
//  Copyright © 2016 Angelica Bato. All rights reserved.
//

#import "MASetLocation.h"
#import "MAWeatherAPI.h"
#import "MALocationStore.h"
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
    
    UIButton *getLocationButton = [[UIButton alloc] init];
    [getLocationButton setTitle:@"Get Weather" forState:UIControlStateNormal];
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
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"2");
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        self.locationManager.delegate = self;
        [self.locationManager requestWhenInUseAuthorization];
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        [self.locationManager startUpdatingLocation];
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

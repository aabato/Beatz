//
//  MAWeatherVC.m
//  MoodAlarm
//
//  Created by Angelica Bato on 5/26/16.
//  Copyright © 2016 Angelica Bato. All rights reserved.
//

#import "MAWeatherVC.h"
#import "MALocationStore.h"

@interface MAWeatherVC ()

@property (strong, nonatomic) UIActivityIndicatorView *actIndicator;
@property (strong, nonatomic) NSDictionary *currently;
@property (strong, nonatomic) NSDictionary *day;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) MALocationStore *dataStore;

@property (strong, nonatomic) UILabel *currentTempLabel;
@property (strong, nonatomic) UILabel *currentSummaryLabel;

@end

@implementation MAWeatherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.actIndicator = [[UIActivityIndicatorView alloc] init];
    [self.view addSubview:self.actIndicator];
    [self.actIndicator startAnimating];
    
    self.dataStore = [MALocationStore sharedStore];
    [self.dataStore getLocation];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadWeatherView:) name:@"locationInfoComplete" object:nil];
    
}


-(void)loadWeatherView:(NSNotification *)notification {
    NSLog(@"notification center said to start");
    [self.actIndicator stopAnimating];
    [self.actIndicator setHidden:YES];
    
    self.currentTempLabel = [[UILabel alloc] init];
    self.currentSummaryLabel = [[UILabel alloc] init];
    
    [self.dataStore getWeatherWithCompletionBlock:^(NSDictionary *currently, NSDictionary *day) {
        NSLog(@"Currently: %@",currently);
        NSLog(@"Temp:%@", currently[@"apparentTemperature"]);
        NSLog(@"Summary:%@", currently[@"summary"]);
        self.currently = currently;
        NSLog(@"Day: %@",day);
        self.day = day;
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.currentTempLabel.text = [NSString stringWithFormat:@"%@",self.currently[@"apparentTemperature"]];
            self.currentSummaryLabel.text = [NSString stringWithFormat:@"%@",self.currently[@"summary"]];
        }];
        
    }];
    
    UIStackView *myStack = [[UIStackView alloc] initWithArrangedSubviews:@[self.currentTempLabel, self.currentSummaryLabel]];
    myStack.axis = UILayoutConstraintAxisVertical;
    
    [self.view addSubview:myStack];
    
    myStack.translatesAutoresizingMaskIntoConstraints = NO;
    
    [myStack.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [myStack.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [myStack.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.7].active = YES;
    [myStack.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.3].active = YES;
    
    myStack.distribution = UIStackViewDistributionFillEqually;
    myStack.spacing = 15.0;

    
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

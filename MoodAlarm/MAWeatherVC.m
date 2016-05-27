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
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) MALocationStore *dataStore;

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
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateCurrentInfo:(NSNotification *)notification {
    NSArray *currentInfo = [self.dataStore getCurrentLocationInformation];
    self.latitude = currentInfo[0];
    self.longitude = currentInfo[1];
}

-(void)loadWeatherView:(NSNotification *)notification {
    NSLog(@"notification center said to start");
    [self.actIndicator stopAnimating];
    [self.actIndicator setHidden:YES];
    
    [self.dataStore getWeatherWithCompletionBlock:^(BOOL success) {
        NSLog(@"%d",success);
    }];
    
    UILabel *cityInfo = [[UILabel alloc] init];
    UILabel *currentWeatherOfCity = [[UILabel alloc] init];
    
    UIStackView *myStack = [[UIStackView alloc] initWithArrangedSubviews:@[cityInfo, currentWeatherOfCity]];
    myStack.axis = UILayoutConstraintAxisVertical;
    
    [self.view addSubview:myStack];
    
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
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

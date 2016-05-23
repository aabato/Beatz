//
//  ViewController.m
//  Beatz
//
//  Created by Angelica Bato on 5/18/16.
//  Copyright © 2016 Angelica Bato. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController () <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (strong, nonatomic) UIButton *startPulseButton;
@property (strong, nonatomic) UIButton *stopPulseButton;
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureDevice *camera;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildInitialView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startPulseButtonTapped:(id)sender {
    NSLog(@"Tapped!");
    
    [self startCameraCapture];
    
}

- (IBAction)stopPulseButtonTapped:(id)sender {
    NSLog(@"Stopped!");
    [self.session stopRunning];
    self.session = nil;
}

- (void)startCameraCapture {
    self.session = [[AVCaptureSession alloc] init];
    self.camera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if([self.camera isTorchModeSupported:AVCaptureTorchModeOn]) {
        [self.camera lockForConfiguration:nil];
        self.camera.torchMode = AVCaptureTorchModeOn;
        [self.camera unlockForConfiguration];
    }
    NSError *error=nil;
    AVCaptureInput* cameraInput = [[AVCaptureDeviceInput alloc] initWithDevice:self.camera error:&error];
    if (cameraInput == nil) {
        NSLog(@"Error to create camera capture:%@",error);
    }
    AVCaptureVideoDataOutput *videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    dispatch_queue_t captureQueue = dispatch_queue_create("captureQueue", NULL);
    [videoOutput setSampleBufferDelegate:self queue:captureQueue];
    
    [self.session setSessionPreset:AVCaptureSessionPresetLow];
    
    [self.session addInput:cameraInput];
    [self.session addOutput:videoOutput];
    
    [self.session startRunning];
    
    [UIApplication sharedApplication].idleTimerDisabled = YES;
}

- (void) buildInitialView {
    
    //Gradient
    self.view.tintColor = [UIColor colorWithRed:184.0/255.0 green:26.0/255.0 blue:67.0/255.0 alpha:1.0];
    UIColor *gradientMaskLayer = [UIColor colorWithRed:131.0/255.0 green:26.0/255.0 blue:36.0/255.0 alpha:1.0];
    CAGradientLayer *gradientMask = [CAGradientLayer layer];
    gradientMask.frame = self.view.bounds;
    gradientMask.colors = @[(id)gradientMaskLayer.CGColor,(id)[UIColor clearColor].CGColor];
    
    [self.view.layer insertSublayer:gradientMask atIndex:0];
    
    self.startPulseButton = [[UIButton alloc] init];
    [self.startPulseButton setTitle:@"Collect pulse" forState:UIControlStateNormal];
    [self.startPulseButton setBackgroundColor:[UIColor lightGrayColor]];
    [self.startPulseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.startPulseButton.layer.cornerRadius = 20;
    self.startPulseButton.clipsToBounds = YES;
    [self.startPulseButton addTarget:self action:@selector(startPulseButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.stopPulseButton = [[UIButton alloc] init];
    [self.stopPulseButton setTitle:@"Stop collecting pulse" forState:UIControlStateNormal];
    [self.stopPulseButton setBackgroundColor:[UIColor lightGrayColor]];
    [self.stopPulseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.stopPulseButton.layer.cornerRadius = 20;
    self.stopPulseButton.clipsToBounds = YES;
    [self.stopPulseButton addTarget:self action:@selector(stopPulseButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIStackView *myStack = [[UIStackView alloc] initWithArrangedSubviews:@[self.startPulseButton, self.stopPulseButton]];
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

@end

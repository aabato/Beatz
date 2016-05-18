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
    self.startPulseButton = [[UIButton alloc] init];
    [self.startPulseButton setTitle:@"Collect heartbeat" forState:UIControlStateNormal];
    [self.startPulseButton setBackgroundColor:[UIColor lightGrayColor]];
    [self.startPulseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.startPulseButton.layer.cornerRadius = 20;
    self.startPulseButton.clipsToBounds = YES;
    [self.startPulseButton addTarget:self action:@selector(startPulseButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.startPulseButton];
    
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.startPulseButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.startPulseButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.startPulseButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [self.startPulseButton.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.7].active = YES;
    [self.startPulseButton.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.1].active = YES;
}

@end

//
//  ScanViewController.m
//  supermarket
//
//  Created by Emiliano Bivachi on 06/11/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "ScanViewController.h"
#import "ScanResultView.h"

@import AVFoundation;

@interface ScanViewController () <AVCaptureMetadataOutputObjectsDelegate, ScanResultViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *cameraView;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic) BOOL isPresentingProduct;
@property (nonatomic, strong) ScanResultView *resultView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isPresentingProduct = NO;
    [self startReading];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [self.delegate backFromViewController:self];
}

- (BOOL)startReading {
    NSError *error;
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession addInput:input];
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[captureMetadataOutput availableMetadataObjectTypes]];
    NSLog(@"%@",[captureMetadataOutput availableMetadataObjectTypes]);
    
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_cameraView.layer.bounds];
    [_cameraView.layer addSublayer:_videoPreviewLayer];
    
    [_captureSession startRunning];
    
    self.cancelButton.alpha = 1.0;
    
    return YES;
}

-(void)stopReading{
    self.cancelButton.alpha = 0.0;
    [_captureSession stopRunning];
    _captureSession = nil;
    [_videoPreviewLayer removeFromSuperlayer];
}

- (void)presentProductWithCode:(NSString *)barCode {
    [self stopReading];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.isPresentingProduct = YES;
        self.resultView = [[ScanResultView alloc]init];
        self.resultView.center = self.view.center;
        self.resultView.delegate = self;
        [self.view addSubview:self.resultView];
        [NSTimer scheduledTimerWithTimeInterval:3.0
                                         target:self.resultView
                                       selector:@selector(shopItemFound:)
                                       userInfo:nil
                                        repeats:NO];
    });
}

#pragma mark - ScanResultViewDelegate

- (void)scanAgain {
    [self startReading];
    [self.resultView removeFromSuperview];
    self.resultView = nil;
    self.isPresentingProduct = NO;
}

- (void)addShopItem {
    [self.delegate backFromViewController:self withObject:nil];
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        if (self.isPresentingProduct == NO) {
            AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
            NSLog(@"%@",[metadataObj stringValue]);
            [self presentProductWithCode:[metadataObj stringValue]];
        }
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

//
//  ScanResultView.m
//  supermarket
//
//  Created by Emiliano Bivachi on 06/11/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "ScanResultView.h"

@interface ScanResultView ()
@property (nonatomic, strong) UIView *image;
@property (nonatomic, strong) UILabel *productNameLabel;
@property (nonatomic, strong) UILabel *productBrandLabel;
@property (nonatomic, strong) UILabel *productPriceLabel;
@property (nonatomic, strong) UIButton *addProductButton;
@property (nonatomic, strong) UIButton *scanAgainButton;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation ScanResultView

#define BUTTON_HEIGHT 50.0f
#define SQUARE_SIDE 150.0f

- (id)init {
    self = [super initWithFrame:CGRectMake(0.0, 0.0, SQUARE_SIDE, SQUARE_SIDE)];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        
        self.activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self.activityIndicatorView startAnimating];
        self.activityIndicatorView.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
        [self addSubview:self.activityIndicatorView];
        
    }
    return self;
}

- (void)shopItemFound:(NSDictionary *)item {
    [self.activityIndicatorView stopAnimating];
    [self.activityIndicatorView removeFromSuperview];
    
    CGPoint center = self.center;
    self.frame = CGRectMake(0.0, 0.0, 230.0, 270.0);
    self.center = center;
    
    CGFloat yButtons = self.frame.size.height - BUTTON_HEIGHT;
    self.addProductButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addProductButton setTitle:@"Add" forState:UIControlStateNormal];
    self.addProductButton.frame = CGRectMake(0.0, yButtons, self.frame.size.width/2, BUTTON_HEIGHT);
    [self.addProductButton setBackgroundColor:[UIColor greenColor]];
    [self.addProductButton addTarget:self action:@selector(addShopItem) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addProductButton];
    
    self.scanAgainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.scanAgainButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.scanAgainButton setBackgroundColor:[UIColor redColor]];
    self.scanAgainButton.frame = CGRectMake(self.frame.size.width/2, yButtons, self.frame.size.width/2, BUTTON_HEIGHT);
    [self.scanAgainButton addTarget:self action:@selector(scanAgain) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.scanAgainButton];
    
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}

- (void)scanAgain {
    [self.delegate scanAgain];
}

- (void)addShopItem {
    [self.delegate addShopItem];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

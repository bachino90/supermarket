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
@end

@implementation ScanResultView

#define BUTTON_HEIGHT 50.0f

- (id)init {
    self = [super initWithFrame:CGRectMake(0.0, 0.0, 200.0, 200.0)];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        
        CGFloat yButtons = self.frame.size.height - BUTTON_HEIGHT;
        self.addProductButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.addProductButton setTitle:@"Add" forState:UIControlStateNormal];
        self.addProductButton.frame = CGRectMake(0.0, yButtons, self.frame.size.width/2, BUTTON_HEIGHT);
        [self.addProductButton setBackgroundColor:[UIColor greenColor]];
        [self.addProductButton addTarget:self action:@selector(addProduct) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.addProductButton];
        
        self.scanAgainButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.scanAgainButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.scanAgainButton setBackgroundColor:[UIColor redColor]];
        self.scanAgainButton.frame = CGRectMake(self.frame.size.width/2, yButtons, self.frame.size.width/2, BUTTON_HEIGHT);
        [self.scanAgainButton addTarget:self action:@selector(scanAgain) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.scanAgainButton];
        
    }
    return self;
}

- (void)scanAgain {
    [self.delegate scanAgain];
}

- (void)addProduct {
    [self.delegate addProduct];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

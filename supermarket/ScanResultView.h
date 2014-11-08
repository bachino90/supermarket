//
//  ScanResultView.h
//  supermarket
//
//  Created by Emiliano Bivachi on 06/11/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScanResultViewDelegate <NSObject>
- (void)scanAgain;
- (void)addProduct;
@end

@interface ScanResultView : UIView
@property (nonatomic, weak) id <ScanResultViewDelegate> delegate;
@end

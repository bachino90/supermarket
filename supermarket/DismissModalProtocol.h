//
//  DismissModalProtocol.h
//  supermarket
//
//  Created by Emiliano Bivachi on 06/11/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@protocol DismissModalProtocol <NSObject>
@required
- (void)backFromViewController:(UIViewController *)vc;
@optional
- (void)backFromViewController:(UIViewController *)vc withObject:(id)obj;
@end

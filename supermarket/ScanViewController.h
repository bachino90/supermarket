//
//  ScanViewController.h
//  supermarket
//
//  Created by Emiliano Bivachi on 06/11/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DismissModalProtocol.h"

@interface ScanViewController : UIViewController

@property (nonatomic, weak) id <DismissModalProtocol> delegate;

@end

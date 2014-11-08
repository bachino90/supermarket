//
//  ShopItem.h
//  supermarket
//
//  Created by Emiliano Bivachi on 08/11/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ShopItem : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * price;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * barcode;
@property (nonatomic, retain) NSString * brand;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * imageURL;

@end

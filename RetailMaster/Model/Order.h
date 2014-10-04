//
//  Order.h
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import <Parse/Parse.h>

@interface Order : PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property (retain) NSString *orderNumber;
@property (retain) NSArray *orderedObjects;
@property (retain) NSNumber *orderPrice;
@property (retain) NSNumber *isPaid;
@property (retain) NSString *orderPickupLocation;
@property (retain) NSDate *orderPickupDate;

@end

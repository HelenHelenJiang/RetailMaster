//
//  Order.m
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "Order.h"
#import <Parse/PFObject+Subclass.h>

@implementation Order

@dynamic orderedObjects;
@dynamic objectId;
@dynamic orderNumber;
@dynamic orderPickupDate;
@dynamic orderPickupLocation;
@dynamic orderPrice;

+ (NSString *)parseClassName
{
    return @"Order";
}

@end

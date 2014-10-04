//
//  Item.m
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "Item.h"
#import <Parse/PFObject+Subclass.h>

@implementation Item

@dynamic isSold;
@dynamic itemDescription;
@dynamic price;
@dynamic nutritionFact;
@dynamic catagory;

+ (NSString *)parseClassName
{
    return @"Item";
}

@end

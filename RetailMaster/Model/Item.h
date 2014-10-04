//
//  Item.h
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import <Parse/Parse.h>

@interface Item :  PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property (retain) NSNumber *isSold;
@property (retain) NSString *nutritionFact;
@property (retain) NSNumber *price;
@property (retain) NSString *itemDescription;
@property (retain) NSString *catagory;

@end

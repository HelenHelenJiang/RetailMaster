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
@property (retain) NSDictionary *nutritionFact;
@property (retain) NSNumber *price;
@property (retain) NSString *itemDescription;
@property (retain) NSString *catagory;
@property (retain) NSString *imageURL;
@property (retain) NSString *name;


@property (nonatomic) NSUInteger orderCount;

@end

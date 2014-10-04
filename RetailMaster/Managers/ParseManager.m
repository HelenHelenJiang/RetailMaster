//
//  ParseManager.m
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "ParseManager.h"
#import "Item.h"

@implementation ParseManager

+ (instancetype)sharedManager
{
    static ParseManager *sharedManager;
    
    @synchronized(self)
    {
        if (!sharedManager) {
            sharedManager = [[ParseManager alloc] init];
        }
        return sharedManager;
    }
}

- (void)updateItem
{
    Item *item = [Item object];
    
    item.catagory = @"Bakery";
    item.itemDescription = @"Triangle Buns Focaccia or Multigrain";
    item.price = [NSNumber numberWithDouble:2.99];
    item.nutritionFact = @"Grain";
    item.isSold = [NSNumber numberWithBool:NO];
    item.imageURL = @"";
    
    [item saveInBackgroundWithBlock:^(BOOL success, NSError *error){
        
    }];
}

@end

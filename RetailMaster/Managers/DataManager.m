//
//  DataManager.m
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "DataManager.h"
#import "Item.h"

@implementation DataManager

+ (instancetype)sharedManager
{
    static DataManager *sharedManager;
    
    @synchronized(self)
    {
        if (!sharedManager) {
            sharedManager = [[DataManager alloc] init];
            sharedManager.shoppingLists = [NSMutableArray array];
        }
        return sharedManager;
    }
}

- (void)addToShoppingList:(Item *)item
{
    [self.shoppingLists addObject:item];
}

@end

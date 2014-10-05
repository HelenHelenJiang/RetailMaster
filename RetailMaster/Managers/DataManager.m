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
    if ([self.shoppingLists containsObject:item])
    {
        item.orderCount++;
    }
    else
    {
        item.orderCount = 1;
        [self.shoppingLists addObject:item];
    }
    
}

-(void)setPhoneNumber:(NSString *)phoneNumber {
    self.phoneNumber = phoneNumber;
}

-(void)setName:(NSString *)name {
    if (name == nil) {
        name = @"";
    } else {
        self.name = name;
    }
}
-(void)setAddress:(NSString *)address {
    self.address = address;
}


@end

//
//  DataManager.h
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Item;

@interface DataManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, strong) NSMutableArray *shoppingLists;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *address;

- (void)addToShoppingList:(Item *)item;

@end

//
//  DataManager.h
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

// Mastercard
#import "SIMProductViewController.h"
#import <Simplify/SIMChargeCardViewController.h>
#import <Simplify/SIMButton.h>
#import <Simplify/UIImage+Simplify.h>
#import <Simplify/UIColor+Simplify.h>
#import <Simplify/SIMResponseViewController.h>

@class Item;

@interface DataManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, strong) NSMutableArray *shoppingLists;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) SIMCreditCardToken *token;

- (void)addToShoppingList:(Item *)item;

@end

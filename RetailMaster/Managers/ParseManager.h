//
//  ParseManager.h
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Order;

@interface ParseManager : NSObject

+ (instancetype)sharedManager;

- (void)updateItem;

- (void)fetchItemsWithCatagory:(NSString *)catagory Limit:(NSInteger)limit Skip:(NSInteger)skip Completion:(void (^)(BOOL success, NSArray *items))completion;

- (void)fetchOrdersFromUserID:(NSString *)userid Limit:(NSInteger)limit Skip:(NSInteger)skip Completion:(void (^)(BOOL success, NSArray *orders))completion;
- (void)fetchItemsWithBarcode:(NSString *)barcode Completion:(void (^)(BOOL success, NSArray *items))completion;

- (NSString *)randomStringWithLength:(int)len;
- (NSString *)parseOrderToString:(Order *)order;

@end

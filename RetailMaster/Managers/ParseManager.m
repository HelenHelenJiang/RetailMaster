//
//  ParseManager.m
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "ParseManager.h"
#import "Item.h"
#import "Order.h"

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

- (void)fetchItemsWithCatagory:(NSString *)catagory Limit:(NSInteger)limit Skip:(NSInteger)skip Completion:(void (^)(BOOL success, NSArray *items))completion
{
    PFQuery *query = [PFQuery queryWithClassName:[Item parseClassName]];
//    [query orderByDescending:@"termId"];
    [query whereKey:@"catagory" equalTo:catagory];
    query.limit = limit;
    query.skip = skip;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %lu items", (unsigned long)objects.count);
            
            [objects enumerateObjectsUsingBlock:^(Item *item, NSUInteger index, BOOL *stop){
                if (!item.orderCount)
                    item.orderCount = 1;
            }];
            
            if (completion)
                completion(YES, objects);
            
        } else {
            NSLog(@"Error In Fetch items: %@ %@", error, [error userInfo]);
            if (completion)
                completion(NO, nil);
        }
    }];
}

- (void)fetchOrdersFromUserID:(NSString *)userid Limit:(NSInteger)limit Skip:(NSInteger)skip Completion:(void (^)(BOOL success, NSArray *orders))completion
{
    PFQuery *query = [PFQuery queryWithClassName:[Order parseClassName]];
    [query orderByDescending:@"createdAt"];
//    [query whereKey:@"catagory" equalTo:catagory];
//    query.limit = limit;
//    query.skip = skip;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %lu orders", (unsigned long)objects.count);
            if (completion)
                completion(YES, objects);
            
        } else {
            NSLog(@"Error In Fetch items: %@ %@", error, [error userInfo]);
            if (completion)
                completion(NO, nil);
        }
    }];
}

- (void)fetchItemsWithBarcode:(NSString *)barcode Completion:(void (^)(BOOL success, NSArray *items))completion
{
    PFQuery *query = [PFQuery queryWithClassName:[Item parseClassName]];
    //    [query orderByDescending:@"termId"];
    [query whereKey:@"barcode" equalTo:barcode];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %lu items", (unsigned long)objects.count);
            
            [objects enumerateObjectsUsingBlock:^(Item *item, NSUInteger index, BOOL *stop){
                if (!item.orderCount)
                    item.orderCount = 1;
            }];
            
            if (objects.count == 0)
                completion(NO, nil);
            if (completion)
                completion(YES, objects);
            
        } else {
            NSLog(@"Error In Fetch items: %@ %@", error, [error userInfo]);
            if (completion)
                completion(NO, nil);
        }
    }];
}

- (NSString *)parseOrderToString:(Order *)order
{
    NSMutableArray *array = [NSMutableArray array];
    
    [order.orderedObjects enumerateObjectsUsingBlock:^(Item *item, NSUInteger index, BOOL *stop){
        [array addObject:[NSString stringWithFormat:@"%@ : %i", item.name, item.orderCount]];
    }];
    
    return [array componentsJoinedByString:@", "];
}

NSString *letters = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

- (NSString *)randomStringWithLength:(int)len
{
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length]) % [letters length]]];
    }
    
    return randomString;
}

@end

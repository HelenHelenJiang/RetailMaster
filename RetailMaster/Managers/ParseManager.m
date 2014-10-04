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
            if (completion)
                completion(YES, objects);
            
        } else {
            NSLog(@"Error In Fetch items: %@ %@", error, [error userInfo]);
            if (completion)
                completion(NO, nil);
        }
    }];
}

@end

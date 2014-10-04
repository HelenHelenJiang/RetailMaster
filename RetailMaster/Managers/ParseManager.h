//
//  ParseManager.h
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseManager : NSObject

+ (instancetype)sharedManager;

- (void)updateItem;

- (void)fetchItemsWithCatagory:(NSString *)catagory Limit:(NSInteger)limit Skip:(NSInteger)skip Completion:(void (^)(BOOL success, NSArray *items))completion;

@end

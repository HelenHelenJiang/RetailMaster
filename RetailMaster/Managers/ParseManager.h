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

@end

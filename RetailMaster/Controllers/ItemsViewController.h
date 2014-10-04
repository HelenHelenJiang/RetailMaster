//
//  ItemsViewController.h
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSString *catName;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSMutableArray *items;

@end

//
//  OrderConformationViewController.h
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderConformationViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *tableViewBottomView;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic)  NSMutableArray *orderedItems;

@end

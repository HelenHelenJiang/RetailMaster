//
//  HistoryViewController.h
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *orders;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end

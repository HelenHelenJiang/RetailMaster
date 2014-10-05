//
//  LocationViewController.h
//  RetailMaster
//
//  Created by Jack on 2014-10-04.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationViewController : UIViewController <UITableViewDataSource,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *locationTabelView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;

@end

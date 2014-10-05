//
//  SettingViewController.h
//  RetailMaster
//
//  Created by Helen Jiang on 2014-10-04.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController<UITabBarControllerDelegate,UITableViewDataSource>{
    IBOutlet UITableView *SettingTableView;
}


@property (nonatomic,retain) UITableView *SettingTableView;


@end

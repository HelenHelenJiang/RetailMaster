//
//  DetailViewController.h
//  RetailMaster
//
//  Created by Helen Jiang on 2014-10-04.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    IBOutlet UITableView * DetailTableView;
}

@property (nonatomic,retain) UITableView *DetailTableView;

@end


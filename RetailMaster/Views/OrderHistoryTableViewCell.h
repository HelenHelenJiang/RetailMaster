//
//  OrderHistoryTableViewCell.h
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderHistoryTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderPickupLocationLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderPickupDateLabel;

@end

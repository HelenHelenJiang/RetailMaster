//
//  CheckoutItemTableViewCell.h
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckoutItemTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderQuantityLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderPriceLabel;

@end

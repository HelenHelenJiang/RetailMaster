//
//  ItemsViewTableViewCell.h
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ItemsViewTableViewCellDelegate <NSObject>

- (void)addToCartPressed:(NSIndexPath *)indexPath;

@end

@interface ItemsViewTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *itemImageView;
@property (strong, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *itemPriceLabel;
@property (strong, nonatomic) IBOutlet UIButton *itemBuyButton;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (strong, nonatomic) IBOutlet UIImageView *cartImageIcon;

@property (weak, nonatomic) id <ItemsViewTableViewCellDelegate> delegate;

@end

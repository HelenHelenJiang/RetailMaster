//
//  CheckoutPayButtonTableViewCell.m
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "CheckoutPayButtonTableViewCell.h"

@implementation CheckoutPayButtonTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.payButton.layer.cornerRadius = 5.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  ItemsViewTableViewCell.m
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "ItemsViewTableViewCell.h"

@implementation ItemsViewTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
//    self.backgroundView.layer.cornerRadius = 5.0f;
}

- (IBAction)addToCartBtnPressed:(id)sender
{
    self.cartImageIcon.frame = CGRectMake(242, 51, 40, 40);
    self.cartImageIcon.hidden = NO;
    
    [UIView animateWithDuration:0.5 animations:^(){
        CGRect frame = self.cartImageIcon.frame;
        frame.size.height = 22.0f;
        frame.size.width = 22.0f;
        frame.origin.x += 7.0f;
        frame.origin.y += 10.0f;
        self.cartImageIcon.frame = frame;
    }completion:^(BOOL finished){
        if (finished)
        {
            self.cartImageIcon.hidden = YES;
        }
    }];
    
    [self addToCartPressed:sender];
}

- (void)addToCartPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(addToCartPressed:)])
    {
        [self.delegate addToCartPressed:self.indexPath];
    }
}

@end

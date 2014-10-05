//
//  CategoryCollectionViewCell.m
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "CategoryCollectionViewCell.h"

@implementation CategoryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self) {
        // Initialization code
        self = [[[NSBundle mainBundle] loadNibNamed:@"CategoryCollectionViewCell" owner:self options:nil] objectAtIndex:0];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    self.catImageView.layer.cornerRadius = 70.0f;
    self.catImageView.clipsToBounds = YES;
}

@end

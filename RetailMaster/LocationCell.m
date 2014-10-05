//
//  LocationCell.m
//  RetailMaster
//
//  Created by Jack on 2014-10-04.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "LocationCell.h"

@implementation LocationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (IBAction)setLocation:(id)sender {
}

- (void)awakeFromNib
{
    // Initialization code
    self.setButton.frame = CGRectMake(254, 6, 46, 30);
    self.setButton.backgroundColor = [UIColor orangeColor];
    [self.setButton setTitle:@"Set" forState:UIControlStateNormal];
    [self.setButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.setButton.layer.cornerRadius = 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) assignImage {
    
    UIImage *image = [UIImage imageNamed:self.imageName];
    NSLog(@"LOL :%@",self.imageName);
    self.thumnil.image = image;
    
}

@end

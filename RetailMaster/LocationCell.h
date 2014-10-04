//
//  LocationCell.h
//  RetailMaster
//
//  Created by Jack on 2014-10-04.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumnil;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *setButton;


@end

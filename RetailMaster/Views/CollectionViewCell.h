//
//  CollectionViewCell.h
//  RetailMasterHack
//
//  Created by Helen Jiang on 2014-10-04.
//  Copyright (c) 2014 RetailMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ImageInCell;
@end

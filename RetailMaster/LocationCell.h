//
//  LocationCell.h
//  RetailMaster
//
//  Created by Jack on 2014-10-04.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LocationCellDelegate <NSObject>

- (void)setLocationPressed:(NSIndexPath *)indexPath;

@end

@interface LocationCell : UITableViewCell<LocationCellDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *thumnil;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *setButton;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (weak, nonatomic) id <LocationCellDelegate> delegate;

-(void) assignImage;
@end

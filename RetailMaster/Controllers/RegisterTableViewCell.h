//
//  RegisterTableViewCell.h
//  RetailMaster
//
//  Created by Jack on 2014-10-04.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegisterTableViewCell;

@protocol RegisterTableViewCellDelegate <NSObject>

- (void)didSelectedCell:(RegisterTableViewCell *)cell;

@end

@interface RegisterTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSString *placeHolder;

@property (weak, nonatomic) id <RegisterTableViewCellDelegate> delegate;

- (void)setIcon;

@end

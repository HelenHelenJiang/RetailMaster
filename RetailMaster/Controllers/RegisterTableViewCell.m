//
//  RegisterTableViewCell.m
//  RetailMaster
//
//  Created by Jack on 2014-10-04.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "RegisterTableViewCell.h"
#import "DataManager.h"

@implementation RegisterTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.inputTextField.placeholder = self.placeHolder;
        
    }
    
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    self.inputTextField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(didSelectedCell:)])
    {
        [self.delegate didSelectedCell:self];
    }
    
    return true;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 4)
    {
        [DataManager sharedManager].cardNumber = [textField.text stringByReplacingCharactersInRange:range withString:string];
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [[defaults objectForKey:@"customerInfo"] mutableCopy];
    [array replaceObjectAtIndex:self.indexPath.row withObject:textField.text];
    [defaults setObject:array forKey:@"customerInfo"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [[defaults objectForKey:@"customerInfo"] mutableCopy];
    [array replaceObjectAtIndex:self.indexPath.row withObject:textField.text];
    [defaults setObject:array forKey:@"customerInfo"];
    
    if (textField.tag == 4)
    {
        [DataManager sharedManager].cardNumber = textField.text;
    }
    
    [textField resignFirstResponder];
    return NO;
}

-(void) setIcon {
    
    int index = self.indexPath.row;
    
    NSString *imageName = nil;
    
    if (index == 0) {
        imageName = @"pencil";
    } else if (index == 1) {
        imageName = @"address";
    } else if (index == 2) {
        imageName = @"phone";
    } else if (index == 3) {
        imageName = @"email";
    } else if (index == 4) {
        imageName = @"mastercard";
    }
    
    UIImage *image = [UIImage imageNamed:imageName];
    self.iconImageView.image = image;
    
    self.inputTextField.placeholder = self.placeHolder;
}


@end

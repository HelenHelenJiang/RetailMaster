//
//  RegisterTableViewCell.m
//  RetailMaster
//
//  Created by Jack on 2014-10-04.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "RegisterTableViewCell.h"

@implementation RegisterTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
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


- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:textField.text forKey:self.catLabel.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

@end

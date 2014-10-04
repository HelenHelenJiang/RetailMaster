//
//  ItemDetailView.h
//  RetailMaster
//
//  Created by Helen Jiang on 2014-10-04.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemDetailView : UIView
@property (weak, nonatomic) IBOutlet UILabel *ItemName;

@property (weak, nonatomic) IBOutlet UILabel *Price;

@property (weak, nonatomic) IBOutlet UIButton *AddToCart;

@property (weak, nonatomic) IBOutlet UILabel *NutritionFact;
@property (weak, nonatomic) IBOutlet UILabel *Calories;
@property (weak, nonatomic) IBOutlet UILabel *Protein;
@property (weak, nonatomic) IBOutlet UILabel *Fat;
@property (weak, nonatomic) IBOutlet UILabel *Sodium;
@property (weak, nonatomic) IBOutlet UILabel *VitaminA;
@property (weak, nonatomic) IBOutlet UILabel *Cholesterol;
@property (weak, nonatomic) IBOutlet UILabel *VitaminB;
@property (weak, nonatomic) IBOutlet UILabel *VitaminC;
@property (weak, nonatomic) IBOutlet UILabel *VitaminD;

@end

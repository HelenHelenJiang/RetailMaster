//
//  ItemViewController.h
//  RetailMasterHack
//
//  Created by Helen Jiang on 2014-10-04.
//  Copyright (c) 2014 RetailMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemViewController : UICollectionViewController<UICollectionViewDelegate, UICollectionViewDelegate>

@property (weak, nonatomic)NSString* catName ;
@property (strong,nonatomic) NSMutableArray *NameLabels;
@property (strong,nonatomic) NSMutableArray *PriceLabels;
@property (strong,nonatomic) NSMutableArray *ImageURLs;

@end

//
//  CatagoriesViewController.h
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface CatagoriesViewController : UIViewController < ZBarReaderDelegate >
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

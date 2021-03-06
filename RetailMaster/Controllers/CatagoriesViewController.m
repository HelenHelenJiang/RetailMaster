//
//  CatagoriesViewController.m
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "CatagoriesViewController.h"
#import "CategoryCollectionViewCell.h"
#import "ItemsViewController.h"
#import "MBProgressHUD.h"
#import "ParseManager.h"
#import "Item.h"
#import "DetailsViewController.h"

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface CatagoriesViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSMutableArray *CategoryNames;
    NSMutableArray *CategoryImages;
}


@end

@implementation CatagoriesViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Catagory";
    
    //    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yourimage.png"]];
    //    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan.png"]]];
    //    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Scan" style:UIButtonTypeSystem target:self action:@selector(scanPressed:)];
    //    self.navigationItem.rightBarButtonItem = item;
    
    UIButton *optionsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [optionsBtn setFrame:CGRectMake(0, 0, 30, 30)];
    [optionsBtn addTarget:self action:@selector(scanBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [optionsBtn setBackgroundImage:[UIImage imageNamed:@"scan.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *optionsBtnItem = [[UIBarButtonItem alloc] initWithCustomView:optionsBtn];
    
    [self.navigationItem setRightBarButtonItem:optionsBtnItem];
    
    CategoryNames = [[[NSArray alloc] initWithObjects:@"Bakery",@"Dairy",@"FastFood",@"Fruit",@"Kitchen",@"RawMeat",@"SeaFood",@"Vegetable", nil] mutableCopy];
    CategoryImages = [[[NSArray alloc] initWithObjects:@"bakery.jpg",@"diary.jpg",@"frozen.jpg",@"fruit.jpg",@"kitchen.jpg",@"rawMeat.jpg",@"seafood.jpg",@"vege.jpg", nil] mutableCopy];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.barTintColor = RGB(238, 220, 137);
    [self.navigationController.navigationBar setTintColor:RGB(194, 121, 63)];
    [self initCollectionView];
}

- (void)initCollectionView
{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    [flowlayout setItemSize:CGSizeMake(140, 140)];
    //    [flowlayout setHeaderReferenceSize:CGSizeMake(320, 210)];
    
    [self.collectionView setCollectionViewLayout:flowlayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.886 green:0.886 blue:0.886 alpha:1];
    [self.collectionView registerClass:[CategoryCollectionViewCell class] forCellWithReuseIdentifier:@"CategoryCollectionViewCell"];
    //    UINib *headerNib = [UINib nibWithNibName:@"ProfileCollectionHeader" bundle:nil];
    //    [self.collectionView registerNib:headerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
//    UINib *headerNib = [UINib nibWithNibName:@"UploadingSnapHeader" bundle:nil];
//    [self.collectionView registerNib:headerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UploadingSnapHeader"];
//    [self.view addSubview:self.collectionView];
    [self.collectionView reloadData];
}


#pragma mark collectionView delegates
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return CategoryNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *kIdentifier = @"CategoryCollectionViewCell";
    
    CategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIdentifier forIndexPath:indexPath];
//
//    kFoodSnap *snap = self.snapsData[indexPath.row];
//    
//    cell.foodSnapCellMainImageView.image = snap.kFoodSnapImage;
//    [cell.foodSnapCellUserImageView sd_setImageWithURL:[NSURL URLWithString:snap.kFoodSnapUserAvatarURL]];
//    cell.foodSnapCellUserNameLabel.text = snap.kFoodSnapUsername;
//    cell.foodSnapCellTimeLabel.text = [snap.kFoodSnapCreatedDate prettyDate];
//    cell.foodSnapPriceLabel.text = [NSString stringWithFormat:@"$%.2f", [snap.kFoodSnapPrice doubleValue]];
//    cell.cellSnap = snap;
//    [cell setCommentCountLabelWithText:[NSString stringWithFormat:@"%@ comments", snap.kFoodSnapCommentCount]];
//    if (snap.isLiked)
//    {
//        cell.actionButtonContainer.hidden = YES;
//        cell.percentageContainer.hidden = NO;
//        [cell setPercentageLabels];
//    }
//    else
//    {
//        cell.actionButtonContainer.hidden = NO;
//        cell.percentageContainer.hidden = YES;
//    }
//    cell.delegate = self;
    
//    cell.backgroundColor = [UIColor darkGrayColor];
    
    
    cell.catImageView.image = [UIImage imageNamed:CategoryImages[indexPath.row]];
    cell.catNameLabel.text = CategoryNames[indexPath.row];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 150.0f;
    
    return CGSizeMake(140.0f, height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.6f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.6f;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *reusableview = nil;
//    
//    if (kind == UICollectionElementKindSectionHeader)
//    {
////        UploadingSnapHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UploadingSnapHeader" forIndexPath:indexPath];
////        kFoodSnap *snap = [ParseUtil sharedUtil].uploadingSnap;
////        headerView.imageView.image = snap.kFoodSnapImage;
////        if (snap.isUploadingFailed)
////        {
////            headerView.retryButton.hidden = NO;
////            headerView.cancelButton.hidden = NO;
////            headerView.statusLabel.text = @"Failed";
////        }
////        else
////        {
////            headerView.retryButton.hidden = YES;
////            headerView.cancelButton.hidden = YES;
////            headerView.statusLabel.text = @"Uploading";
////        }
////        currentUploadingHeaderView = headerView;
////        reusableview = currentUploadingHeaderView;
//    }
//    
//    return reusableview;
//}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 15, 0, 15);
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(self.collectionView.bounds.size.width, 44);
//    
////    if ([ParseUtil sharedUtil].uploadingSnap && section == 0)
////    {
////        return CGSizeMake(self.collectionView.bounds.size.width, 44);
////    }
////    else
////    {
////        return CGSizeMake(0, 0);
////    }
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    kFoodSnap *item = self.snapsData[indexPath.row];
//    
//    [SSPhotoViewer showPhotoViewerWithSnap:item To:[UIUtil getMainDrawerController].view];
//    
//    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    ItemsViewController *itemController = [[ItemsViewController alloc] init];
    itemController.catName = [CategoryNames objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:itemController animated:YES];
}

#pragma mark - Scan
- (void)scanBtnPressed:(id)sender
{
    // ADD: present a barcode reader that scans from the camera feed
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    reader.readerView.torchMode = 0;
    
    ZBarImageScanner *scanner = reader.scanner;
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    // present and release the controller
    [self presentViewController:reader animated:YES completion:nil];
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[ParseManager sharedManager] fetchItemsWithBarcode:symbol.data Completion:^(BOOL success, NSArray *objects){
        if (success)
        {
            Item *item = objects[0];
            DetailsViewController *detailVC = [[DetailsViewController alloc] init];
            detailVC.myObject = item;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cannot find that item"
                                                            message:@"Please try again"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
    NSLog(@"%@", symbol.data);
//    // EXAMPLE: do something useful with the barcode data
//    resultText.text = symbol.data;
//    
//    // EXAMPLE: do something useful with the barcode image
//    resultImage.image =
//    [info objectForKey: UIImagePickerControllerOriginalImage];
    
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissViewControllerAnimated:YES completion:nil];
}


@end

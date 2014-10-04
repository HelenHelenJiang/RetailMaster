//
//  CatagoriesViewController.m
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "CatagoriesViewController.h"
#import "CategoryCollectionViewCell.h"

@interface CatagoriesViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSArray *CategoryNames;
    NSArray *CategoryImages;
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
    
    CategoryNames = [[NSArray alloc] initWithObjects:@"Bakery",@"Diary",@"Frozen",@"Fruit",@"Kitchen",@"Raw Meat",@"Sea Food",@"Vegetable", nil];
    CategoryImages = [[NSArray alloc] initWithObjects:@"bakery.jpg",@"diary.jpg",@"frozen.jpg",@"fruit.jpg",@"kitchen.jpg",@"rawMeat.jpg",@"seafood.jpg",@"vege.jpg", nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)initCollectionView
{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    [flowlayout setItemSize:CGSizeMake(self.collectionView.bounds.size.width, 500)];
    //    [flowlayout setHeaderReferenceSize:CGSizeMake(320, 210)];
    
    [self.collectionView setCollectionViewLayout:flowlayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[CategoryCollectionViewCell class] forCellWithReuseIdentifier:@"CategoryCollectionViewCell"];
    //    UINib *headerNib = [UINib nibWithNibName:@"ProfileCollectionHeader" bundle:nil];
    //    [self.collectionView registerNib:headerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
//    UINib *headerNib = [UINib nibWithNibName:@"UploadingSnapHeader" bundle:nil];
//    [self.collectionView registerNib:headerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UploadingSnapHeader"];
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
    
    cell.catImageView.image = [UIImage imageNamed:CategoryImages[indexPath.row]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 456.0f;
    
    return CGSizeMake(320.0f, height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.6f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.6f;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
//        UploadingSnapHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UploadingSnapHeader" forIndexPath:indexPath];
//        kFoodSnap *snap = [ParseUtil sharedUtil].uploadingSnap;
//        headerView.imageView.image = snap.kFoodSnapImage;
//        if (snap.isUploadingFailed)
//        {
//            headerView.retryButton.hidden = NO;
//            headerView.cancelButton.hidden = NO;
//            headerView.statusLabel.text = @"Failed";
//        }
//        else
//        {
//            headerView.retryButton.hidden = YES;
//            headerView.cancelButton.hidden = YES;
//            headerView.statusLabel.text = @"Uploading";
//        }
//        currentUploadingHeaderView = headerView;
//        reusableview = currentUploadingHeaderView;
    }
    
    return reusableview;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.collectionView.bounds.size.width, 44);
    
//    if ([ParseUtil sharedUtil].uploadingSnap && section == 0)
//    {
//        return CGSizeMake(self.collectionView.bounds.size.width, 44);
//    }
//    else
//    {
//        return CGSizeMake(0, 0);
//    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    kFoodSnap *item = self.snapsData[indexPath.row];
//    
//    [SSPhotoViewer showPhotoViewerWithSnap:item To:[UIUtil getMainDrawerController].view];
//    
//    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

@end

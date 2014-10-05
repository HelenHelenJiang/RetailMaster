//
//  WelcomeViewController.m
//  RetailMaster
//
//  Created by Jack on 2014-10-04.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "WelcomeViewController.h"
#import "RegisterViewController.h"
#import "ParseManager.h"
#import "Item.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface WelcomeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation WelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    // Do any additional setup after loading the view.
    
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 320, 20)];
    // [self.view addSubview:welcomeLabel];
    welcomeLabel.textColor  = [UIColor orangeColor];
    welcomeLabel.backgroundColor = [UIColor whiteColor];
    
    [self createCollectionView];
    
    self.dealsData = [NSMutableArray array];
    
    [[ParseManager sharedManager] fetchItemsWithCatagory:@"Bakery" Limit:5 Skip:0 Completion:^(BOOL success, NSArray *objects){
        self.dealsData = [objects mutableCopy];
        [self.collectionView reloadData];
    }];
    
    NSUserDefaults *defualts = [NSUserDefaults standardUserDefaults];
    BOOL isRegistered = [defualts objectForKey:@"isRegistered"];
    
    if (isRegistered) {
        
        NSArray *array  = [defualts objectForKey:@"customerInfo"];
        NSString *nameString = [array objectAtIndex:0];
        welcomeLabel.text = [NSString stringWithFormat:@"Hi %@!",nameString];
        
    } else {
        
        // welcomeLabel.text = @"Welcome to Retail Master!";
        
    }
    
    if (isRegistered){
        
        [self.button setTitle:@"Edit" forState:UIControlStateNormal];
        
    } else {
        
        [self.button setTitle:@"Register" forState:UIControlStateNormal];
    }
    
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.button.backgroundColor= [UIColor orangeColor];
    self.button.layer.cornerRadius = 5.0f;
    [self.view addSubview:self.button];
    
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, 80, 30)];
    locationLabel.textColor = [UIColor orangeColor];
    locationLabel.text = @"Location:";
    //[self.view addSubview:locationLabel];
    
    self.setLocationButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.setLocationButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.setLocationButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:self.setLocationButton];
    
    if (isRegistered) {
        [self.setLocationButton setTitle:@"LOL" forState:UIControlStateNormal];
    } else {
        [self.setLocationButton setTitle:@"pick a retail store location" forState:UIControlStateNormal];
    }
    
}

- (void)createCollectionView
{
    if (self.collectionView == nil)
    {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [flowLayout setItemSize:CGSizeMake(140, 180)];
        flowLayout.minimumLineSpacing = 5.0f;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 10, 300, 180) collectionViewLayout:flowLayout];
        
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.backgroundColor = [UIColor clearColor];
        [self.dealsContainer addSubview:self.collectionView];
        
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
        [self.collectionView reloadData];
    }
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return self.dealsData.count;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    for (id subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    
    Item *item = self.dealsData[indexPath.row];
    
    UILabel *filterLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 140, 120, 20)];
    filterLabel.text = item.name;
    filterLabel.textColor = [UIColor blackColor];
    filterLabel.font = [UIFont fontWithName:@"Avenir" size:10.0f];
    filterLabel.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:filterLabel];
    
    UIImageView *filteredImageView = [[UIImageView alloc] init];
    [filteredImageView sd_setImageWithURL:[NSURL URLWithString:item.imageURL]];
    filteredImageView.frame = CGRectMake(5, 0, 120, 140);
    filteredImageView.clipsToBounds = YES;
    [cell.contentView addSubview:filteredImageView];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UIImage *item = self.filteredImages[indexPath.row];
//    self.uploadImageView.image = item;
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     
     
     
     
     
 }

@end

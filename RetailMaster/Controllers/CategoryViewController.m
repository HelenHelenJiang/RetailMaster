//
//  CategoryViewController.m
//  RetailMaster
//
//  Created by Helen Jiang on 2014-10-04.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "CategoryViewController.h"
#import "ItemViewController.h"
#import "CategoryViewCell.h"

@interface CategoryViewController ()

@end



@implementation CategoryViewController



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
    CategoryNames = [[NSArray alloc] initWithObjects:@"Bakery",@"Diary",@"Frozen",@"Fruit",@"Kitchen",@"Raw Meat",@"Sea Food",nil];
    CategoryImages = [[NSArray alloc] initWithObjects:@"bakery.jpg",@"frozen.jpg",@"kitchen.jpg",@"rawMeat.jpg",@"fruit.jpg",@"seafood.jpg",nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return CategoryNames.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CategoryCell = @"CategoryID";
    CategoryViewCell *categoryCell = (CategoryViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryID" forIndexPath:indexPath];
    categoryCell.CategoryImage.image = [UIImage imageNamed:[CategoryImages objectAtIndex:indexPath.item]];
    categoryCell.CategoryNameLabel.text = [CategoryNames objectAtIndex:indexPath.item];

    return categoryCell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"CategoryToItem"]) {
        NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        ItemViewController *itemController = [segue destinationViewController];
//  itemController.catName ;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    datasetCell.backgroundColor = [UIColor blueColor]; // highlight selection
    [self performSegueWithIdentifier:@"CategoryToItem" sender:nil];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    datasetCell.backgroundColor = [UIColor redColor]; // Default color
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  BNRFirstViewController.m
//  Collections
//
//  Created by Stephen Christopher on 8/17/13.
//  Copyright (c) 2013 Big Nerd Ranch. All rights reserved.
//

#import "BNRLargeTileCollectionVC.h"
#import "BNRPrototypeCell.h"

@interface BNRLargeTileCollectionVC ()

@end

@implementation BNRLargeTileCollectionVC

- (void)viewDidLoad
{
    UINavigationItem *navItem = self.navigationController.navigationItem;
    [navItem setTitle:@"Large Tiles"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 10;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BNRPrototypeCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"largeTileCell"
                                                                            forIndexPath:indexPath];
    NSString *numberString = [NSString stringWithFormat:@"Num %i", indexPath.row];
    [cell.mainLabel setText:numberString];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"detailsFooter" forIndexPath:indexPath];
    return reusableView;
}

@end

//
//  BNRSecondViewController.m
//  Collections
//
//  Created by Stephen Christopher on 8/17/13.
//  Copyright (c) 2013 Big Nerd Ranch. All rights reserved.
//

#import "BNRSmallTileCollectionVC.h"
#import "BNRPrototypeCell.h"

@interface BNRSmallTileCollectionVC ()

@end

@implementation BNRSmallTileCollectionVC

- (void)viewDidLoad
{
    UINavigationItem *navItem = self.navigationController.navigationItem;
    [navItem setTitle:@"Small Tiles"];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BNRPrototypeCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"prototypeCell"
                                                                                forIndexPath:indexPath];
    NSString *numberText = [NSString stringWithFormat:@"#%i", indexPath.row];
    [cell.mainLabel setText:numberText];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual: @"collectionSegue"]) {
        UICollectionViewController *toVC = (UICollectionViewController *)segue.destinationViewController;
        [toVC setUseLayoutToLayoutNavigationTransitions:YES];

        UICollectionViewController *fromVC = (UICollectionViewController *)segue.sourceViewController;
        [fromVC.collectionView setDelegate:fromVC];
        [fromVC.collectionView setDataSource:fromVC];
    }
}

@end

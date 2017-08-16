//
//  MoviesSectionsCell.m
//  Movies
//
//  Created by Asatur Galstyan on 8/16/17.
//  Copyright © 2017 RealizeIt, LLC. All rights reserved.
//

#import "MoviesSectionsCell.h"
#import "MovieCell.h"
#import "APIManager.h"

#define kCellPadding 20

@interface MoviesSectionsCell() <UICollectionViewDataSource, UICollectionViewDelegate> {

    NSArray *movies;
}

@end

@implementation MoviesSectionsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    movies = nil;
    self.sectionTitleLabel.text = nil;
    
    self.activityIndicatorView.hidden = NO;
    [self.activityIndicatorView startAnimating];
}

- (void)setSectionType:(SectionType)sectionType {
    
    _sectionType = sectionType;
    
    switch (sectionType) {
        case kSectionTypeNewInTheatres: {
        
            [APIManager fetchNewInTheatresMoviesWithCompletion:^(id responseData, NSError *error) {
                [self.activityIndicatorView stopAnimating];
                if (!error && responseData) {
                    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];

                    movies = [Movie moviesFromDictionaries:responseDict[@"results"]];
                    [self.moviesCollectionView reloadData];
                }
                
            }];
            break;
        }
        case kSectionTypePopular: {
            
            [APIManager fetchPopularMoviesWithCompletion:^(id responseData, NSError *error) {
                [self.activityIndicatorView stopAnimating];
                if (!error && responseData) {
                    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
                    movies = [Movie moviesFromDictionaries:responseDict[@"results"]];
                    [self.moviesCollectionView reloadData];
                }
                
            }];
            break;
        }
        case kSectionTypeTopRated: {
            
            [APIManager fetchTopRatedMoviesWithCompletion:^(id responseData, NSError *error) {
                [self.activityIndicatorView stopAnimating];
                if (!error && responseData) {
                    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
                    movies = [Movie moviesFromDictionaries:responseDict[@"results"]];
                    
                    // filter by vote count
                    movies = [movies filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"voteCount >= %@", @500]];
                    
                    [self.moviesCollectionView reloadData];
                }
                
            }];
            break;
        }
        default:
            break;
    }
}

#pragma mark UICollectionView methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return movies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCell" forIndexPath:indexPath];
    cell.movie = movies[indexPath.row];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float widht = [[UIScreen mainScreen] bounds].size.width;
    CGSize cellSize = CGSizeMake(widht - 2 * kCellPadding , 190);
    
    return cellSize;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    float widthP = 0.65f;
    
    CGFloat pageWidth = [[UIScreen mainScreen] bounds].size.width - 2 * kCellPadding;
    
    float currentOffset = scrollView.contentOffset.x;
    float targetOffset = targetContentOffset->x;
    
    float newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth;
    
    if (targetOffset > currentOffset) {
        widthP = 0.85f;
    } else {
        widthP = 0.15f;
    }
    
    if (newTargetOffset < 0) {
        newTargetOffset = 0;
    } else if (newTargetOffset > scrollView.contentSize.width) {
        newTargetOffset = scrollView.contentSize.width;
    }
    
    targetContentOffset->x = currentOffset;
    [scrollView setContentOffset:CGPointMake(newTargetOffset, 0) animated:YES];
    
    NSInteger page = (scrollView.contentOffset.x + (widthP * pageWidth)) / pageWidth;
    
    [self.moviesCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:page inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
}

@end

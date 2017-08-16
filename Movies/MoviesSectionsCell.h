//
//  MoviesSectionsCell.h
//  Movies
//
//  Created by Asatur Galstyan on 8/16/17.
//  Copyright © 2017 RealizeIt, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    kSectionTypeNewInTheatres = 1,
    kSectionTypePopular = 2,
    kSectionTypeTopRated = 3,
} SectionType;


@interface MoviesSectionsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *sectionTitleLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *moviesCollectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic, assign) SectionType sectionType;

@end

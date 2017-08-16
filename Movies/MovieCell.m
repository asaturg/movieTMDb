//
//  MovieCell.m
//  Movies
//
//  Created by Asatur Galstyan on 8/16/17.
//  Copyright © 2017 RealizeIt, LLC. All rights reserved.
//

#import "MovieCell.h"
#import "APIManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIView+WebCache.h>

@implementation MovieCell

- (void)prepareForReuse {
    [super prepareForReuse];
    self.titleLabel.text = nil;
    self.movieImage.image = nil;
}

- (void)setMovie:(Movie *)movie {
    _movie = movie;
    
    self.titleLabel.text = movie.title;
    
    [self.movieImage sd_setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.movieImage sd_setShowActivityIndicatorView:YES];
    [self.movieImage sd_setImageWithURL:[APIManager imageUrlForPath:movie.posterPath]];
}

@end

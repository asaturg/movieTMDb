//
//  APIManager.h
//  Movies
//
//  Created by Asatur Galstyan on 8/16/17.
//  Copyright © 2017 RealizeIt, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject

+ (void)fetchNewInTheatresMoviesWithCompletion:( void (^) (id responseData, NSError *error))handler;

+ (void)fetchPopularMoviesWithCompletion:( void (^) (id responseData, NSError *error))handler;

+ (void)fetchTopRatedMoviesWithCompletion:( void (^) (id responseData, NSError *error))handler;

+ (NSURL *)imageUrlForPath:(NSString *)imagePath;

@end

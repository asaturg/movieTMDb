//
//  Movie.h
//  Movies
//
//  Created by Asatur Galstyan on 8/16/17.
//  Copyright © 2017 RealizeIt, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic) NSString* title;
@property (nonatomic) NSInteger voteCount;
@property (nonatomic) NSString* posterPath;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

+ (NSArray*)moviesFromDictionaries:(NSArray*)moviesDictionaries;

@end

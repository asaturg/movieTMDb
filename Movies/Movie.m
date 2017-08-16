//
//  Movie.m
//  Movies
//
//  Created by Asatur Galstyan on 8/16/17.
//  Copyright © 2017 RealizeIt, LLC. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    
    if (self = [super init]) {
        
        if (dictionary[@"title"]) {
            self.title = dictionary[@"title"];
        }
        
        if (dictionary[@"poster_path"]) {
            self.posterPath = dictionary[@"poster_path"];
        }
        
        if (dictionary[@"vote_count"]) {
            self.voteCount = [dictionary[@"vote_count"] integerValue];
        }
        
    }
    
    return self;
}

+ (NSArray*)moviesFromDictionaries:(NSArray*)moviesDictionaries {
    
    NSMutableArray *movies = [NSMutableArray new];
    
    for (NSDictionary *movieDict in moviesDictionaries) {
        
        Movie *movie = [[Movie alloc] initWithDictionary:movieDict];
        [movies addObject:movie];
    }
    
    return movies;
}

@end

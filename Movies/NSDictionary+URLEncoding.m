//
//  NSDictionary+URLEncoding.m
//  Movies
//
//  Created by Asatur Galstyan on 8/16/17.
//  Copyright © 2017 RealizeIt, LLC. All rights reserved.
//

#import "NSDictionary+URLEncoding.h"

static NSString *toString(id object) {
    return [NSString stringWithFormat: @"%@", object];
}

static NSString *urlEncode(id object) {
    NSString *string = toString(object);
    
    NSString *escapedString = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSMutableCharacterSet characterSetWithCharactersInString:@"!*'();:&=+$/?%#[]\""]];
    
    return escapedString;
}

@implementation NSDictionary (URLEncoding)

-(NSString*) urlEncodedString {
    NSMutableArray *parts = [NSMutableArray array];
    for (id key in self) {
        id value = [self objectForKey: key];
        NSString *part = [NSString stringWithFormat: @"%@=%@", urlEncode(key), urlEncode(value)];
        [parts addObject: part];
    }
    return [parts componentsJoinedByString: @"&"];
}

@end

//
//  TMDBPromisedMovie.h
//  iTMDb
//
//  Created by Alessio Moiso on 14/01/13.
//  Copyright (c) 2013 Apoltix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMDBPromisedMovie : NSObject

@property NSString *title;
@property NSNumber *adult;
@property NSNumber *identifier;
@property NSString *originalTitle;
@property NSDate *releaseDate;
@property NSNumber *popularity;
@property NSString *backdrop;
@property NSString *poster;
@property NSNumber *rate;

+ (TMDBPromisedMovie*)promisedMovie;

@end

//
//  TMDBPromisedMovie.h
//  iTMDb
//
//  Created by Alessio Moiso on 14/01/13.
//  Copyright (c) 2013 MrAsterisco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMDBDelegate.h"
#import "TMDBImageDelegate.h"

@interface TMDBPromisedMovie : NSObject <TMDBImageDelegate>

@property NSString *title;
@property NSNumber *adult;
@property NSNumber *identifier;
@property NSString *originalTitle;
@property NSDate *releaseDate;
@property NSNumber *popularity;
@property NSString *backdrop;
@property NSString *poster;
@property NSImage *loadedPoster;
@property NSNumber *rate;
@property NSDictionary *rawData;
@property TMDBImage *loadingPoster;
@property TMDB *context;

+ (TMDBPromisedMovie*)promisedMovieFromDictionary:(NSDictionary*)movie withContext:(TMDB*)context;
- (id)initWithContentsOfDictionary:(NSDictionary*)movie fromContext:(TMDB*)context;

- (void)loadPoster;
- (TMDBMovie*)movie;

@end

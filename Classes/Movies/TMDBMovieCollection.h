//
//  TMDBMovieCollection.h
//  iTMDb
//
//  Created by Alessio Moiso on 13/01/13.
//  Copyright (c) 2013 Apoltix. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TMDBRequestDelegate.h"
#import "TMDBPromisedMovie.h"
#import "TMDBImage.h"

@class TMDB;

@interface TMDBMovieCollection : NSObject <TMDBRequestDelegate>

@property NSArray *results;
@property TMDBRequest *request;
@property TMDB *context;
@property NSArray *rawResults;

+ (TMDBMovieCollection*)collectionWithName:(NSString*)name andContext:(TMDB*)context;

- (id)initWithName:(NSString*)name andContext:(TMDB*)aContext;

@end

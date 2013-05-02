//
//  TMDBPromisedMovie.m
//  iTMDb
//
//  Created by Alessio Moiso on 14/01/13.
//  Copyright (c) 2013 MrAsterisco. All rights reserved.
//

#import "TMDBPromisedMovie.h"
#import "TMDBMovieCollection.h"
#import "TMDBImage.h"

@implementation TMDBPromisedMovie

+ (TMDBPromisedMovie*)promisedMovieFromDictionary:(NSDictionary*)movie withContext:(TMDB*)context {
    return [[TMDBPromisedMovie alloc] initWithContentsOfDictionary:movie fromContext:context];
}

- (id)initWithContentsOfDictionary:(NSDictionary*)movie fromContext:(TMDB*)context {
    if (self = [super init]) {
//        _collection = aCollection;
        _context = context;
        _rawData = movie;
        
        _adult = [NSNumber numberWithBool:(BOOL)[movie valueForKey:@"adult"]];
        _identifier = [movie valueForKey:@"id"];
        
        if (![[movie valueForKey:@"backdrop_path"] isMemberOfClass:[NSNull class]]) {
            _backdrop = [movie valueForKey:@"backdrop_path"];
        }
        if (![[movie valueForKey:@"backdrop_path"] isMemberOfClass:[NSNull class]]) {
            _poster = [movie valueForKey:@"poster_path"];
        }
        if (![[movie valueForKey:@"original_title"] isMemberOfClass:[NSNull class]]) {
            _originalTitle = [movie valueForKey:@"original_title"];
        }
        if (![[movie valueForKey:@"title"] isMemberOfClass:[NSNull class]]) {
            _title = [movie valueForKey:@"title"];
        }
        if (![[movie valueForKey:@"popularity"] isMemberOfClass:[NSNull class]]) {
            _popularity = [movie valueForKey:@"popularity"];
        }
        if (![[movie valueForKey:@"release_date"] isMemberOfClass:[NSNull class]]) {
            NSDateComponents *date = [[NSDateComponents alloc] init];
            NSArray *components = [[movie valueForKey:@"release_date"] componentsSeparatedByString:@"-"];
            [date setYear:[[components objectAtIndex:0] intValue]];
            [date setMonth:[[components objectAtIndex:1] intValue]];
            [date setDay:[[components objectAtIndex:2] intValue]];
            NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            _releaseDate = [cal dateFromComponents:date];
        }
        if (![[movie valueForKey:@"vote_average"] isMemberOfClass:[NSNull class]]) {
            _rate = [movie valueForKey:@"vote_average"];
        }
    }
    return self;
}

- (void)dealloc {
    _title = nil;
    _adult = nil;
    _identifier = nil;
    _originalTitle = nil;
    _releaseDate = nil;
    _popularity = nil;
    _backdrop = nil;
    _poster = nil;
    _loadedPoster = nil;
    _rate = nil;
    _rawData = nil;
    _loadingPoster = nil;
    _context = nil;
}

- (void)loadPoster {
    if (self.poster != nil) {
        [self performSelectorInBackground:@selector(loadPosterInBackgroundThread) withObject:nil];
    }
}

- (void)loadPosterInBackgroundThread {
    @autoreleasepool {
        self.loadingPoster = [[TMDBImage alloc] initWithAddress:[NSURL URLWithString:self.poster] context:self.context delegate:self andContextInfo:self];
    }
}

- (void)tmdbImage:(TMDBImage*)image didFinishLoading:(NSImage*)aImage inContext:(TMDB*)context {
    self.loadedPoster = aImage;
    _loadingPoster = nil;
}

- (TMDBMovie*)movie {
    return [self.context movieWithID:[[self identifier] intValue]];
}

@end

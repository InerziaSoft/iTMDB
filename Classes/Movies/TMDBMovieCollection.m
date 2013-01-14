//
//  TMDBMovieCollection.m
//  iTMDb
//
//  Created by Alessio Moiso on 13/01/13.
//  Copyright (c) 2013 Apoltix. All rights reserved.
//

#import "TMDBMovieCollection.h"

#import "TMDB.h"

@implementation TMDBMovieCollection

+ (TMDBMovieCollection*)collectionWithName:(NSString*)name andContext:(TMDB*)context {
    return [[TMDBMovieCollection alloc] initWithName:name andContext:context];
}

- (id)initWithName:(NSString*)aName andContext:(TMDB*)aContext {
    if ([self init]) {
        _results = [NSMutableArray array];
        NSString *aNameEscaped = [aName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:[API_URL_BASE stringByAppendingFormat:@"%.1d/search/movie?api_key=%@&language=%@&query=%@",
                                           API_VERSION, aContext.apiKey, aContext.language, aNameEscaped]];
        _context = aContext;
        _request = [TMDBRequest requestWithURL:url delegate:self];
    }
    return self;
}

#pragma mark -
#pragma mark TMDBRequestDelegate

- (void)request:(TMDBRequest *)request didFinishLoading:(NSError *)error {
    if (error)
	{
		//NSLog(@"iTMDb: TMDBMovie request failed: %@", [error description]);
		if (_context)
			[_context movieDidFailLoading:self error:error];
		return;
	}
    
    _rawResults = [[NSArray alloc] initWithArray:(NSArray *)[[request parsedData] valueForKey:@"results"] copyItems:YES];
    NSLog(@"%@", _rawResults);
    _results = [NSMutableArray arrayWithCapacity:[_rawResults count]];
    for (NSDictionary *movie in _rawResults) {
        TMDBPromisedMovie *proMovie = [TMDBPromisedMovie promisedMovie];
        
        [proMovie setAdult:[NSNumber numberWithBool:(BOOL)[movie valueForKey:@"adult"]]];
        [proMovie setIdentifier:[NSNumber numberWithInt:(int)[movie valueForKey:@"id"]]];
        
        if ([[movie valueForKey:@"backdrop_path"] isMemberOfClass:[NSString class]]) {
            [proMovie setBackdrop:[movie valueForKey:@"backdrop_path"]];
        }
        if ([[movie valueForKey:@"backdrop_path"] isMemberOfClass:[NSString class]]) {
            [proMovie setPoster:[movie valueForKey:@"poster_path"]];
        }
        if ([[movie valueForKey:@"original_title"] isMemberOfClass:[NSString class]]) {
            [proMovie setOriginalTitle:[movie valueForKey:@"original_title"]];
        }
        if ([[movie valueForKey:@"title"] isMemberOfClass:[NSString class]]) {
            [proMovie setTitle:[movie valueForKey:@"title"]];
        }
        if ([movie valueForKey:@"popularity"] != nil) {
            [proMovie setPopularity:[NSNumber numberWithFloat:[[movie valueForKey:@"popularity"] floatValue]]];
        }
        if ([movie valueForKey:@"release_date"] != nil) {
            NSDateComponents *date = [[NSDateComponents alloc] init];
            NSArray *components = [[movie valueForKey:@"release_date"] componentsSeparatedByString:@"-"];
            [date setYear:[[components objectAtIndex:0] intValue]];
            [date setMonth:[[components objectAtIndex:1] intValue]];
            [date setDay:[[components objectAtIndex:2] intValue]];
            NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            [proMovie setReleaseDate:[cal dateFromComponents:date]];
        }
        if ([movie valueForKey:@"vote_average"] != nil) {
            [proMovie setRate:[NSNumber numberWithInt:(int)[movie valueForKey:@"vote_average"]]];
        }
    }
}

@end

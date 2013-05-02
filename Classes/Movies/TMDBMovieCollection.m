//
//  TMDBMovieCollection.m
//  iTMDb
//
//  Created by Alessio Moiso on 13/01/13.
//  Copyright (c) 2013 MrAsterisco. All rights reserved.
//

#import "TMDBMovieCollection.h"

#import "TMDB.h"

@implementation TMDBMovieCollection

+ (TMDBMovieCollection*)collectionWithName:(NSString*)name andContext:(TMDB*)context {
    return [[TMDBMovieCollection alloc] initWithName:name andContext:context];
}

- (id)initWithName:(NSString*)aName andContext:(TMDB*)aContext {
    if (self = [super init]) {
        _name = aName;
        _results = [NSMutableArray array];
        NSString *aNameEscaped = [aName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:[API_URL_BASE stringByAppendingFormat:@"%.1d/search/movie?api_key=%@&language=%@&query=%@",
                                           API_VERSION, aContext.apiKey, aContext.language, aNameEscaped]];
        _context = aContext;
        _request = [TMDBRequest requestWithURL:url delegate:self];
    }
    return self;
}

- (void)dealloc {
    _contextInfo = nil;
    _context = nil;
    _results = nil;
    _rawResults = nil;
    _name = nil;
}

- (NSString*)description {
    return [NSString stringWithFormat:@"<%@: %@>", [self class], self.name];
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
    
    _request = nil;
    
    if ([_rawResults count] != 0) {
        _results = [NSMutableArray arrayWithCapacity:[_rawResults count]];
        for (NSDictionary *movie in _rawResults) {
            TMDBPromisedMovie *proMovie = [TMDBPromisedMovie promisedMovieFromDictionary:movie withContext:self.context];
            [_results addObject:proMovie];
        }
        
        if (_context)
            [_context movieDidFinishLoading:self];
    }
    else {
        if (_context)
			[_context movieDidFailLoading:self error:[NSError errorWithDomain:@"iTMDB" code:-4032 userInfo:nil]];
    }
}

@end

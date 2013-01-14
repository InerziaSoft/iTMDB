//
//  TMDBImage.m
//  iTMDb
//
//  Created by Alessio Moiso on 14/01/13.
//  Copyright (c) 2013 Apoltix. All rights reserved.
//

#import "TMDBImage.h"

@implementation TMDBImage

+ (TMDBImage*)imageWithAddress:(NSURL*)address imageType:(TMDBImageType)type context:(TMDB*)aContext {
    return [[TMDBImage alloc] initWithAddress:address imageType:type context:aContext];
}

- (id)initWithAddress:(NSURL*)address imageType:(TMDBImageType)type context:(TMDB*)aContext {
    if ([self init]) {
        _ready = NO;
        _address = address;
        _type = type;
        _context = aContext;
        
        if ([aContext configuration] == nil) {
            NSURL *url = [NSURL URLWithString:[API_URL_BASE stringByAppendingFormat:@"%.1d/configuration?api_key=%@",
                                               API_VERSION, aContext.apiKey]];
            _configurationRequest = [TMDBRequest requestWithURL:url delegate:self];
        }
        else {
            [self request:nil didFinishLoading:nil];
        }
    }
    return self;
}

#pragma mark -
#pragma mark TMDBRequestDelegate

- (void)request:(TMDBRequest *)request didFinishLoading:(NSError *)error {
    if (request != nil) {
        _context.configuration = [[request parsedData] valueForKey:@"images"];
    }
    
    NSImage *image = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@", [_context.configuration valueForKey:@"base_url"], @"original", _address]]];
    
    if (_delegate) {
        [_delegate tmdbImage:self didFinishLoading:image inContext:_context];
    }
}

@end

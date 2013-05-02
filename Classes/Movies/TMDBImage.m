//
//  TMDBImage.m
//  iTMDb
//
//  Created by Alessio Moiso on 14/01/13.
//  Copyright (c) 2013 MrAsterisco. All rights reserved.
//

#import "TMDBImage.h"

@implementation TMDBImage

+ (TMDBImage*)imageWithDictionary:(NSDictionary*)image context:(TMDB*)aContext delegate:(id<TMDBImageDelegate>)del andContextInfo:(id)contextInf {
    return [[TMDBImage alloc] initWithAddress:[image valueForKey:@"file_path"] context:aContext delegate:del andContextInfo:contextInf];
}

- (id)initWithAddress:(NSURL*)address context:(TMDB*)aContext delegate:(id<TMDBImageDelegate>)del andContextInfo:(id)contextInf {
    if (self = [super init]) {
        _ready = NO;
        _address = address;
        _context = aContext;
        _delegate = del;
        _contextInfo = contextInf;
        
        NSURL *url = [NSURL URLWithString:[API_URL_BASE stringByAppendingFormat:@"%.1d/configuration?api_key=%@",
                                           API_VERSION, aContext.apiKey]];
        _configurationRequest = [TMDBRequest requestWithURL:url delegate:self];
    }
    return self;
}

- (void)dealloc {
    _address = nil;
    _configurationRequest = nil;
    _context = nil;
    _delegate = nil;
    _contextInfo = nil;
}

#pragma mark -
#pragma mark TMDBRequestDelegate

- (void)request:(TMDBRequest *)request didFinishLoading:(NSError *)error {
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    if (request != nil) {
        _context.configuration = [[request parsedData] valueForKey:@"images"];
    }
    
    NSURL *finalURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", [_context.configuration valueForKey:@"base_url"], @"original", _address]];
    NSImage *image = [[NSImage alloc] initWithContentsOfURL:finalURL];
    
    _ready = YES;
    _configurationRequest = nil;
    
    if (_delegate) {
        [_delegate tmdbImage:self didFinishLoading:image inContext:_context];
    }
}

@end

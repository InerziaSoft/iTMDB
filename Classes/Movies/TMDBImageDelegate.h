//
//  TMDBImageDelegate.h
//  iTMDb
//
//  Created by Alessio Moiso on 14/01/13.
//  Copyright (c) 2013 MrAsterisco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TMDBImage;

@protocol TMDBImageDelegate <NSObject>

@required

- (void)tmdbImageInContext:(TMDB*)context didFinishLoading:(NSImage*)image;

@end

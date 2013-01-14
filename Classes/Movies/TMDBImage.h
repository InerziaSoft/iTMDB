//
//  TMDBImage.h
//  iTMDb
//
//  Created by Alessio Moiso on 14/01/13.
//  Copyright (c) 2013 Apoltix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMDB.h"
#import "TMDBImageDelegate.h"

typedef enum {
	TMDBImageTypePoster,
	TMDBImageTypeBackdrop
} TMDBImageType;

@interface TMDBImage : NSObject <TMDBRequestDelegate>

@property TMDBImageType type;
@property NSURL *address;
@property BOOL ready;
@property TMDB *context;
@property TMDBRequest *configurationRequest;
@property id<TMDBImageDelegate> delegate;

+ (TMDBImage*)imageWithAddress:(NSURL*)address imageType:(TMDBImageType)type context:(TMDB*)aContext;

- (id)initWithAddress:(NSURL*)address imageType:(TMDBImageType)type context:(TMDB*)aContext;

@end

//
//  TMDBImage.h
//  iTMDb
//
//  Created by Alessio Moiso on 14/01/13.
//  Copyright (c) 2013 MrAsterisco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMDB.h"
#import "TMDBImageDelegate.h"

typedef enum {
	TMDBImageTypePoster,
	TMDBImageTypeBackdrop
} TMDBImageType;

@interface TMDBImage : NSObject <TMDBRequestDelegate>

@property NSURL *address;
@property TMDB *context;
@property TMDBRequest *configurationRequest;
@property (unsafe_unretained) id<TMDBImageDelegate> delegate;
@property id contextInfo;

+ (TMDBImage*)imageWithDictionary:(NSDictionary*)image context:(TMDB*)aContext delegate:(id<TMDBImageDelegate>)del andContextInfo:(id)contextInf;

- (id)initWithAddress:(NSURL*)address context:(TMDB*)aContext delegate:(id<TMDBImageDelegate>)del andContextInfo:(id)contextInf;

@end

//
//  TMDBLanguage.h
//  iTMDb
//
//  Created by Alessio Moiso on 27/04/14.
//  Copyright (c) 2014 Apoltix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMDBLanguage : NSObject

@property NSString *isoCode;
@property NSString *name;

- (id)initWithLanguageName:(NSString*)name andISOCode:(NSString*)iso;
+ (instancetype)languageWithName:(NSString*)name andISOCode:(NSString*)iso;

@end

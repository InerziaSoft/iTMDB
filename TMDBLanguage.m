//
//  TMDBLanguage.m
//  iTMDb
//
//  Created by Alessio Moiso on 27/04/14.
//  Copyright (c) 2014 Apoltix. All rights reserved.
//

#import "TMDBLanguage.h"

@implementation TMDBLanguage

+ (instancetype)languageWithName:(NSString*)name andISOCode:(NSString*)iso {
    return [[self alloc] initWithLanguageName:name andISOCode:iso];
}

- (id)initWithLanguageName:(NSString*)name andISOCode:(NSString*)iso {
    if (self = [super init]) {
        _name = name;
        _isoCode = iso;
    }
    return self;
}

@end

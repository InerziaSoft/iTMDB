//
//  TMDBCompany.m
//  iTMDb
//
//  Created by Alessio Moiso on 27/04/14.
//  Copyright (c) 2014 Apoltix. All rights reserved.
//

#import "TMDBCompany.h"

@implementation TMDBCompany

+ (instancetype)companyWithName:(NSString*)name andIdentifier:(NSNumber*)identifier {
    return [[self alloc] initWithCompanyName:name andIdentifier:identifier];
}

- (id)initWithCompanyName:(NSString*)name andIdentifier:(NSNumber*)identifier {
    if (self = [super init]) {
        _name = name;
        _identifier = identifier;
    }
    return self;
}

@end

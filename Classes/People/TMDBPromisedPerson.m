//
//  TMDBPerson.m
//  iTMDb
//
//  Created by Christian Rasmussen on 04/11/10.
//  Copyright 2010 Apoltix. All rights reserved.
//  Modified by Alessio Moiso on 16/01/13,
//  Copyright 2013 MrAsterisco. All rights reserved.
//

#import "TMDBPromisedPerson.h"
#import "TMDBMovie.h"

@implementation TMDBPromisedPerson

@synthesize id=_id, name=_name, character=_character, job=_job, url=_url, order=_order, castID=_castID, profileURL=_profileURL;

+ (NSArray *)peopleWithPeopleInfo:(NSArray *)peopleInfo
{
	NSMutableArray *persons = [NSMutableArray arrayWithCapacity:[peopleInfo count]];

	for (NSDictionary *person in peopleInfo)
		[persons addObject:[[TMDBPromisedPerson alloc] initWithPersonInfo:person]];

	return persons;
}

- (id)initWithPersonInfo:(NSDictionary *)personInfo
{
	if ((self = [super init])) {
		_id = [[personInfo objectForKey:@"id"] integerValue];
		_name = [[personInfo objectForKey:@"name"] copy];
		_character = [[personInfo objectForKey:@"character"] copy];
		_job = [[personInfo objectForKey:@"job"] copy];
        if ([personInfo objectForKey:@"url"] != nil) {
            _url = [NSURL URLWithString:[personInfo objectForKey:@"url"]];
        }
		_order = [[personInfo objectForKey:@"order"] integerValue];
		_castID = [[personInfo objectForKey:@"cast_id"] integerValue];
        if ([personInfo objectForKey:@"profile"] != nil) {
            _profileURL = [NSURL URLWithString:[personInfo objectForKey:@"profile"]];
        }
	}
	return self;
}

- (void)dealloc {
    _character = nil;
    _name = nil;
    _job = nil;
    _url = nil;
    _profileURL = nil;
}


@end
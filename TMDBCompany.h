//
//  TMDBCompany.h
//  iTMDb
//
//  Created by Alessio Moiso on 27/04/14.
//  Copyright (c) 2014 Apoltix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMDBCompany : NSObject

@property NSNumber *identifier;
@property NSString *name;

+ (instancetype)companyWithName:(NSString*)name andIdentifier:(NSNumber*)identifier;
- (id)initWithCompanyName:(NSString*)name andIdentifier:(NSNumber*)identifier;

@end

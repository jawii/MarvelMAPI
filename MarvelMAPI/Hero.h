//
//  Hero.h
//  MarvelMAPI
//
//  Created by Jaakko Kenttä on 12/05/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hero : NSObject

@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) NSNumber *heroID;
@property (nonatomic, strong) NSString *heroName;

+ (instancetype) heroWithDictionary: (NSDictionary *) dictionary;

@end

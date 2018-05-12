//
//  Hero.m
//  MarvelMAPI
//
//  Created by Jaakko Kenttä on 12/05/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

#import "Hero.h"

@implementation Hero

+ (instancetype) heroWithDictionary: (NSDictionary *) dictionary {
    Hero *hero = [[Hero alloc] init];
    
    NSString *urlForImage;
    
    if(hero) {
        //hero.imageURL = [NSURL URLWithString:[dictionary valueForKeyPath:@"thumbnail.path"]];
        NSString *base = [dictionary valueForKeyPath:@"thumbnail.path"];
        urlForImage = [NSString stringWithFormat:@"%@/%@%@" , base , @"standard_large" , @".jpg"];
        hero.imageURL = [NSURL URLWithString:urlForImage];
        //NSLog(@"%@", hero.imageURL);
        
        hero.heroName = [dictionary valueForKey:@"name"];
        hero.heroID = [dictionary valueForKey:@"id"];
    }
    
    return hero;
}


@end

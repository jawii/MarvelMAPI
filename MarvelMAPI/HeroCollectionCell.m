//
//  HeroCollectionCell.m
//  MarvelMAPI
//
//  Created by Jaakko Kenttä on 12/05/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

#import "HeroCollectionCell.h"
#import "Hero.h"

@implementation HeroCollectionCell

- (void)setHero:(Hero *)hero {
    _hero = hero;
    [self downloadImageWithURL:hero.imageURL];
}

- (void)downloadImageWithURL:(NSURL*)url {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.heroImage.image = image;
            //NSLog(@"Image set!");
        });
    }];
    
    [task resume];
}


@end

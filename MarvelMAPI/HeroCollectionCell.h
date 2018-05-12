//
//  HeroCollectionCell.h
//  MarvelMAPI
//
//  Created by Jaakko Kenttä on 12/05/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Hero;

@interface HeroCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *heroImage;
@property (weak, nonatomic) IBOutlet UILabel *heroName;

@property (strong, nonatomic) Hero *hero;

@end

//
//  HeroesCollectionViewController.m
//  MarvelMAPI
//
//  Created by Jaakko Kenttä on 12/05/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

#import "HeroesCollectionViewController.h"
#import "MD5.h"
#import "Hero.h"
#import "ViewController.h"
#import "HeroCollectionCell.h"

@interface HeroesCollectionViewController ()
@property (strong, nonatomic) NSMutableArray *heros;
@end

@implementation HeroesCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

NSString *PUBLIC_KEY = @"beadab1530b86728a1e92107bd72d0a3";
NSString *PRIVATE_KEY = @"9e07aab5bffd857caeb9a8762d9c7ab28ef0a019";






- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.heros = [NSMutableArray array];
    
    // Do any additional setup after loading the view.
    NSURLSession *session = [NSURLSession sharedSession];
    
    // TimeStamp
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    NSNumber *timeStampObj = [NSNumber numberWithDouble: timeStamp];

    
    NSString *myString = [NSString stringWithFormat:@"%@%@%@", timeStampObj, PRIVATE_KEY, PUBLIC_KEY];
    NSString *hash = [myString MD5];
    NSString *urlString = [NSString stringWithFormat:@"https://gateway.marvel.com/v1/public/characters?orderBy=name&limit=50&offset=50&ts=%@&apikey=beadab1530b86728a1e92107bd72d0a3&hash=%@", timeStampObj, hash];

    
    
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        //NSLog(@"response dictionary: %@", dictionary);
        NSArray *dictionaries = [[dictionary valueForKey:@"data"] valueForKey:@"results"];
 
        
        for(NSDictionary *dict in dictionaries) {
            Hero *hero = [Hero heroWithDictionary:dict];
            [self.heros addObject:hero];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            NSLog(@"Reloading Collection View...");
        });

    }];
    [task resume];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.heros count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HeroCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    //NSLog(@"Setting up Cell");
    Hero *hero = [self.heros objectAtIndex:indexPath.row];
    cell.hero = hero;
    cell.heroName.text = hero.heroName;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end

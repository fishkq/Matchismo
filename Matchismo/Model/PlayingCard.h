//
//  PlayingCard.h
//  Matchismo
//
//  Created by YuKunquan on 12/13/15.
//  Copyright (c) 2015 YuKunquan. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;

+ (NSUInteger)maxRank;

@end

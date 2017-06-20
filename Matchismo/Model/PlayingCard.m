//
//  PlayingCard.m
//  Matchismo
//
//  Created by YuKunquan on 12/13/15.
//  Copyright (c) 2015 YuKunquan. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}


@synthesize suit = _suit;
+ (NSArray *)validSuits {
    return @[@"♠︎", @"♥︎", @"♣︎", @"♦︎"];
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 4;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        }
    } else if ([otherCards count] == 2) {
        PlayingCard *secondCard = [otherCards objectAtIndex:0];
        PlayingCard *thirdCard = [otherCards objectAtIndex:1];
        if (self.rank == secondCard.rank == thirdCard.rank) {
            score = 4;
        } else if (self.rank == secondCard.rank || self.rank == thirdCard.rank || secondCard.rank == thirdCard.rank) {
            score = 1;
        }
    }
    return score;
}

@end

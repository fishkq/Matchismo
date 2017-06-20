//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by YuKunquan on 12/15/15.
//  Copyright (c) 2015 YuKunquan. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }

        }
    }
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index {
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            // match against other chosen cards
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

-(void)chooseCardAtIndex:(NSUInteger)index withMode:(NSUInteger)i {
    if (i == 2) {
        [self chooseCardAtIndex:index];
    } else if (i == 3) {
        Card *card = [self cardAtIndex:index];
        if (!card.isMatched) {
            if (card.isChosen) {
                card.chosen = NO;
            } else {
                NSMutableArray *otherCards = [[NSMutableArray alloc] init];
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        [otherCards addObject:otherCard];
                        if ([otherCards count] == 2) {
                            break;
                        }
                    }
                }
                if ([otherCards count] == 2) {
                    int matchScore = [card match:otherCards];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        for (Card *card in otherCards) {
                            card.matched = YES;
                        }
                        card.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        for (Card *card in otherCards) {
                            card.chosen = NO;
                        }
                    }
                }
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
                
            }
        }
    }
}

@end

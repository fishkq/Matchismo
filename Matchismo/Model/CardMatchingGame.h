//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by YuKunquan on 12/15/15.
//  Copyright (c) 2015 YuKunquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (void)chooseCardAtIndex:(NSUInteger)index
                             withMode:(NSUInteger)i;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;

@end

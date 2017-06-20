//
//  Deck.h
//  Matchismo
//
//  Created by YuKunquan on 12/13/15.
//  Copyright (c) 2015 YuKunquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end

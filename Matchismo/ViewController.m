//
//  ViewController.m
//  Matchismo
//
//  Created by YuKunquan on 12/12/15.
//  Copyright (c) 2015 YuKunquan. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *switchControl;
@property (nonatomic) NSInteger switch_;
@end

@implementation ViewController

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
        
    }
    return _game;
}

- (void)setSwitch:(BOOL)flag {
    for (NSUInteger num = 0; num < [[self switchControl] numberOfSegments]; num++) {
        [[self switchControl] setEnabled:flag forSegmentAtIndex:num];
    }
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)setSwitchValue:(UISegmentedControl *)sender {
    self.switch_ = [self.switchControl selectedSegmentIndex];
}


- (IBAction)touchCarButton:(UIButton *)sender {
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    NSInteger mode = self.switch_;
    NSLog(@"mode:%ld", (long)mode);
    [self.game chooseCardAtIndex:chosenButtonIndex withMode:mode == 0 ? 2 : (mode == 1 ? 3 : -1)];
    [self updateUI];
}

- (IBAction)startNewGame:(UIButton *)sender {
    self.game = nil;
    [self updateUI];
    [self setSwitch:TRUE];
}


- (void)updateUI {
    [self setSwitch:FALSE];
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    }
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end

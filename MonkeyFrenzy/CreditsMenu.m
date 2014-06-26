//
//  CreditsMenu.m
//  MonkeyFrenzy
//
//  Created by Myers on 6/14/14.
//  Copyright (c) Blake Myers All rights reserved.
//

#import "CreditsMenu.h"

@implementation CreditsMenu

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        // 1
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0];
        
        // 2
        NSString * message;
        message = @"You Fed All the Monkeys!";

        
        // 3
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label.text = message;
        label.fontSize = 25;
        label.fontColor = [SKColor blackColor];
        label.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:label];
        
        // 4
        //[self runAction:
        // [SKAction sequence:@[
        //                     [SKAction waitForDuration:3.0],
        //                     [SKAction runBlock:^{
        // 5
        //   SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        //   SKScene * myScene = [[GameScene alloc] initWithSize:self.size];
        //     [self.view presentScene:myScene transition: reveal];
        // }]
        //                      ]]
        // ];
        
    }
    return self;
}

@end

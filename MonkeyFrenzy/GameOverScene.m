//
//  GameOverScene.m
//  MonkeyFrenzy
//
//  Created by Myers on 6/14/14.
//  Copyright (c) Blake Myers All rights reserved.
//


#import "GameScene.h"
#import "GameOverScene.h"
 
@implementation GameOverScene

ModeType theModeSelected;

-(id)initWithSize:(CGSize)size won:(BOOL)won mode:(ModeType)modePicked{
    if (self = [super initWithSize:size]) {
 
        theModeSelected = modePicked;
        // 1
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0];
        
        // 2
        NSString * message;
        if (won) {
            message = @"You Fed All the Monkeys!";
        } else {
            message = @"Oh No, the Monkeys Got Past!";
        }
 
        // 3
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Menlo-Regular"];
        label.text = message;
        label.fontSize = 25;
        label.fontColor = [SKColor blackColor];
        label.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:label];
 
        // 4
        [self runAction:
            [SKAction sequence:@[
                [SKAction waitForDuration:3.0],
                [SKAction runBlock:^{
                    // 5
                    SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
                    SKScene * myScene = [[GameScene alloc] initWithSize:self.size mode:theModeSelected];
                    [self.view presentScene:myScene transition: reveal];
                }]
            ]]
        ];
 
    }
    return self;
}
 
@end

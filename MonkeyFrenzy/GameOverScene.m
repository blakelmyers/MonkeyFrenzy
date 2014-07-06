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

-(id)initWithSize:(CGSize)size won:(BOOL)won mode:(ModeType)modePicked score:(int)gameScore{
    if (self = [super initWithSize:size]) {
 
        theModeSelected = modePicked;
        // 1
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0];
        
        if(modePicked == FRENZY)
        {
            
            [self runAction:[SKAction playSoundFileNamed:@"monkeySound.m4a" waitForCompletion:NO]];
            
            // Store the data
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            if(gameScore > [[defaults objectForKey:@"frenzyScore"] intValue])
            {
                [defaults setObject:[NSNumber numberWithInteger:gameScore] forKey:@"frenzyScore"];
                [defaults synchronize];
            }
            
            NSString * highScore = [NSString stringWithFormat:@"HIGH SCORE: %d", [[defaults objectForKey:@"frenzyScore"] intValue]];
            SKLabelNode *label2 = [SKLabelNode labelNodeWithFontNamed:@"Menlo-Regular"];
            label2.text = highScore;
            label2.fontSize = 25;
            label2.fontColor = [SKColor blackColor];
            label2.position = CGPointMake(self.size.width/2, self.size.height/1.1);
            [self addChild:label2];
        
        }
        // 2
        NSString * message;
        if (won) {
            message = @"You Fed All the Monkeys!";
        } else {
            message = @"OH NO, THE MONKEY GOT PAST!";
        }
 
        // 3
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Menlo-Regular"];
        label.text = message;
        label.fontSize = 25;
        label.fontColor = [SKColor blackColor];
        label.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:label];
        
        
        NSString *tryMessage;
        tryMessage = @"TRY AGAIN ?";
        
        SKLabelNode *tryLabel = [SKLabelNode labelNodeWithFontNamed:@"Menlo-Regular"];
        tryLabel.text = tryMessage;
        tryLabel.fontSize = 30;
        tryLabel.name = @"try";
        tryLabel.fontColor = [SKColor blackColor];
        tryLabel.position = CGPointMake(self.size.width/2, self.size.height/5);
 
        [self addChild:tryLabel];
        
       /*
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
        */
 
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    // 1 - Choose one of the touches to work with
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"try"]) {
        [self runAction:
         [SKAction sequence:@[
                              [SKAction runBlock:^{
             // 5
             SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
             SKScene * myScene = [[GameScene alloc] initWithSize:self.size mode:theModeSelected];
             [self.view presentScene:myScene transition: reveal];
         }]
                              ]]
         ];
        return;
    }
}
 
@end

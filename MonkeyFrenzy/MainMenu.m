//
//  MainMenu.m
//  MonkeyFrenzy
//
//  Created by Myers on 6/14/14.
//  Copyright (c) Blake Myers All rights reserved.
//

#import "MainMenu.h"
#import "GameScene.h"

@implementation MainMenu


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
        
        self.backgroundColor = [SKColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
        SKSpriteNode *bgImage = [SKSpriteNode spriteNodeWithImageNamed:@"Background"];
        bgImage.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:bgImage];
        
        NSString *message;
        message = @"Select a mode by tapping the monkeys";
        
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Menlo-Regular"];
        label.text = message;
        label.fontSize = 15;
        label.fontColor = [SKColor blackColor];
        label.position = CGPointMake(self.size.width/2, self.size.height/2.9);
        [self addChild:label];
        
        SKSpriteNode * title = [SKSpriteNode spriteNodeWithImageNamed:@"TitlePic"];
        title.position = CGPointMake(self.size.width/2, self.size.height/1.5);
        [self addChild:title];
        
        SKSpriteNode * easyBtn = [SKSpriteNode spriteNodeWithImageNamed:@"monkey"];
        easyBtn.position = CGPointMake(self.size.width/6, self.size.height/5);
        easyBtn.name = @"Easy";
        [self addChild:easyBtn];
        
        SKSpriteNode * normalBtn = [SKSpriteNode spriteNodeWithImageNamed:@"fatMonkey"];
        normalBtn.position = CGPointMake(self.size.width/2, self.size.height/5);
        normalBtn.name = @"Normal";
        [self addChild:normalBtn];
        
        SKSpriteNode *frenzyBtn = [SKSpriteNode spriteNodeWithImageNamed:@"frenzyMonkey"];
        frenzyBtn.position = CGPointMake(self.size.width/1.2, self.size.height/5);
        frenzyBtn.name = @"Frenzy";
        [self addChild:frenzyBtn];
        
    }
    return self;
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    ModeType selection;
    
    if ([node.name isEqualToString:@"Easy"]) {
        selection = EASY_MODE;
    }
    if ([node.name isEqualToString:@"Normal"]) {
        selection = NORMAL_MODE;
    }
    if ([node.name isEqualToString:@"Frenzy"]) {
        selection = FRENZY_MODE;
    }
    if(node.name)
    {
       [self runAction:
        [SKAction sequence:@[
                             [SKAction runBlock:^{
            // 5
            SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
            SKScene * myScene = [[GameScene alloc] initWithSize:self.size mode:selection];
            [self.view presentScene:myScene transition: reveal];
        }]
                          ]]
     ];
    }
}

@end


//
//  MainMenu.m
//  MonkeyFrenzy
//
//  Created by Myers on 6/14/14.
//  Copyright (c) Blake Myers All rights reserved.
//

#import "MainMenu.h"
#import "GameScene.h"
#import "CreditsMenu.h"


@interface MainMenu ()
@end

@implementation MainMenu


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        NSString *notificationName = @"TurnAdsOn";
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil userInfo:nil];
        
        self.backgroundColor = [SKColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
        
        SKSpriteNode *bgImage = [SKSpriteNode spriteNodeWithImageNamed:@"Background"];
        bgImage.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:bgImage];
        
        NSString *message;
        message = @"SELECT A MODE";
        
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Menlo-Regular"];
        label.text = message;
        label.name = @"test";
        label.fontSize = 22;
        label.fontColor = [SKColor blackColor];
        label.position = CGPointMake(self.size.width/2, self.size.height/2.8);
        [self addChild:label];
        
        SKSpriteNode * title = [SKSpriteNode spriteNodeWithImageNamed:@"TitlePic"];
        title.position = CGPointMake(self.size.width/2, self.size.height/1.6);
        [self addChild:title];
        
        SKSpriteNode * easyBtn = [SKSpriteNode spriteNodeWithImageNamed:@"monkey"];
        easyBtn.position = CGPointMake(self.size.width/3, self.size.height/6);
        easyBtn.name = @"Easy";
        [self addChild:easyBtn];
        
        /*
        SKSpriteNode * normalBtn = [SKSpriteNode spriteNodeWithImageNamed:@"monkeyBig"];
        normalBtn.position = CGPointMake(self.size.width/2, self.size.height/6);
        normalBtn.name = @"Normal";
        [self addChild:normalBtn];
        */
        
        SKSpriteNode *frenzyBtn = [SKSpriteNode spriteNodeWithImageNamed:@"frenzyMonkey"];
        frenzyBtn.position = CGPointMake(self.size.width/1.5, self.size.height/6);
        frenzyBtn.name = @"Frenzy";
        [self addChild:frenzyBtn];
        
        NSString *message2;
        message2 = @"EASY";
        
        SKLabelNode *label2 = [SKLabelNode labelNodeWithFontNamed:@"Menlo-Regular"];
        label2.text = message2;
        label2.fontSize = 18;
        label2.fontColor = [SKColor blackColor];
        label2.position = CGPointMake(self.size.width/3, self.size.height/3.7);
        [self addChild:label2];
        
        /*
        NSString *message3;
        message3 = @"Normal";
        
        SKLabelNode *label3 = [SKLabelNode labelNodeWithFontNamed:@"Menlo-Regular"];
        label3.text = message3;
        label3.fontSize = 18;
        label3.fontColor = [SKColor blackColor];
        label3.position = CGPointMake(self.size.width/2, self.size.height/3.7);
        [self addChild:label3];
        */
        
        NSString *message4;
        message4 = @"FRENZY";
        
        SKLabelNode *label4 = [SKLabelNode labelNodeWithFontNamed:@"Menlo-Regular"];
        label4.text = message4;
        label4.fontSize = 18;
        label4.fontColor = [SKColor blackColor];
        label4.position = CGPointMake(self.size.width/1.5, self.size.height/3.7);
        [self addChild:label4];
        
        NSString *menuMessage;
        menuMessage = @"CREDITS";
        
        SKLabelNode *menuLabel = [SKLabelNode labelNodeWithFontNamed:@"Menlo-Regular"];
        menuLabel.text = menuMessage;
        menuLabel.fontSize = 20;
        menuLabel.name = @"credits";
        menuLabel.fontColor = [SKColor blackColor];
        menuLabel.position = CGPointMake(self.size.width/1.1, self.size.height/20);
        
        SKSpriteNode *creditBack = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(menuLabel.frame.size.width, menuLabel.frame.size.height)];
        creditBack.position = CGPointMake(self.size.width/1.1, self.size.height/13);
        
        [self addChild:creditBack];
        [self addChild:menuLabel];
        
        
        //[self addChild:menuLabel];
        
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
    if ([node.name isEqualToString:@"credits"]) {
        [self runAction:
         [SKAction sequence:@[
                              [SKAction runBlock:^{
             // 5
             SKTransition *reveal = [SKTransition flipVerticalWithDuration:0.5];
             SKScene * myScene = [[CreditsMenu alloc] initWithSize:self.size];
             [self.view presentScene:myScene transition: reveal];
         }]
                              ]]
         ];
        return;
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


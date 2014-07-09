//
//  CreditsMenu.m
//  MonkeyFrenzy
//
//  Created by Myers on 6/14/14.
//  Copyright (c) Blake Myers All rights reserved.
//

#import "CreditsMenu.h"
#import "MainMenu.h"

@implementation CreditsMenu

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0];
        SKSpriteNode *bgImage = [SKSpriteNode spriteNodeWithImageNamed:@"Background"];
        bgImage.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:bgImage];
        
        NSString * message;
        message = @"CREDITS";

        SKSpriteNode *player = [SKSpriteNode spriteNodeWithImageNamed:@"Zookeeper_Female"];
        player.position = CGPointMake(player.size.width/2, self.frame.size.height/1.5);
        [self addChild:player];
        
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Menlo-Regular"];
        label.text = message;
        label.fontSize = 25;
        label.fontColor = [SKColor blackColor];
        label.position = CGPointMake(self.size.width/2, self.size.height/1.3);
        [self addChild:label];
        
        NSString *message3;
        message3 = @"My Daughter and Her Love of Monkeys";
        
        SKLabelNode *label3 = [SKLabelNode labelNodeWithFontNamed:@"Menlo-Regular"];
        label3.text = message3;
        label3.fontSize = 16;
        label3.fontColor = [SKColor blackColor];
        label3.position = CGPointMake(self.size.width/2, self.size.height/1.8);
        [self addChild:label3];
        
        NSString *message4;
        message4 = @"Music by audionautix.com";
        
        SKLabelNode *label4 = [SKLabelNode labelNodeWithFontNamed:@"Menlo-Regular"];
        label4.text = message4;
        label4.fontSize = 16;
        label4.fontColor = [SKColor blackColor];
        label4.position = CGPointMake(self.size.width/2, self.size.height/2.15);
        [self addChild:label4];
        
        NSString *message2;
        message2 = @"Background Image from ilovekidschurch.com";
        
        SKLabelNode *label2 = [SKLabelNode labelNodeWithFontNamed:@"Menlo-Regular"];
        label2.text = message2;
        label2.fontSize = 16;
        label2.fontColor = [SKColor blackColor];
        label2.position = CGPointMake(self.size.width/2, self.size.height/2.6);
        [self addChild:label2];
        
        NSString *message5;
        message5 = @"SimpleSpriteKitGame from www.raywenderlich.com";
        
        SKLabelNode *label5 = [SKLabelNode labelNodeWithFontNamed:@"Menlo-Regular"];
        label5.text = message5;
        label5.fontSize = 16;
        label5.fontColor = [SKColor blackColor];
        label5.position = CGPointMake(self.size.width/2, self.size.height/3.3);
        [self addChild:label5];
        
        NSString *menuMessage;
        menuMessage = @"MENU";
        
        SKLabelNode *menuLabel = [SKLabelNode labelNodeWithFontNamed:@"Menlo-Regular"];
        menuLabel.text = menuMessage;
        menuLabel.fontSize = 20;
        menuLabel.name = @"menu";
        menuLabel.fontColor = [SKColor blackColor];
        menuLabel.position = CGPointMake(self.size.width/1.07, self.size.height/20);
        
        SKSpriteNode *menuBack = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(menuLabel.frame.size.width, menuLabel.frame.size.height)];
        menuBack.position = CGPointMake(self.size.width/1.07, self.size.height/13);
        
        [self addChild:menuBack];
        [self addChild:menuLabel];
        
    }
    return self;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    // 1 - Choose one of the touches to work with
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"menu"]) {
        [self runAction:
         [SKAction sequence:@[
                              [SKAction runBlock:^{
             // 5
             SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
             SKScene * myScene = [[MainMenu alloc] initWithSize:self.size];
             [self.view presentScene:myScene transition: reveal];
         }]
                              ]]
         ];
        return;
    }
}

@end

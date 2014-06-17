//
//  MainMenu.m
//  MonkeyFrenzy
//
//  Created by Myers on 6/14/14.
//

#import "MainMenu.h"
#import "GameScene.h"

@implementation MainMenu


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        // 1
        self.backgroundColor = [SKColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
        
        // 2
        self.backgroundColor = [SKColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
        SKSpriteNode *bgImage = [SKSpriteNode spriteNodeWithImageNamed:@"Background"];
        bgImage.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:bgImage];
        
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
    
    // 1 - Choose one of the touches to work with
    //UITouch *touch = [touches anyObject];
    //SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:[touch locationInNode:self]];
    
    
    [self runAction:
     [SKAction sequence:@[
                          [SKAction runBlock:^{
         // 5
         SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
         SKScene * myScene = [[GameScene alloc] initWithSize:self.size];
         [self.view presentScene:myScene transition: reveal];
     }]
                          ]]
     ];
    
}

@end


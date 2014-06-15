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
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0];
        
        // 2
        NSString * message;
        message = @"MONKEY FRENZY";
        
        // 3
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label.text = message;
        label.fontSize = 40;
        label.fontColor = [SKColor blackColor];
        label.position = CGPointMake(self.size.width/2, self.size.height/1.5);
        [self addChild:label];
        
        NSString * subMessage;
        subMessage = @"Feed all the Monkeys before they get by you!";
        
        SKLabelNode *subLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        subLabel.text = subMessage;
        subLabel.fontSize = 18;
        subLabel.fontColor = [SKColor blackColor];
        subLabel.position = CGPointMake(self.size.width/2, self.size.height/3);
        [self addChild:subLabel];
        
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 1 - Choose one of the touches to work with
    //UITouch * touch = [touches anyObject];
    
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


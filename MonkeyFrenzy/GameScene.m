//
//  GameScene.m
//
//  Created by Myers on 6/14/14.
//  Copyright (c) Blake Myers All rights reserved.
//

#import "GameScene.h"
#import "GameOverScene.h"
#import "MainMenu.h"

static const uint32_t bananaCategory     =  0x1 << 0;
static const uint32_t monkeyCategory        =  0x1 << 1;

// 1
@interface GameScene () <SKPhysicsContactDelegate>
@property (nonatomic) SKSpriteNode * player;
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) int monkeysFed;
@property (nonatomic) MonkeyType theMonkeyType;
@property (nonatomic) ModeType theModeSelected;
@property (nonatomic) BOOL displayLabel;;
@property (nonatomic) SKLabelNode *label;
@property (nonatomic) int bananaCount;
@property (nonatomic) int frenzyCount;
@end

static inline CGPoint rwAdd(CGPoint a, CGPoint b) {
    return CGPointMake(a.x + b.x, a.y + b.y);
}
 
static inline CGPoint rwSub(CGPoint a, CGPoint b) {
    return CGPointMake(a.x - b.x, a.y - b.y);
}
 
static inline CGPoint rwMult(CGPoint a, float b) {
    return CGPointMake(a.x * b, a.y * b);
}

static inline float rwLength(CGPoint a) {
    return sqrtf(a.x * a.x + a.y * a.y);
}
 
// Makes a vector have a length of 1
static inline CGPoint rwNormalize(CGPoint a) {
    float length = rwLength(a);
    return CGPointMake(a.x / length, a.y / length);
}

@implementation GameScene



-(id)initWithSize:(CGSize)size mode:(ModeType)modePicked{
    if (self = [super initWithSize:size]) {

        self.theModeSelected = modePicked;
        self.displayLabel = true;
        self.frenzyCount = 0;
        self.bananaCount = 0;

        self.backgroundColor = [SKColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
        SKSpriteNode *bgImage = [SKSpriteNode spriteNodeWithImageNamed:@"Background"];
        bgImage.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:bgImage];
        
        self.player = [SKSpriteNode spriteNodeWithImageNamed:@"Zookeeper_Female"];
        self.player.position = CGPointMake(self.player.size.width/2, self.frame.size.height/6);
        [self addChild:self.player];
      
        self.physicsWorld.gravity = CGVectorMake(0,0);
        self.physicsWorld.contactDelegate = self;
        
        self.theMonkeyType = FRENZY;
        
        NSString *message;
        if(self.theModeSelected == FRENZY_MODE)
        {
            message = @"0";
        }
        else
        {
            message = @"TAP TO THROW BANANAS AND FEED THE MONKEYS";
        }
        
        self.label = [SKLabelNode labelNodeWithFontNamed:@"Menlo-Regular"];
        self.label.text = message;
        self.label.fontSize = 15;
        self.label.fontColor = [SKColor blackColor];
        self.label.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:self.label];
        
        NSString *menuMessage;
        menuMessage = @"MENU";
        
        SKLabelNode *menuLabel = [SKLabelNode labelNodeWithFontNamed:@"Menlo-Regular"];
        menuLabel.text = menuMessage;
        menuLabel.fontSize = 20;
        menuLabel.name = @"menu";
        menuLabel.fontColor = [SKColor blackColor];
        menuLabel.position = CGPointMake(self.size.width/12, self.size.height/1.1);
        
        SKSpriteNode *menuBack = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(menuLabel.frame.size.width, menuLabel.frame.size.height)];
        menuBack.position = CGPointMake(self.size.width/12, self.size.height/1.07);
        
        [self addChild:menuBack]; 
        [self addChild:menuLabel];
        
        if(self.theModeSelected == FRENZY_MODE)
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
            NSString * highScore = [NSString stringWithFormat:@"HIGH SCORE: %d", [[defaults objectForKey:@"frenzyScore"] intValue]];
            SKLabelNode *label2 = [SKLabelNode labelNodeWithFontNamed:@"Menlo-Regular"];
            label2.text = highScore;
            label2.fontSize = 20;
            label2.fontColor = [SKColor blackColor];
            label2.position = CGPointMake(self.size.width/2, self.size.height/1.1);
            [self addChild:label2];
        }
 
    }
    return self;
}

- (void)addMonkey:(MonkeyType)type {
 
    // Create sprite
    SKSpriteNode * monkey;
    
    int actualDuration;  // monkey speed
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInt:1], @"Health",
                                 nil];
    
    switch (type)
    {
        case NORMAL:
            monkey = [SKSpriteNode spriteNodeWithImageNamed:@"monkey"];
            actualDuration = 3.0;
            [dict setObject:[NSNumber numberWithInt:2] forKey:@"Health"];
            break;
        case FAT:
            monkey = [SKSpriteNode spriteNodeWithImageNamed:@"monkeyBig"];
            [dict setObject:[NSNumber numberWithInt:5] forKey:@"Health"];
            actualDuration = 6.0;
            break;
        case FRENZY:
            monkey = [SKSpriteNode spriteNodeWithImageNamed:@"frenzyMonkey"];
            [dict setObject:[NSNumber numberWithInt:1] forKey:@"Health"];
            if(self.theModeSelected == FRENZY_MODE)
            {
                actualDuration = 1.7;
            }
            else
            {
                actualDuration = 2.0;
            }
            break;
        default:
            monkey = [SKSpriteNode spriteNodeWithImageNamed:@"monkey"];
            [dict setObject:[NSNumber numberWithInt:2] forKey:@"Health"];
            actualDuration = 3.0;
            break;
    }
    
    monkey.userData = dict;
    
    monkey.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:monkey.size]; // 1
    monkey.physicsBody.dynamic = YES; // 2
    monkey.physicsBody.categoryBitMask = monkeyCategory; // 3
    monkey.physicsBody.contactTestBitMask = bananaCategory; // 4
    monkey.physicsBody.collisionBitMask = 0; // 5
  
    if(self.theModeSelected == EASY_MODE)
    {
        // Determine where to spawn the monkey along the Y axis
        int minY = monkey.size.height / 2;
        int maxY = self.frame.size.height - monkey.size.height / 2;
        int rangeY = maxY - minY;
        int actualY = (arc4random() % rangeY) + minY;
        
        int minX = monkey.size.width / 2;
        int maxX = self.frame.size.width - monkey.size.width / 2;
        int rangeX = maxX - minX;
        int actualX = (arc4random() % rangeX) + minX;
        
        // Create the monkey slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        monkey.position = CGPointMake(actualX, actualY);
        [self addChild:monkey];
    }
    else
    {
        // Determine where to spawn the monkey along the Y axis
        int minY = monkey.size.height / 2;
        int maxY = self.frame.size.height - monkey.size.height / 2;
        int rangeY = maxY - minY;
        int actualY = (arc4random() % rangeY) + minY;
        
        // Create the monkey slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        monkey.position = CGPointMake(self.frame.size.width + monkey.size.width/2, actualY);
        [self addChild:monkey];
 
        // Create the actions
        SKAction * actionMove = [SKAction moveTo:CGPointMake(-monkey.size.width/2, actualY) duration:actualDuration];
        SKAction * actionMoveDone = [SKAction removeFromParent];
        
        int scoreIfFrenzy = 0;
        
        if(self.theModeSelected == FRENZY_MODE)
        {
            scoreIfFrenzy = self.frenzyCount;
            ++scoreIfFrenzy;
        }
        SKAction * loseAction = [SKAction runBlock:^{
        if(self.theModeSelected == FRENZY_MODE)
        {
            [self runAction:[SKAction playSoundFileNamed:@"monkeySound.m4a" waitForCompletion:NO]];
        }
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
            SKScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size won:NO mode:self.theModeSelected score:scoreIfFrenzy];
        [self.view presentScene:gameOverScene transition: reveal];
        }];
        [monkey runAction:[SKAction sequence:@[actionMove, loseAction, actionMoveDone]]];
    }
}

- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
 
    self.lastSpawnTimeInterval += timeSinceLast;
    
    if(self.theModeSelected == EASY_MODE)
    {
        if (self.lastSpawnTimeInterval > 3) {
            switch (self.theMonkeyType)
            {
                case NORMAL:
                    self.theMonkeyType = FAT;
                    break;
                case FAT:
                    self.theMonkeyType = NORMAL;
                    break;
                default:
                    self.theMonkeyType = NORMAL;
                    break;
            }
            self.lastSpawnTimeInterval = 0;
            [self addMonkey:self.theMonkeyType];
        }
    }
    else if (self.theModeSelected == NORMAL_MODE)
    {
        if (self.lastSpawnTimeInterval > 1) {
            switch (self.theMonkeyType)
            {
                case NORMAL:
                    self.theMonkeyType = FAT;
                    break;
                case FAT:
                    self.theMonkeyType = FRENZY;
                    break;
                case FRENZY:
                    self.theMonkeyType = NORMAL;
                    break;
                default:
                    self.theMonkeyType = NORMAL;
                    break;
            }
            self.lastSpawnTimeInterval = 0;
            [self addMonkey:self.theMonkeyType];
        }
    }
    else   // FRENZY_MODE
    {
        if (self.lastSpawnTimeInterval > 0.6) {
            self.theMonkeyType = FRENZY;
            ++self.bananaCount;
            self.lastSpawnTimeInterval = 0;
            [self addMonkey:self.theMonkeyType];
        }
    }
}

- (void)update:(NSTimeInterval)currentTime {
    // Handle time delta.
    // If we drop below 60fps, we still want everything to move the same distance.
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1) { // more than a second since last update
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;
    }
 
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
 
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
 
    if(self.displayLabel && self.theModeSelected != FRENZY_MODE)
    {
        self.displayLabel = false;
        [self.label removeFromParent];
    }
 
    // 1 - Choose one of the touches to work with
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"menu"]) {
        [self runAction:
         [SKAction sequence:@[
                              [SKAction runBlock:^{
             // 5
             SKTransition *reveal = [SKTransition flipVerticalWithDuration:0.5];
             SKScene * myScene = [[MainMenu alloc] initWithSize:self.size];
             [self.view presentScene:myScene transition: reveal];
         }]
                              ]]
         ];
        return;
    }
 
    // 2 - Set up initial location of banana
    SKSpriteNode * banana = [SKSpriteNode spriteNodeWithImageNamed:@"Bananas"];
    banana.position = self.player.position;
    banana.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:banana.size.width/2];
    banana.physicsBody.dynamic = YES;
    banana.physicsBody.categoryBitMask = bananaCategory;
    banana.physicsBody.contactTestBitMask = monkeyCategory;
    banana.physicsBody.collisionBitMask = 0;
    banana.physicsBody.usesPreciseCollisionDetection = YES;

    // 3- Determine offset of location to banana
    CGPoint offset = rwSub(location, banana.position);
 
    // 4 - Bail out if you are shooting down or backwards
    if (offset.x <= 0) return;
 
    if(self.theModeSelected != FRENZY_MODE)
    {
        [self addChild:banana];
        [self runAction:[SKAction playSoundFileNamed:@"throwing.m4a" waitForCompletion:NO]];
    }
    else  // have limited bananas in Frenzy mode
    {
        if(self.bananaCount > 0)
        {
            [self addChild:banana];
            [self runAction:[SKAction playSoundFileNamed:@"throwing.m4a" waitForCompletion:NO]];
        }
    }
 
    // 6 - Get the direction of where to shoot
    CGPoint direction = rwNormalize(offset);
 
    // 7 - Make it shoot far enough to be guaranteed off screen
    CGPoint shootAmount = rwMult(direction, 1000);
 
    // 8 - Add the shoot amount to the current position       
    CGPoint realDest = rwAdd(shootAmount, banana.position);
 
    // 9 - Create the actions
    float velocity = 280.0/1.0;
    float realMoveDuration = self.size.width / velocity;
    SKAction * actionMove = [SKAction moveTo:realDest duration:realMoveDuration];
    SKAction * actionMoveDone = [SKAction removeFromParent];
    
    if(self.theModeSelected != FRENZY_MODE)
    {
        [banana runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
    }
    else  // have limited bananas in Frenzy mode
    {
        if(self.bananaCount > 0)
        {
            --self.bananaCount;
            [banana runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
        }
    }
 
}

- (void)banana:(SKSpriteNode *)banana didCollideWithMonkey:(SKSpriteNode *)monkey {
    
    [banana removeFromParent];
    int checkHealth = [[monkey.userData valueForKey:@"Health"] intValue];
    if (checkHealth <= 1)
    {
        if(self.theModeSelected != FRENZY_MODE)
        {
           [self runAction:[SKAction playSoundFileNamed:@"monkeySound.m4a" waitForCompletion:NO]];
        }
        
        [monkey removeFromParent];
        if(self.theModeSelected == FRENZY_MODE)
        {
            ++self.frenzyCount;
            self.label.text = [NSString stringWithFormat:@"%d", self.frenzyCount];
        }
        else
        {
            self.monkeysFed++;
            if (self.monkeysFed > 30) {
                SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
                SKScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size won:YES mode:self.theModeSelected score:0];
                [self.view presentScene:gameOverScene transition: reveal];
            }
        }
    }
    else
    {
        [monkey.userData setObject:[NSNumber numberWithInt:(--checkHealth)] forKey:@"Health"];
    }
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    // 1
    SKPhysicsBody *firstBody, *secondBody;
 
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
 
    // 2
    if ((firstBody.categoryBitMask & bananaCategory) != 0 &&
        (secondBody.categoryBitMask & monkeyCategory) != 0)
    {
        [self banana:(SKSpriteNode *) firstBody.node didCollideWithMonkey:(SKSpriteNode *) secondBody.node];
    }
}

@end

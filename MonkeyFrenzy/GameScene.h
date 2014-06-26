//
//  GameScene.h
//
//  Created by Myers on 6/14/14.
//  Copyright (c) Blake Myers All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene

typedef enum monkeyTypes
{
    NORMAL,
    FAT,
    FRENZY
} MonkeyType;

typedef enum modeTypes
{
    EASY_MODE,
    NORMAL_MODE,
    FRENZY_MODE
} ModeType;

-(id)initWithSize:(CGSize)size mode:(ModeType)modePicked;

@end

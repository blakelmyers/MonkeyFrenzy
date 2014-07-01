//
//  GameOverScene.h
//  MonkeyFrenzy
//
//  Created by Myers on 6/14/14.
//  Copyright (c) Blake Myers All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
 
@interface GameOverScene : SKScene
 
-(id)initWithSize:(CGSize)size won:(BOOL)won mode:(ModeType)modePicked score:(int)gameScore;
 
@end

//
//  GCHelper.h
//  MonkeyFrenzy
//
//  Created by Myers on 7/9/14.
//  Copyright (c) Blake Myers All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface GCHelper : NSObject {
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
}

@property (assign, readonly) BOOL gameCenterAvailable;

+ (GCHelper *)sharedInstance;
- (void)authenticateLocalUser;
- (void) reportScore: (int) score forLeaderboardID: (NSString*) identifier;

@end

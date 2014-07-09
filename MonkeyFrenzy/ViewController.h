//
//  ViewController.h
//  MonkeyFrenzy
//
//  Created by Myers on 6/14/14.
//  Copyright (c) Blake Myers All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <iAd/ADBannerView.h>

@interface ViewController : UIViewController <ADBannerViewDelegate>

@property ADBannerView *bannerView;

- (void)hideAd:(NSNotification*)notification;

- (void)showAd:(NSNotification*)notification;

@end

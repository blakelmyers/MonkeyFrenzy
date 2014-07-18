//
//  ViewController.m
//  MonkeyFrenzy
//
//  Created by Myers on 6/14/14.
//  Copyright (c) Blake Myers All rights reserved.
//

#import "ViewController.h"
#import "GameScene.h"
#import "MainMenu.h"

@import AVFoundation;

@interface ViewController ()
@property (nonatomic) AVAudioPlayer * backgroundMusicPlayer;
@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden {return YES;}

-(void)viewDidLoad
{
    self.adLoaded = NO;
    sleep(3);  // allow game center
    _bannerView= [[ADBannerView alloc]initWithFrame:
                  CGRectMake(0, 0, 480, 32)];
    _bannerView.delegate = self;
    [_bannerView setBackgroundColor:[UIColor clearColor]];
    [_bannerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    [self.view addSubview:_bannerView];
    
    
    NSString *notificationNameOff = @"TurnAdsOff";
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(hideAd:)
     name:notificationNameOff
     object:nil];
    
    NSString *notificationNameOn = @"TurnAdsOn";
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(showAd:)
     name:notificationNameOn
     object:nil];
}

-(void)hideAd:(NSNotification*)notification
{
    if(!_bannerView.hidden)
    {
        //_bannerView.hidden = YES;
    }
}

-(void)showAd:(NSNotification*)notification
{
    if(_bannerView.hidden)
    {
        //_bannerView.hidden = NO;
    }
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    NSError *error;
    NSURL * backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"BanjoHop" withExtension:@"mp3"];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer.numberOfLoops = -1;
    [self.backgroundMusicPlayer prepareToPlay];
    [self.backgroundMusicPlayer setVolume:0.4];
    [self.backgroundMusicPlayer play];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    if (!skView.scene) {
        //skView.showsFPS = YES;
        //skView.showsNodeCount = YES;
        
        // Create and configure the scene.
        MainMenu * scene = [MainMenu sceneWithSize:skView.bounds.size];
        
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene.
        [skView presentScene:scene];
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - bannerViewDelegates

-(void)bannerView:(ADBannerView *)banner
didFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"error");
    if (!self.adLoaded)
    {
        _bannerView.hidden = YES;
    }
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad loaded");
    
    self.adLoaded = YES;
}
-(void)bannerViewWillLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad will load");
}
-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
    NSLog(@"Ad did finish");
    
}

@end


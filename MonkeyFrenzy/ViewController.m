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
      SKScene * scene = [MainMenu sceneWithSize:skView.bounds.size];
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

@end

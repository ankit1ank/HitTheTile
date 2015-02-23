//
//  GameMenuLayer.m
//  killshapes
//
//  Created by Ankit Goel on 14/02/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//
@import GoogleMobileAds;
#import "MyAdMobController.h"
#import "SceneManager.h"
#import "GameMenuLayer.h"
#import "GameScene.h"
@implementation GameMenuLayer {
    CCLabelTTF * _readyText;
    CCButton* _score;
    CCButton* _best;
    int tempScore;
    int score;
}


-(void) didLoadFromCCB {
    _readyText.visible = NO;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber * highScore = [defaults objectForKey:@"HighScore"];
    tempScore = [highScore intValue];
    score = [_gameScene getScore];
    _score.title = [NSString stringWithFormat:@"Score: %d",score];
    _best.title = [NSString stringWithFormat:@"Best: %d",tempScore];
}

-(void) shouldPauseGame {
    [_gameScene disableTouch];
    [_gameScene showPopoverNamed:@"PauseMenuLayer"];
}

-(void) applicationWillResignActive:(UIApplication *)application
{
    [_gameScene enableTouch];
    [self shouldPauseGame];
}

-(void) shouldResumeGame {
    [_gameScene enableTouch];
    CCAnimationManager* am = self.animationManager;
    if ([am.runningSequenceName isEqualToString:@"resume game"] == NO) {
        [am runAnimationsForSequenceNamed:@"resume game"];
    }
    _gameScene.userInteractionEnabled = YES;
}

-(void) resumeGameDidEnd {
    [_gameScene removePopover];
}

-(void) shouldRestartGame {
    [SceneManager presentGameScene];
}

-(void) shouldExitGame {
    //Admob show
    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    [[MyAdMobController sharedController] showInterstitialOnViewController:rootViewController];
    
    [SceneManager presentMainMenu];
}

@end

//
//  GameMenuLayer.m
//  killshapes
//
//  Created by Ankit Goel on 14/02/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//
#import "SceneManager.h"
#import "GameMenuLayer.h"
#import "GameScene.h"
@implementation GameMenuLayer


-(void) didLoadFromCCB {
    
}

-(void) shouldPauseGame {
    [_gameScene disableTouch];
    [_gameScene showPopoverNamed:@"PauseMenuLayer"];
}

-(void) applicationWillResignActive:(UIApplication *)application
{
    _gameScene.userInteractionEnabled = NO;
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
    [SceneManager presentMainMenu];
}

@end

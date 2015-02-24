//
//  SceneManager.m
//  killshapes
//
//  Created by Ankit Goel on 14/02/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//
@import GoogleMobileAds;
#import "MyAdMobController.h"
#import "SceneManager.h"

@implementation SceneManager

+(void) presentMainMenu
{
    id s = [CCBReader loadAsScene:@"MainScene"];
    id t = [CCTransition transitionFadeWithDuration:1.0];
    [[CCDirector sharedDirector] presentScene:s withTransition:t];
}

+(void) presentGameScene
{
    // Load ad
    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    [[MyAdMobController sharedController] showInterstitialOnViewController:rootViewController];
    
    id s = [CCBReader loadAsScene:@"GameScene"];
    id t = [CCTransition transitionFadeWithDuration:1.0];
    [[CCDirector sharedDirector] presentScene:s withTransition:t];
}

+(void) presentCredits {
    id s = [CCBReader loadAsScene:@"CreditScene"];
    id t = [CCTransition transitionFadeWithDuration:1.0];
    [[CCDirector sharedDirector] presentScene:s withTransition:t];
}

@end

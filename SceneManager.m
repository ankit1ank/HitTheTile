//
//  SceneManager.m
//  Hit the Tile
//
//  Created by Ankit Goel on 11/02/15.
//  Copyright (c) 2015 Ankit Goel. All rights reserved.
//


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

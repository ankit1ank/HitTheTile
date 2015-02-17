//
//  SceneManager.m
//  killshapes
//
//  Created by Ankit Goel on 14/02/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "SceneManager.h"

@implementation SceneManager

+(void) presentMainMenu
{
    id s = [CCBReader loadAsScene:@"MainScene"];
    id t = [CCTransition transitionMoveInWithDirection:CCTransitionDirectionLeft
                                              duration:1.0];
    [[CCDirector sharedDirector] presentScene:s withTransition:t];
}

+(void) presentGameScene
{
    id s = [CCBReader loadAsScene:@"GameScene"];
    id t = [CCTransition transitionMoveInWithDirection:CCTransitionDirectionRight duration:1.0];
    [[CCDirector sharedDirector] presentScene:s withTransition:t];
}

@end

//
//  CreditScene.m
//  Hit the Tile
//
//  Created by Ankit Goel on 11/02/15.
//  Copyright (c) 2015 Ankit Goel. All rights reserved.
//


#import "CreditScene.h"
#import "SceneManager.h"

@implementation CreditScene
-(void) backButtonPressed {
    [SceneManager presentMainMenu];
}
@end

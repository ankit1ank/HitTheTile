//
//  CreditScene.m
//  killshapes
//
//  Created by Ankit Goel on 20/02/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CreditScene.h"
#import "SceneManager.h"

@implementation CreditScene
-(void) backButtonPressed {
    [SceneManager presentMainMenu];
}
@end

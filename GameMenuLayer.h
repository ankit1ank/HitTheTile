//
//  GameMenuLayer.h
//  Hit the Tile
//
//  Created by Ankit Goel on 11/02/15.
//  Copyright (c) 2015 Ankit Goel. All rights reserved.
//

#import "CCNode.h"
@class GameScene;

@interface GameMenuLayer : CCNode

@property (weak) GameScene* gameScene;
-(void) shouldPauseGame;

@end

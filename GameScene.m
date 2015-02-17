//
//  GameScene.m
//  killshapes
//
//  Created by Ankit Goel on 11/02/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameScene.h"
#import "GameMenuLayer.h"
#include <stdlib.h>

@implementation GameScene {
    CCSprite* _square;
    CCSprite* _circle;
    CCSprite* _triangle;
    int _objectExists;
    double _timeInterval;
    NSUInteger score;
    CCLabelTTF* _scoreLabel;
    __weak GameMenuLayer* _gameMenuLayer;
    __weak GameMenuLayer* _popoverMenuLayer;
    __weak CCNode* _levelNode;
}

-(void) didLoadFromCCB {
    _gameMenuLayer.gameScene = self;
    score = 0;
    _timeInterval = 2;
    _scoreLabel = (CCLabelTTF *)[self getChildByName:@"scoreLabel" recursively:YES];
    _scoreLabel.string = [NSString stringWithFormat:@"Score: %d",score];
    self.userInteractionEnabled = YES;
    

    // Load the shapes and set invisible
    _square = (CCSprite *)[CCBReader load:@"shapes/square"];
    _square.position = ccp(200,200);
    _square.visible = NO;
    _circle = (CCSprite*)[CCBReader load:@"shapes/circle"];
    _circle.position = ccp(320,320);
    _circle.visible = NO;
    _triangle =(CCSprite*)[CCBReader load:@"shapes/triangle"];
    _triangle.position = ccp(100, 100);
    _triangle.visible = NO;
    
    [self addChild:_square];
    [self addChild:_circle];
    [self addChild:_triangle];
    _objectExists = 0;
    [self schedule:@selector(updateAsRequired:) interval:_timeInterval];
}



// Gameplay handling and scoring
-(void) updateAsRequired:(CCTime)delta {
    if (_objectExists == 1)
    {
        _square.visible = NO;
        [self showRandomObject];
    }
    else if (_objectExists == 2)
    {
        _circle.visible = NO;
        [self showRandomObject];
    }
    else if (_objectExists == 3)
    {
        _triangle.visible = NO;
        [self showRandomObject];
    }
    else if (_objectExists == 0)
    {
        [self showRandomObject];
    }
}

-(void) showRandomObject {
    int a = arc4random_uniform(3);
    switch (a)
    {
        case 0:
            // set square
            _objectExists = 1;
            _square.position = ccp(arc4random_uniform(518), arc4random_uniform(280));
            _square.visible = YES;
            break;
        case 1:
            //set circle
            _objectExists = 2;
            _circle.position = ccp(arc4random_uniform(518), arc4random_uniform(280));
            _circle.visible = YES;
            break;
        case 2:
            //set triangle
            _objectExists = 3;
            _triangle.position = ccp(arc4random_uniform(518), arc4random_uniform(280));
            _triangle.visible = YES;
            break;
        default:
            // This should never happen
            [NSException raise:@"Check Switch Statement" format:@"Switch Statement GameScene class"];
            break;
    }
}

-(void) touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    if (self.userInteractionEnabled) {
        CGPoint touchLocation = [touch locationInNode:self];
        if (CGRectContainsPoint(_square.boundingBox, touchLocation)) {
            _square.visible = NO;
            score += 10;
            _scoreLabel.string = [NSString stringWithFormat:@"Score: %d",score];
        } else if (CGRectContainsPoint(_circle.boundingBox, touchLocation)){
            _circle.visible = NO;
            score += 10;
            _scoreLabel.string = [NSString stringWithFormat:@"Score: %d",score];
        } else if (CGRectContainsPoint(_triangle.boundingBox, touchLocation)){
            _triangle.visible = NO;
            score += 10;
            _scoreLabel.string = [NSString stringWithFormat:@"Score: %d",score];
        }
        else {
            score -= 10;
            _scoreLabel.string = [NSString stringWithFormat:@"Score: %d",score];
        }
    }
}

// Menu buttons and interface

-(void) showPopoverNamed:(NSString *)name {
    if (_popoverMenuLayer==nil) {
        GameMenuLayer* newMenuLayer = (GameMenuLayer*)[CCBReader load:name];
        [self addChild:newMenuLayer];
        
        _popoverMenuLayer = newMenuLayer;
        _popoverMenuLayer.gameScene = self;
        
        _gameMenuLayer.visible = NO;
        _levelNode.paused = YES;
    }
}

-(void) removePopover {
    if (_popoverMenuLayer) {
        [_popoverMenuLayer removeFromParent];
        _popoverMenuLayer = nil;
        
        _gameMenuLayer.visible = YES;
        _levelNode.paused = NO;
    }
}

// Enabling and disabling touch for pause menu
-(void) enableTouch {
    self.userInteractionEnabled = YES;
}
-(void) disableTouch {
    self.userInteractionEnabled = NO;
}



@end

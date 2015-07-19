//
//  GameScene.m
//  Hit the Tile
//
//  Created by Ankit Goel on 11/02/15.
//  Copyright (c) 2015 Ankit Goel. All rights reserved.
//

#import "GameScene.h"
#import "GameMenuLayer.h"
#include <stdlib.h>
#import "ABGameKitHelper.h"


@implementation GameScene {
    // Shapes declaration
    __weak CCSprite* _square;
    __weak CCSprite* _circle;
    __weak CCSprite* _triangle;
    
    // Gameover Animation variables
    __weak CCNode* _missShot;
    __weak CCNode* _tooLate;
    
    int _objectExists;
    double _timeInterval;
    int score,hei,wid,tempScore;
    
    __weak CCButton* _scoreLabel;
    __weak GameMenuLayer* _gameMenuLayer;
    __weak GameMenuLayer* _popoverMenuLayer;
    __weak CCNode* _levelNode;
    __weak CCLabelTTF* _highScoreLabel;
}

-(void) didLoadFromCCB {
    
    // High score property list initialization
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber * highScore = [defaults objectForKey:@"HighScore"];
    tempScore = [highScore intValue];
    score = 0;
    
    _scoreLabel = (CCButton *)[self getChildByName:@"scoreLabel" recursively:YES];
    _scoreLabel.title = [NSString stringWithFormat:@"Score: %d",score];
    self.userInteractionEnabled = YES;
    _highScoreLabel.string = [NSString stringWithFormat:@"Best: %d",tempScore];
    
    _timeInterval = 1;
    CGSize s = [CCDirector sharedDirector].viewSize;
    hei = s.height - 90;
    wid = s.width - 50;
    
    // Used for showing menus
    _gameMenuLayer.gameScene = self;
    
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
    
    // Setup for gameover animations
    _missShot = (CCNode*)[self getChildByName:@"missShot" recursively:YES];
    _tooLate = (CCNode*)[self getChildByName:@"tooLate" recursively:YES];
    _missShot.visible = NO;
    _tooLate.visible = NO;
    
    [self schedule:@selector(updateAsRequired:) interval:_timeInterval];
}

-(void) controlUpdate {
    
    // This method controls difficulty of the game
    
    _timeInterval = 0.45 + [self genIntervalSmall];
    
    if (score < 5) {
        _timeInterval = 0.9 + [self genInterval];
    }else if (score < 10) {
        _timeInterval = 0.8 + [self genInterval];
    } else if (score < 15) {
        _timeInterval = 0.7 + [self genInterval];
    } else if (score < 50) {
        _timeInterval = 0.5 + [self genInterval];
    }

    
    
    [self unschedule:@selector(updateAsRequired:)];
    
    // Uncomment below for testing time duration
    //NSLog(@"Time interval is: %f",_timeInterval);
    
    [self schedule:@selector(updateAsRequired:) interval:_timeInterval];
}

-(double) genInterval {
    double a = arc4random_uniform(4);
    a = a/10;
    return a;
}

-(double) genIntervalSmall {
    double a = arc4random_uniform(3);
    a = a/10;
    return a;
}

// Gameplay handling and scoring
-(void) updateAsRequired:(CCTime)delta {
    if (_objectExists == 0)
    {
        [self showRandomObject];
        [self controlUpdate];
    } else {
        self.userInteractionEnabled = NO;
        
        //Play sound
        [[OALSimpleAudio sharedInstance] playEffect:@"sound/wrong.wav"];
        
        // Show the message too late
        _square.visible = NO;
        _triangle.visible = NO;
        _circle.visible = NO;
        _tooLate.visible = YES;
        [_tooLate.animationManager runAnimationsForSequenceNamed:@"lateAnimation"];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSNumber * updateScore = [NSNumber numberWithInt:score];
        [defaults setObject:updateScore forKey:@"Score"];
        [defaults synchronize];

        // Save high score
        if (score > tempScore) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSNumber * updateHighScore = [NSNumber numberWithInt:score];
            [defaults setObject:updateHighScore forKey:@"HighScore"];
            [defaults synchronize];
            // Send highscore to leaderboard
            [[ABGameKitHelper sharedHelper] reportScore:score forLeaderboard:@"in.ankitgoel.TapTheTile.HighScores"];
            _highScoreLabel.string = [NSString stringWithFormat:@"Best: %d",score];
        }
        // Load gameover popup later so animation can finish
        [self performSelector:@selector(delayGameOverPopup) withObject:nil afterDelay:0.5 ];
    }
}

-(void) showRandomObject {
    int a = arc4random_uniform(3);
    switch (a)
    {
        case 0:
            // set square
            _objectExists = 1;
            _square.position = ccp(arc4random_uniform(wid), arc4random_uniform(hei));
            _square.visible = YES;
            break;
        case 1:
            //set circle
            _objectExists = 2;
            _circle.position = ccp(arc4random_uniform(wid), arc4random_uniform(hei));
            _circle.visible = YES;
            break;
        case 2:
            //set triangle
            _objectExists = 3;
            _triangle.position = ccp(arc4random_uniform(wid), arc4random_uniform(hei));
            _triangle.visible = YES;
            break;
        default:
            // This should never happen
            [NSException raise:@"Check Switch Statement" format:@"Switch Statement GameScene class"];
            break;
    }
}

// This method handles the user touches.
-(void) touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    if (self.userInteractionEnabled) {
        CGPoint touchLocation = [touch locationInNode:self];
        if (CGRectContainsPoint(_square.boundingBox, touchLocation) && _square.visible == YES) {
            [[OALSimpleAudio sharedInstance] playEffect:@"sound/tone-beep.wav"];
            _square.visible = NO;
            _objectExists = 0;
            score += 1;
            _scoreLabel.title = [NSString stringWithFormat:@"Score: %d",score];
        } else if (CGRectContainsPoint(_circle.boundingBox, touchLocation) && _circle.visible == YES){
            [[OALSimpleAudio sharedInstance] playEffect:@"sound/tone-beep.wav"];
            _circle.visible = NO;
            _objectExists = 0;
            score += 1;
            _scoreLabel.title = [NSString stringWithFormat:@"Score: %d",score];
        } else if (CGRectContainsPoint(_triangle.boundingBox, touchLocation) && _triangle.visible == YES){
            [[OALSimpleAudio sharedInstance] playEffect:@"sound/tone-beep.wav"];
            _triangle.visible = NO;
            _objectExists = 0;
            score += 1;
            _scoreLabel.title = [NSString stringWithFormat:@"Score: %d",score];
        }
        else {
            // Unschedule the update method so tooLate animation does not start
            [self unschedule:@selector(updateAsRequired:)];
            
            //Play sound
            [[OALSimpleAudio sharedInstance] playEffect:@"sound/wrong.wav"];
            
            _square.visible = NO;
            _triangle.visible = NO;
            _circle.visible = NO;
            // Missed shot animation
            _missShot.visible = YES;
            [_missShot.animationManager runAnimationsForSequenceNamed:@"missAnimation"];
            
            
            self.userInteractionEnabled = NO;
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSNumber * updateScore = [NSNumber numberWithInt:score];
            [defaults setObject:updateScore forKey:@"Score"];
            [defaults synchronize];
            // Save highscore
            if (score > tempScore) {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSNumber * updateHighScore = [NSNumber numberWithInt:score];
                [defaults setObject:updateHighScore forKey:@"HighScore"];
                [defaults synchronize];
                // Send highscore to leaderboard
                [[ABGameKitHelper sharedHelper] reportScore:score forLeaderboard:@"in.ankitgoel.TapTheTile.HighScores"];
                _highScoreLabel.string = [NSString stringWithFormat:@"Best: %d",score];
            }
            [self performSelector:@selector(delayGameOverPopup) withObject:nil afterDelay:0.5 ];
        }
    }
}

// Delay gameover popup so animation can complete
-(void) delayGameOverPopup {
    [self showPopoverNamed:@"GameOverMenuLayer"];
}

// Menu buttons and interface

-(void) showPopoverNamed:(NSString *)name {
    
    // load menu
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

-(int) getScore {
    return score;
}

// Enabling and disabling touch for pause menu
-(void) enableTouch {
    self.userInteractionEnabled = YES;
}
-(void) disableTouch {
    self.userInteractionEnabled = NO;
}

// Pauses game when game is suspended during gameplay

-(void) applicationWillResignActive:(UIApplication *)application
{
    [_gameMenuLayer shouldPauseGame];
}

@end

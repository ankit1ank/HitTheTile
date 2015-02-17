#import "MainScene.h"

@implementation MainScene

-(void) playButtonPressed {
    CCScene* scene = [CCBReader loadAsScene:@"GameScene"];
    CCTransition* transition = [CCTransition transitionFadeWithDuration:1.2];
    [[CCDirector sharedDirector] presentScene:scene withTransition:transition];
}

@end

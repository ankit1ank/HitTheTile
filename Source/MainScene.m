#import "MainScene.h"
#import "SceneManager.h"

@implementation MainScene

-(void) playButtonPressed {
    [SceneManager presentGameScene];
}

-(void) creditsButtonPressed {
    [SceneManager presentCredits];
}

@end

#import "MainScene.h"
#import "SceneManager.h"


#import "ABGameKitHelper.h"

@implementation MainScene

-(void) didLoadFromCCB {
    [ABGameKitHelper sharedHelper];
}

-(void) playButtonPressed {
    [SceneManager presentGameScene];
}

-(void) creditsButtonPressed {
    [SceneManager presentCredits];
}

-(void) showLeaderboard {
    // Uncomment the line below and set the leaderboard id to implement leaderboards in app
    //[[ABGameKitHelper sharedHelper] showLeaderboard:@"com.whatever.your.leaderboard"];
}

@end

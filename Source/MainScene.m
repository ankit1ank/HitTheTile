#import "MainScene.h"
#import "SceneManager.h"

@import GoogleMobileAds;
#import "MyAdMobController.h"
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

-(void) highScoreButtonPressed {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber * highScore = [defaults objectForKey:@"HighScore"];
    NSLog(@"High Score: %@",highScore);
}
@end

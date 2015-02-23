#import "MainScene.h"
#import "SceneManager.h"

@import GoogleMobileAds;
#import "MyAdMobController.h"

@implementation MainScene

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

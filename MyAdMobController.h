
//  Created by MrCapone
//  Copyright (c) Lukyanov D. M. All rights reserved.
//

#define MY_INTERSTITIAL_ID @"ca-app-pub-4823077198226744/9476121516"
#define MY_BANNER_ID @"ca-app-pub-4823077198226744/7999388316"

#import <Foundation/Foundation.h>
@import GoogleMobileAds;
//#import "GADInterstitial.h"
//#import "GADBannerView.h"
//#import "GADRequest.h"

@protocol MyAdMobControllerDelagate <NSObject>

- (void)MyInterstitialDidDismissScreen:(GADInterstitial *)ad;
- (void)MyInterstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error;
- (void)MyInterstitialNotLoaded;

- (void)MyAdViewDidReceiveAd:(GADBannerView *)view;
- (void)MyAdView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error;

@end

@interface MyAdMobController : NSObject <GADInterstitialDelegate, GADBannerViewDelegate>
{
    GADInterstitial *interstitial_;
    GADBannerView *bannerView_;
}

@property (nonatomic, strong) id delegate;

+ (MyAdMobController *)sharedController;
- (void)loadInterstitial;
- (void)loadBannerView;
- (void)showInterstitialOnViewController:(UIViewController *)viewController;
- (void)addBannerToView:(UIView *)view;

@end

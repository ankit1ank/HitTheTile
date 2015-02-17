//
//  GameScene.h
//  killshapes
//
//  Created by Ankit Goel on 11/02/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface GameScene : CCNode
-(void) disableTouch;
-(void) enableTouch;
-(void) showPopoverNamed:(NSString*) popoverName;
-(void) removePopover;
@end

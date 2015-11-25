//
//  VoicePaoPaoView.h
//  CYKJ_APP
//
//  Created by 徐继垚 on 15/11/18.
//  Copyright © 2015年 Sunny土. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TripGestureRecognizer;
@protocol VoicePaoPaoViewDelegate;
@class AVAudioPlayer;

@interface VoicePaoPaoView : UIView

@property(nonatomic, assign) id<VoicePaoPaoViewDelegate>delegate;

@property(nonatomic, retain) AVAudioPlayer *player;
@property(nonatomic, retain) NSMutableArray *imageArray;

@property(nonatomic, retain) NSString *voicePath;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property (weak, nonatomic) IBOutlet UIImageView *voiceAnn;

@property (weak, nonatomic) IBOutlet UIImageView *voiceImageView;
@end

@protocol VoicePaoPaoViewDelegate <NSObject>



- (void)paopaoView:(VoicePaoPaoView *)paoPaoView didTapView:(UIImageView *)view gesture:(TripGestureRecognizer *)gestureRecognizer;

@end
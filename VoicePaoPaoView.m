//
//  VoicePaoPaoView.m
//  CYKJ_APP
//
//  Created by 徐继垚 on 15/11/18.
//  Copyright © 2015年 Sunny土. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "VoicePaoPaoView.h"
#import "TripGestureRecognizer.h"
#import <objc/runtime.h>
static char VOICEPATHKEY;

@implementation VoicePaoPaoView
-(void)setVoicePath:(NSString *)voicePath {
    
    objc_setAssociatedObject(self, &VOICEPATHKEY, voicePath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    

     self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:voicePath] error:nil];
    [_player prepareToPlay];
    self.timeLabel.text = [NSString stringWithFormat:@"%.0f''"  ,  self.player.duration];
    
}
-(NSString *)voicePath {
    return objc_getAssociatedObject(self, &VOICEPATHKEY);
}


- (void)awakeFromNib {

    self.imageArray = [NSMutableArray array];
    _voiceImageView.userInteractionEnabled = YES;
    TripGestureRecognizer * tap = [[TripGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
    [_voiceImageView addGestureRecognizer:tap];




}

- (void)gestureAction:(TripGestureRecognizer *)gestureAction {

    if ([self.delegate respondsToSelector:@selector(paopaoView:didTapView:gesture:)]) {
        
        [self.delegate paopaoView:self didTapView:(UIImageView*)gestureAction.view gesture:gestureAction];
        
    }
    if (self.voicePath) {

    
            NSError * error;
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
//
//            self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:self.voicePath] error:&error];
//
            [self.player play];

            if (error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NoTitleAlert(@"发生未知错误!");
                });
            }


        [self animanPlay];
        
        [NSTimer scheduledTimerWithTimeInterval:self.player.duration target:self selector:@selector(animStop) userInfo:nil repeats:NO];
        


    } else {
        [self animanPlay];

        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(animStop) userInfo:nil repeats:NO];

    }








}
-(void)animanPlay
{


  if (_imageArray.count == 0) {
      for (int i = 1; i < 4; i++) {

          UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"voicesend%d.png" , i]];
          [_imageArray addObject:image];

      }
  }



    //设置动画数组
    [_voiceAnn setAnimationImages:_imageArray];
    //设置动画时常
    [_voiceAnn setAnimationDuration:0.7];
    //开始动画
    [_voiceAnn startAnimating];

}
-(void)animStop {
    [_voiceAnn stopAnimating];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

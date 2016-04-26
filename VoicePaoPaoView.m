//
//  VoicePaoPaoView.m
//  CYKJ_APP
//
//  Created by 徐继垚 on 15/11/18.
//  Copyright © 2015年 Sunny土. All rights reserved.
//


#import "VoicePaoPaoView.h"
#import <AVFoundation/AVFoundation.h>
#import "TripGestureRecognizer.h"
#import <objc/runtime.h>

static char VOICEPATHKEY;
static char VOICEURLKEY;

@interface VoicePaoPaoView()

@end

@implementation VoicePaoPaoView
-(void)setVoicePath:(NSString *)voicePath {
    
    objc_setAssociatedObject(self, &VOICEPATHKEY, voicePath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    

   AVAudioPlayer * player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:voicePath] error:nil];
    [player prepareToPlay];
    self.timeLabel.text = [NSString stringWithFormat:@"%.0f''"  ,  player.duration];
    
}
-(NSString *)voicePath {
    return objc_getAssociatedObject(self, &VOICEPATHKEY);
}
-(void)setVoiceUrl:(NSString *)voiceUrl {
    
    objc_setAssociatedObject(self, &VOICEURLKEY, voiceUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    AVPlayer * player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:voiceUrl]];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%.0f''" ,CMTimeGetSeconds(player.currentItem.duration)];
    
}
-(NSString *)voiceUrl {
    return objc_getAssociatedObject(self, &VOICEURLKEY);
}

- (void)awakeFromNib {

   
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
            self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:self.voicePath] error:&error];
//
            [self.player play];

            if (error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NoTitleAlert(@"发生未知错误!");
                });
            }


        [self animanPlay];
        
        [NSTimer scheduledTimerWithTimeInterval:self.player.duration target:self selector:@selector(animStop) userInfo:nil repeats:NO];
        


    } else if(self.voiceUrl){
        
        NSError * error;
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
        //
        self.avPlayer = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:self.voiceUrl]];
        [self.avPlayer play];
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NoTitleAlert(@"发生未知错误!");
            });
        }
        
        [self animanPlay];
        
        [NSTimer scheduledTimerWithTimeInterval:CMTimeGetSeconds(self.avPlayer.currentItem.duration) target:self selector:@selector(animStop) userInfo:nil repeats:NO];
        
        
          }else {
              [self animanPlay];
              
              [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(animStop) userInfo:nil repeats:NO];
            
    }








}



-(void)animanPlay
{
    
    NSMutableArray * imageArray ;
    if ([self.delegate respondsToSelector:@selector(imageArryForPaopaoView:)] ){
         imageArray  = [self.delegate imageArryForPaopaoView:self];
    }else {
        
        imageArray = [NSMutableArray array];
    }

  if (imageArray.count == 0) {
      for (int i = 1; i < 4; i++) {

          UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"voicesend%d.png" , i]];
          [imageArray addObject:image];

      }
  }



    //设置动画数组
    [_voiceAnn setAnimationImages:imageArray];
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

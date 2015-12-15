# RecoderView



语音气泡  使用简单


要使用动画跟随语音时间显示请给voicePath赋值


    self.reacordImageView.voicePath = xxxxx;
    
要更换动画图片  请使用代理方法

      - (NSMutableArray *)imageArryForPaopaoView:(VoicePaoPaoView *)paopaoView {
    
           NSMutableArray * array = [NSMutableArray array];
                for (int i = 1; i < 4; i++) {
                 UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"voicesendb%d.png" , i]];
                  [array addObject:image];
             }
             return array;
        }
        
点击view代理方法 可以处理其他
      - (void)paopaoView:(VoicePaoPaoView *)paoPaoView didTapView:(UIImageView *)view gesture:(TripGestureRecognizer                *)gestureRecognizer 

不赋值 默认动画3秒  动画图片白色

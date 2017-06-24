//
//  EdgeTopics.m
//  百思不得姐
//
//  Created by Edge on 2017/4/27.
//  Copyright © 2017年 Leon. All rights reserved.
//


#import "EdgeTopics.h"
#import "NSDate+EdgeExtention.h"
#import <MJExtension.h>



@implementation EdgeTopics{
    CGFloat _cellHeight;
    CGRect _pictureViewFream;
}
//  告诉字典转模型服务器里面的key对应是哪个key
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    NSMutableDictionary *dict  =[NSMutableDictionary dictionary];
  
    dict[@"imageurl"]=@"image1";
    dict[@"gif"]=@"is_gif";
    return dict;
}

-(NSString *)create_time{
    //  获取当前时间
    // NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *creatTime = [fmt dateFromString:_create_time];
    // 设置时间
    if (creatTime.isThisYear) {//  今年
        
        if (creatTime.isToday) {
            
            NSDateComponents *cmps = [[NSDate date]dateFrom:creatTime];
            if(cmps.hour>=1){
                // 大于等于一小时
                return [NSString stringWithFormat:@"%zd小时以前",cmps.hour];
            }else if (cmps.minute>=1){
                //  一小时以内
                return [NSString stringWithFormat:@"%zd分钟以前",cmps.minute];
            }else{
                //  一分钟以内
                return @"刚刚";
            }
        }else if (creatTime.isYesterday){
            //  昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:creatTime];
        
        }else{
            //  其它时间
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:creatTime];
        }
    }else{//  不是今年
        return _create_time;
    }
    return @"时间不合法";
}

//  计算cell高度
-(CGFloat)cellHeight{
    /*  ======================cellHeight为空进行计算====================*/
    if (!_cellHeight) {
        
// 头像高度+底部工具条高度+帖子内容高度+各部分间距
    CGFloat labelW = ScreenWidth-3*cellWidthmargin;//  label宽度
    CGSize maxSize = CGSizeMake(labelW, MAXFLOAT);//最大高度
    CGFloat labelH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size.height;
    
    CGFloat worldcellH = labelH+cellimageHeigit+cellToolBarHeight+cellAllMargin+cellWidthmargin;
        
    /*  显示的图片大小等于图片先压缩到cell要显示的宽度后再进行等比例压缩；
     原始高度：H         原始宽度：W
     显示高度：h         显示宽度：w
     W/H=w/h   -> h = Hw/W
     */
        //  判断类型
        switch (self.type) {
                
                case EdgeTopicAll:
                
                 break;
                //  图片
                case EdgeTopicPicture:
            {
                //  计算图片高度
                CGFloat pictureW = (ScreenWidth - 3*cellWidthmargin);
                CGFloat pictureH = self.height/self.width *pictureW;
                CGFloat pictureX =cellWidthmargin;
                CGFloat pictureY =cellimageHeigit+cellAllMargin+labelH;
                
                //  图片帖子高度
                if(pictureH>=EdgeMaxPictureH){//大图
                    self.BigPicture = YES;
                    pictureH = EdgeDefaultPictureH;
                    
                }
                _pictureViewFream = CGRectMake(pictureX, pictureY, pictureW, pictureH);
                
                CGFloat pictureTopich = worldcellH + pictureH;
                //  图片cell高度(文字帖子高度+图片+间距)
                _cellHeight = pictureTopich+cellWidthmargin;
            }
                break;
                //  声音
                case EdgeTopicVoice:
            {
                //  计算声音fream
                CGFloat voiceW = (ScreenWidth - 3*cellWidthmargin);
                CGFloat voiceH = self.height/self.width *voiceW;
                CGFloat voiceX =cellWidthmargin;
                CGFloat voiceY =cellimageHeigit+cellAllMargin+labelH;
                _voiceViewFream = CGRectMake(voiceX, voiceY, voiceW, voiceH);
                  CGFloat voiceTopicH = worldcellH + voiceH;
                
                _cellHeight = voiceTopicH + cellWidthmargin;

            }
                 break;
                //  视频
                case EdgeTopicVedio:
            {
                //  计算声音fream
                CGFloat vedioW = (ScreenWidth - 3*cellWidthmargin);
                CGFloat vedioH = self.height/self.width *vedioW;
                CGFloat vedioX =cellWidthmargin;
                CGFloat vedioY =cellimageHeigit+cellAllMargin+labelH;
                _VedioViewFream = CGRectMake(vedioX, vedioY, vedioW, vedioH);
                CGFloat vedioTopicH = worldcellH + vedioH;
                
                _cellHeight = vedioTopicH + cellWidthmargin;
            }
                break;
                
            case EdgeTopicWord:
               //  段子cell高度
                _cellHeight = worldcellH;
                break;

            default:
                break;
        }
    }

    return _cellHeight;
}

@end

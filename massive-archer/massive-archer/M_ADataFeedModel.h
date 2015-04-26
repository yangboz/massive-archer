//
//  M-ADataFeedModel.h
//  massive-archer
//
//  Created by yangboz on 14-5-4.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "M_ADataFeedVO.h"

@interface M_ADataFeedModel : NSObject
+(M_ADataFeedModel *)sharedInstance;

//DataFeedVOs
-(NSMutableArray *)getDataFeedVOs;
-(void)setDataFeedVOs:(NSMutableArray *)value;

@end

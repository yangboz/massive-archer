//
//  JsonParseProxy.h
//  MasterDetailer
//
//  Created by zhou Yangbo on 13-2-21.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "M_ADataFeedModel.h"
#import "M_ADataFeedVO.h"

@interface JsonParseProxy : NSObject
{}
//
-(void) parseJsonFile:(NSString *)path;
-(void) parseJsonUrl:(NSString *)uri;
@end

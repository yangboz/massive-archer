//
//  JsonParseProxy.m
//  MasterDetailer
//
//  Created by zhou Yangbo on 13-2-21.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "JsonParseProxy.h"

@implementation JsonParseProxy

-(void)parseJsonFile:(NSString *)path
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:path ofType:@"json"];
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    NSData *fileData = [fileHandle readDataToEndOfFile];
    [fileHandle closeFile];
    //
    [self parseJsonRawData:fileData];
}
-(void)parseJsonUrl:(NSString *)uri
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:uri]];
    NSURLResponse *response;
    NSError *error;
    NSData *jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //
    [self parseJsonRawData:jsonData];
}

-(void) parseJsonRawData:(NSData *)rawData
{
    NSDictionary *jsonKitData = [rawData objectFromJSONData];
    // Pretend like you've called a REST service here and it returns a string.
    // We'll just create a string from the sample json constant at the top
    // of this file.
    NSString *jsonKitStr = [jsonKitData JSONString];
    //    NSLog(@"string from JSONKit: \n%@", jsonKitStr);
    // 1) Create a dictionary, from the result string,
    // using JSONKit's NSString category; objectFromJSONString.
    NSError *error;
    id rawDataParsed = [jsonKitStr objectFromJSONStringWithParseOptions:JKParseOptionNone error:&error];
    //
    if ( error != nil ) {
        // evaluate the error and handle appropriately
    }
    //
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    //
    if ( [rawDataParsed isKindOfClass:[NSDictionary class]] ) {
        // process dictionary
    }
    else if ( [rawDataParsed isKindOfClass:[NSArray class]] ) {
        // process array
        NSLog(@"rawDataParsed count:%d",[rawDataParsed count]);
        //
        for (int i=0; i<[rawDataParsed count]; i++) {
            NSArray *array = [(NSArray *)rawDataParsed objectAtIndex:i];
            NSLog(@"array[%d]:%d",i,[array count]);
            M_ADataFeedVO *vo = [[M_ADataFeedVO alloc] init];
            //
            vo.latitude = [array objectAtIndex:0];
            vo.longitude = [array objectAtIndex:1];
            vo.title = [array objectAtIndex:2];
            //
            [mutableArray insertObject:vo atIndex:i];
        }
    }
    else {
        // someting else happened, 'rawData' is likely 'nil'
        // handle appropriately
    }
  
    // 5) Model store
    [[M_ADataFeedModel sharedInstance] setDataFeedVOs:mutableArray];
}
@end

//
//  ViewController.m
//  JiaMi
//
//  Created by Yuanhai on 23/1/17.
//  Copyright © 2017年 Yuanhai. All rights reserved.
//

#import "ViewController.h"

#define EncodeMoveCount 5

// 用户基本信息
#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define UserInfo_Plist [NSString stringWithFormat:@"%@/UserInfo_Plist.png", DOCUMENTS_FOLDER]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"home_widget.jpg" ofType:@""];
    [self fileEncode:filePath];
    
    NSData *newData = [self fileDecode:UserInfo_Plist];
    [newData writeToFile:[NSString stringWithFormat:@"%@/UserInfo_Plist111.png", DOCUMENTS_FOLDER] atomically:NO];
    NSLog(@"filePath:%@", DOCUMENTS_FOLDER);
}

// 加密
- (void)fileEncode:(NSString *)filePath
{
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    // 循环左移动
    NSMutableData *newData = [NSMutableData data];
    for (int f = 0; f < fileData.length ; f++)
    {
        NSInteger moveTo = f + EncodeMoveCount;
        if (moveTo > fileData.length - 1)
        {
            moveTo = moveTo - fileData.length;
        }
        [newData appendData:[fileData subdataWithRange:NSMakeRange(moveTo, 1)]];
    }
    
    [newData writeToFile:UserInfo_Plist atomically:NO];
}

// 解密
- (NSData *)fileDecode:(NSString *)filePath
{
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    // 循环右移动
    NSMutableData *newData = [NSMutableData data];
    for (int f = 0; f < fileData.length ; f++)
    {
        NSInteger moveTo = f - EncodeMoveCount;
        if (moveTo < 0)
        {
            moveTo = fileData.length + moveTo;
        }
        [newData appendData:[fileData subdataWithRange:NSMakeRange(moveTo, 1)]];
    }
    
    return newData;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

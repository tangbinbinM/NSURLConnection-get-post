//
//  ViewController.m
//  NSURLConnection-POST请求
//
//  Created by YiGuo on 2017/10/30.
//  Copyright © 2017年 tbb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 1.请求路径
    NSURL *url = [NSURL URLWithString:@"http://www.xxx.com/login"];
    
    // 2.创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 更改请求方法,默认为get
    request.HTTPMethod = @"POST";
    // 设置请求体
    request.HTTPBody = [@"username=test007&pwd=123456" dataUsingEncoding:NSUTF8StringEncoding];
    // 设置超时(5秒后超时)
    request.timeoutInterval = 5;
    // 设置请求头,没有特殊要求不用设置
    //    [request setValue:@"iOS 9.0" forHTTPHeaderField:@"User-Agent"];
    // 3.发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            if (connectionError) { // 比如请求超时
                NSLog(@"----请求失败");
            } else {
                NSLog(@"------%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

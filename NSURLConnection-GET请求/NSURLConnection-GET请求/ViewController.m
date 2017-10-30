//
//  ViewController.m
//  NSURLConnection-GET请求
//
//  Created by YiGuo on 2017/10/30.
//  Copyright © 2017年 tbb. All rights reserved.
//

#import "ViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
@interface ViewController ()<NSURLConnectionDataDelegate>
//用来存放服务器返回的数据
@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation ViewController
- (NSMutableData *)responseData
{
    if (!_responseData) {
        _responseData = [NSMutableData data];
    }
    return _responseData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self delegateAysnc];
}
//代理请求
- (void)delegateAysnc{
    //1.创建请求的URL
    NSURL *url = [NSURL URLWithString:@"http://c.m.163.com/nc/auto/districtcode/list/440100/0-20.html"];
    //2.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //3.创建连接对象
//    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //startImmediately:参数为YES不用启动
//    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
//    [conn start];
    //取消
//    [conn cancel];
    [NSURLConnection connectionWithRequest:request delegate:self];
}
#pragma mark - <NSURLConnectionDataDelegate> -- being
//接收到服务器的响应
- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response{
    NSLog(@"didReceiveResponse服务器响应");
}
//接收到服务器的数据（如果数据量比较大，这个方法会被调用多次）
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data{
    [self.responseData appendData:data];
    NSLog(@"didReceiveData-- %zd",data.length);
}
//服务器的数据成功接收完毕
- (void)connectionDidFinishLoading:(NSURLConnection*)connection{
    NSLog(@"connectionDidFinishLoading");
    NSString *str = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
    NSLog(@"str:%@",str);
    self.responseData = nil;
}
//请求失败（比如请求超时）
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError");
}
#pragma mark - <NSURLConnectionDataDelegate> -- end

//发送异步请求
-(void)async{
    //1.创建请求的URL
    NSURL *url = [NSURL URLWithString:@"http://c.m.163.com/nc/auto/districtcode/list/440100/0-20.html"];
    //2.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //3.发送异步请求
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        // 请求完毕会来到这个block
        // 3.解析服务器返回的数据（解析成字符串）
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", string);
    }];
}
//发送同步请求
- (void)sync{
    //1.创建请求的URL
    NSURL *url = [NSURL URLWithString:@"http://c.m.163.com/nc/auto/districtcode/list/440100/0-20.html"];
    //2.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 2.发送请求
    // sendSynchronousRequest阻塞式的方法，等待服务器返回数据
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    // 3.解析服务器返回的数据（解析成字符串）
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"requestData:%@",string);
}
//URL中汉字的处理
- (void)get
{
    // 0.请求路径
    NSString *urlStr = @"http://www.xxx.com/login?username=用户名&pwd=520it";
    // 将中文URL进行转码
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 1.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2.发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // 3.解析服务器返回的数据（解析成字符串）
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", string);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

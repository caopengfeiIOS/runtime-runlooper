//
//  ViewController.m
//  runlooper
//
//  Created by hbgl on 17/2/28.
//  Copyright © 2017年 cpf. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//**    **//
@property (strong, nonatomic) dispatch_source_t timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
//****************************  GCD 定时器   ***********************//
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self timer2];
    /*
     第一个参数：source的类型DISPATCH_SOURCE_TYPE_TIMER 表示定时器
     第二个参数：描述信息
     第三个参数：详细的描述信心
     第四个参数：队列。决定定时器中的任务在那个线程执行
     */
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    /*
     第一个参数：定时器对象
     第二个参数：起始时间
     第三个参数：间隔时间
     第四个参数：精准度0
     */
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
       
        NSLog(@"GCD＝＝＝＝%@", [NSThread currentThread]);
    });
    dispatch_resume(timer);
    self.timer = timer;
  }









//****************************  runloop   ***********************//
-(void)runStart
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self timer2];
    });

}
-(void)timer
{
   NSTimer * timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    //添加定时器到runloor中,指定runloop的运行模式为默认模式
    // UITrackingRunLoopMode 界面追踪模式 对界面拖拽模式运星
    //NSDefaultRunLoopMode 拖拽时停止
    //NSRunLoopCommonModes 占位模式 ＝UITrackingRunLoopMode＋NSDefaultRunLoopMode
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    
}
-(void)timer2
{
    //该方法自动添加到runloop，运行模式为默认模式
    NSRunLoop * loop = [NSRunLoop currentRunLoop];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    [loop run];
}
-(void)run
{
    NSLog(@"run====%@======%@",[NSThread currentThread],[NSRunLoop currentRunLoop].currentMode);
}
-(void)test
{
    //创建主线程的runloop
    NSRunLoop * mainloop = [NSRunLoop mainRunLoop];
    
    //2.获取当前的runloop
    NSRunLoop * currenloop = [NSRunLoop currentRunLoop];
    //3.core
    NSLog(@"%@",CFRunLoopGetMain());
    NSLog(@"%@",CFRunLoopGetCurrent());
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

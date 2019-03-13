//
//  ViewController.m
//  ZPCache
//
//  Created by 赵鹏 on 2019/3/13.
//  Copyright © 2019 赵鹏. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSCacheDelegate>

@property (nonatomic, strong) NSCache *cache;

@end

@implementation ViewController

/**
 NSCache类和字典类差不多，下面是关于NSCache类的部分源码：
 
 @property (nullable, assign) id<NSCacheDelegate> delegate;
 
 - (nullable ObjectType)objectForKey:(KeyType)key;  //取值
 - (void)setObject:(ObjectType)obj forKey:(KeyType)key; // 0 cost  //设置
 - (void)setObject:(ObjectType)obj forKey:(KeyType)key cost:(NSUInteger)g;  //设置
 - (void)removeObjectForKey:(KeyType)key;  //删除
 
 - (void)removeAllObjects;  //删除
 
 @property NSUInteger totalCostLimit;    // limits are imprecise/not strict  //设置成本上限（设置一共可以缓存多少张图片）
 @property NSUInteger countLimit;    // limits are imprecise/not strict  //缓存数量上限
 @property BOOL evictsObjectsWithDiscardedContent;  //自动移除上限
 
 @end
 */
#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.cache = [[NSCache alloc] init];
    
    //设置成本上限
    self.cache.countLimit = 10;
    
    self.cache.delegate = self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSInteger count = 20;
    
    for (NSInteger i = 0; i < count; i++)
    {
        NSString *str = [@"zhangsan" stringByAppendingFormat:@"%zd", i];
        
        [self.cache setObject:str forKey:@(i)];
        
        NSLog(@"增加 %@", [self.cache objectForKey:@(i)]);
    }
}

#pragma mark ————— 点击“显示缓存”按钮 —————
- (IBAction)showCache:(id)sender
{
    for (NSInteger i = 0; i < 20; i++)
    {
        id obj = [self.cache objectForKey:@(i)];
        NSLog(@"-----%@", obj);
    }
}

#pragma mark ————— NSCacheDelegate —————
//当设置了成本上限以后每增加一个成本上限之外的内容就要先删除一个之前的。
- (void)cache:(NSCache *)cache willEvictObject:(id)obj
{
    NSLog(@"删除 %@", obj);
}

@end

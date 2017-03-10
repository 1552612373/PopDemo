//
//  ViewController.m
//  PopTest
//
//  Created by yang on 2017/3/10.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "ViewController.h"
#import "YCTableViewCell.h"

static NSString *cellIdentifier = @"HLWCell";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIView *redView; // 小滑块

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *dataArr; // tableView数据源

@end

@implementation ViewController
{
    BOOL _isRedBackgroundColor;
    BOOL _isPopFrame;
    BOOL _isScaleX;
    BOOL _isDown;
    BOOL _isRotation;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*
     pop facebook出品  不同于Core Animation只能基于layer，它可以让任意继承自Object对象使用
     此demo仅限于向新手展示或简单使用，更多基本知识补充请自行Google
     */
    
    
    /*
     View Properties (视图属性的罗列)
     kPOPViewAlpha
     kPOPViewBackgroundColor
     kPOPViewBounds
     kPOPViewCenter
     kPOPViewFrame
     kPOPViewScaleXY
     kPOPViewSize
     */
    
    
    /*
     Layer Properties (层属性的罗列)
     kPOPLayerBackgroundColor
     kPOPLayerBounds
     kPOPLayerScaleXY
     kPOPLayerSize
     kPOPLayerOpacity
     kPOPLayerPosition
     kPOPLayerPositionX
     kPOPLayerPositionY
     kPOPLayerRotation
     kPOPLayerBackgroundColor
     */
    
    // 仅仅举几个栗子
    
    self.dataArr = [NSArray arrayWithObjects:
                    @"kPOPViewAlpha (POPBasicAnimation)",
                    @"kPOPViewBackgroundColor (POPBasicAnimation)",
                    @"kPOPViewFrame (POPBasicAnimation)",
                    @"kPOPLayerRotation (POPBasicAnimation)",
                    @"kPOPViewBounds (POPSpringAnimation)",
                    @"kPOPViewCenter (POPSpringAnimation)",
                    @"kPOPViewScaleXY (POPSpringAnimation)",
                    @"kPOPLayerPositionY (POPDecayAnimation)",
                    nil];
    [self setupUI];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, SScreenWidth, SScreenHeight-20) style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"YCTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    
    // 小滑块
    self.redView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    self.redView.backgroundColor = [UIColor redColor];
    _isRedBackgroundColor = YES;
    self.redView.userInteractionEnabled = NO;
    self.redView.alpha = 0.6;
    [self.view addSubview:_redView];
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    // kPOPViewAlpha (POPBasicAnimation)
    if(indexPath.row == 0)
    {
        // 1. Pick a Kind Of Animation 选择一种动画方式
        //  POPBasicAnimation  POPSpringAnimation POPDecayAnimation
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
        if(self.redView.alpha >= 0.6)
        {
            anim.fromValue = @(0.6);
            anim.toValue = @(0.3);
        }
        else
        {
            anim.fromValue = @0.3;
            anim.toValue = @0.6;
        }
        [self.redView pop_addAnimation:anim forKey:@"fade"];
    }
    
    // kPOPViewBackgroundColor (POPBasicAnimation)
    if(indexPath.row == 1)
    {
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewBackgroundColor];
        if(_isRedBackgroundColor)
        {
            anim.fromValue = [UIColor redColor];
            anim.toValue = [UIColor greenColor];
            _isRedBackgroundColor = NO;
        }
        else
        {
            anim.fromValue = [UIColor greenColor];
            anim.toValue = [UIColor redColor];
            _isRedBackgroundColor = YES;
        }
        [self.redView pop_addAnimation:anim forKey:@"backgroundColor"];
    }
    
    
    // kPOPViewFrame (POPBasicAnimation)
    if(indexPath.row == 2)
    {
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
        if(_isPopFrame)
        {
            anim.toValue = [NSValue valueWithCGRect:CGRectMake(100, 200, 100, 100)];
            _isPopFrame = NO;
        }
        else
        {
            anim.toValue = [NSValue valueWithCGRect:CGRectMake(50, 50, 200, 200)];
            _isPopFrame = YES;
        }
        [self.redView pop_addAnimation:anim forKey:@"frame"];
    }
    
    
    // kPOPLayerRotation (POPBasicAnimation)
    if(indexPath.row == 3)
    {
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
        if(_isRotation)
        {
            // 停止旋转
            [self.redView.layer pop_removeAllAnimations];
            _isRotation = NO;
            return;
        }
        
        anim.toValue = @(M_PI*10);
        anim.repeatCount = 1000;
        anim.duration = 20;
        [self.redView.layer pop_addAnimation:anim forKey:@"rotation"];
        _isRotation = YES;
    }
    
    // kPOPViewBounds (POPSpringAnimation)
    if(indexPath.row == 4)
    {
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBounds];
        if(self.redView.bounds.size.width == 100)
        {
            anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
        }
        else
        {
            anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)];
        }
        anim.springBounciness = 20.f;
        anim.springSpeed = 10.f;
        [self.redView pop_addAnimation:anim forKey:@"bounds"];
    }
    
    // kPOPViewCenter (POPSpringAnimation)
    if(indexPath.row == 5)
    {
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        if(self.redView.center.x == 150)
        {
            anim.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 400)];
        }
        else
        {
            anim.toValue = [NSValue valueWithCGPoint:CGPointMake(150, 250)];
        }
        [self.redView pop_addAnimation:anim forKey:@"center"];
    }
    
    
    
    // kPOPViewScaleX  kPOPViewScaleY (POPSpringAnimation)
    if(indexPath.row == 6)
    {
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleX];
        if(_isScaleX)
        {
            anim.toValue=[NSValue valueWithCGSize:CGSizeMake(1, 1)];
            _isScaleX = NO;
        }
        else
        {
            anim.toValue=[NSValue valueWithCGSize:CGSizeMake(2, 1)];
            _isScaleX = YES;
        }
        anim.springBounciness = 10.f;
        anim.springSpeed = 10.f;
        [self.redView pop_addAnimation:anim forKey:@"scale"];
    }
    
    
    // kPOPLayerPositionY (POPDecayAnimation)
    if(indexPath.row == 7)
    {
        POPDecayAnimation *anim = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        if(_isDown)
        {
            _isDown = NO;
            anim.velocity = @(400);
        }
        else
        {
            _isDown = YES;
            anim.velocity = @(-400);
        }
        //            anim.deceleration = 0.998;
        [self.redView.layer pop_addAnimation:anim forKey:@"scale"];
    }
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

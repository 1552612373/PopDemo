//
//  YCTableViewCell.m
//  PopTest
//
//  Created by yang on 2017/3/10.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "YCTableViewCell.h"

@implementation YCTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    
    dispatch_async(globalQueue, ^{
        
        if(selected)
        {
            POPSpringAnimation *selectAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
            selectAnim.toValue = [NSValue valueWithCGSize:CGSizeMake(1.05, 1.05)];
            selectAnim.springBounciness = 10.f;
            selectAnim.springSpeed = 20;
            [self.textLabel pop_addAnimation:selectAnim forKey:@"selectAnim"];
            selectAnim.completionBlock = ^(POPAnimation *pop , BOOL myBool){
                
                POPSpringAnimation *selectAnim2 = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
                selectAnim2.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0, 1.0)];
                selectAnim2.springBounciness = 10.f;
                selectAnim2.springSpeed = 10;
                [self.textLabel pop_addAnimation:selectAnim2 forKey:@"selectAnim2"];
                
                
            };
            
            
            NSLog(@"selected");
        }
        else
        {
            
            
            
            
            NSLog(@"not");
        }
    });
}

@end

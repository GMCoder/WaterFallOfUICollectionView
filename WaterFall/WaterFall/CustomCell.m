//
//  CustomCell.m
//  WaterFall
//
//  Created by Gaoming on 16/9/11.
//
//

#import "CustomCell.h"

@implementation CustomCell

- (void)layoutSubviews
{
    [self.contentView addSubview:self.iv];
    _iv.backgroundColor = [UIColor whiteColor];
}

- (UIImageView *)iv
{
    if (!_iv) {
        _iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    }
    return _iv;
}

@end

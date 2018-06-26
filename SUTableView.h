//
//  SUTableView.h
//  GoldPigApp
//
//  Created by Office on 2018/4/3.
//  Copyright © 2018年 MiYIN.COM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUTableViewInterceptor.h"
@interface SUTableView : UITableView
@property(nonatomic,strong)SUTableViewInterceptor *dataSourceInterceptor;
@property(nonatomic)NSInteger actualRows;
@end

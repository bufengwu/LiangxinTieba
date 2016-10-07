//
//  LTPersonalViewController.m
//  LiangxinTieba
//
//  Created by mac on 2016/9/27.
//  Copyright © 2016年 XYD. All rights reserved.
//

#import "LTPersonalViewController.h"

@interface LTPersonalViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * functionsTableVert;
@property (nonatomic, strong) UIScrollView * functionsTableHorz;

@property (nonatomic, strong) UIView * userInfoView;

@property (nonatomic, strong) NSArray * imgArr;
@property (nonatomic, strong) NSArray * labelArr;
@property (nonatomic, strong) NSDictionary * userMsg;
@end

@implementation LTPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"Personal Center", nil);

    [self.view addSubview:self.userInfoView];
    [self.view addSubview:self.functionsTableVert];
    [self.view addSubview:self.functionsTableHorz];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void) changeAccount {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录" message:@"请输入用户名密码" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"用户名";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"密码";
        textField.secureTextEntry = YES;
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *login = alertController.textFields.firstObject;
        UITextField *password = alertController.textFields.lastObject;
        NSLog(@"%@,%@",login.text,password.text);
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}


#pragma mark 视图控件的getter方法
- (UIView *) userInfoView {
    if (!_userInfoView) {
        
        UIView * userView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
        userView.backgroundColor = RGB(20, 155, 213);
        
        UIImageView * face = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"person_face"]];
        face.backgroundColor = [UIColor whiteColor];
        face.center = userView.center;
        face.layer.cornerRadius = face.bounds.size.width/2;
        face.layer.masksToBounds = YES;
        face.layer.borderColor = [UIColor blackColor].CGColor;
        face.layer.borderWidth = 3;
        [userView addSubview:face];
        
        NSString * name = @"王硌碧";
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.text = name;
        [nameLabel setFont:[UIFont systemFontOfSize:25]];
        [nameLabel sizeToFit];
        
        nameLabel.center = CGPointMake(SCREEN_WIDTH/2, (userView.frame.size.height+face.frame.origin.y + face.frame.size.height)/2);
        
        [userView addSubview:nameLabel];
        
        UIButton * button = [[UIButton alloc]init];
        [button setTitle:@"切换账号" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button sizeToFit];
        button.center = CGPointMake(SCREEN_WIDTH - button.frame.size.width/2 - 10, STATUS_BAR_HEIGHT + 20);
        [button addTarget:self action:@selector(changeAccount) forControlEvents:UIControlEventTouchUpInside];
        [userView addSubview:button];
        _userInfoView = userView;
    }
    return _userInfoView;
}

//竖向的表格，承载多种预设功能
- (UITableView *) functionsTableVert {
    if (!_functionsTableVert) {
        UITableView * tableveiw = [[UITableView alloc]initWithFrame:CGRectMake(0, 350, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        
        [self.view addSubview:tableveiw];
        tableveiw.dataSource = self;
        tableveiw.delegate =self;
        tableveiw.bounces = NO;
        tableveiw.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        self.imgArr = @[@"person_article",@"person_reply",@"person_collect",@"person_setting"];
        self.labelArr = @[@"我的帖子",@"回复我的",@"收藏",@"设置"];
        
        self.userMsg = @{@"userFace":@"person_face", @"userName":@"王硌碧", @"signature":@"请设置签名"};
        self.view.layer.contents = (id)([UIImage imageNamed:@"table_background"].CGImage);
        [tableveiw setBackgroundColor:[UIColor clearColor]];
        _functionsTableVert = tableveiw;
    }
    return _functionsTableVert;
}

//横向的表格，承载热更的功能
- (UIScrollView *)functionsTableHorz {
    if (!_functionsTableHorz) {
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0 , 260, SCREEN_WIDTH, 80)];
        scrollView.backgroundColor = [UIColor grayColor];
        
        NSArray * horzFuncInfos = @[
                                    @{@"func_icon":@"person_func_notice",
                                      @"func_name":NSLocalizedString(@"my notice", nil),
                                      @"func_target":@"person_func_notice"
                                      },
                                    @{@"func_icon":@"person_func_fans",
                                      @"func_name":NSLocalizedString(@"my fans", nil),
                                      @"func_target":@"person_func_fans"
                                      },
                                    @{@"func_icon":@"person_func_message",
                                      @"func_name":NSLocalizedString(@"message", nil),
                                      @"func_target":@"person_func_message"
                                      }
                                    ];
        
        for (int i = 0; i < horzFuncInfos.count; i++) {
            UIButton * funcButton = [[UIButton alloc]initWithFrame:CGRectMake(5 + i * (150 + 5), 5, 150, 70)];
            funcButton.backgroundColor = [UIColor greenColor];
            funcButton.layer.cornerRadius = 10;
            funcButton.layer.borderColor = [UIColor orangeColor].CGColor;
            funcButton.layer.borderWidth = 3;
            funcButton.titleLabel.font = [UIFont systemFontOfSize:11];
            
            UIImage * image = [UIImage imageNamed: horzFuncInfos[i][@"func_icon"]];
            NSString *titleStr = horzFuncInfos[i][@"func_name"] ;
            
            [funcButton setTitle: titleStr forState:UIControlStateNormal];
            [funcButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
            CGSize strSize = [titleStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-10, SCREEN_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : funcButton.titleLabel.font} context:nil].size;
            [funcButton setImage:image forState:UIControlStateNormal];
            
            funcButton.titleEdgeInsets = UIEdgeInsetsMake(0.5*image.size.height, -0.5*image.size.width, -0.5*image.size.height, 0.5*image.size.width);
            funcButton.imageEdgeInsets =UIEdgeInsetsMake(-0.5*strSize.height, 0.5*strSize.width, 0.5*strSize.height, -0.5*strSize.width);
            
            [scrollView addSubview:funcButton];
        }
        scrollView.contentSize = CGSizeMake(horzFuncInfos.count * (150 + 5) + 5*2, 70); //指定宽高，使其为横向滚动
        scrollView.contentOffset = CGPointMake(10, 0);   //指定视图初始停留位置
        //scrollView.pagingEnabled = YES; //按页滚动，总是一次一个宽度，或一个高度单位的滚动
        scrollView.bounces = NO;    //关闭回弹效果
        _functionsTableHorz = scrollView;
    }
    return _functionsTableHorz;
}

#pragma mark tableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.labelArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {

            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableSampleIdentifier];
            NSUInteger row = [indexPath row];
            cell.imageView.image = [UIImage imageNamed:self.imgArr[row]];
            cell.textLabel.text = self.labelArr[row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    else {
        while ([cell.contentView.subviews lastObject ]!=nil) {
            [(UIView*)[cell.contentView.subviews lastObject]removeFromSuperview];
        }
    }
    return cell;
}

@end

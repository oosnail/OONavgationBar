//
//  ViewController.m
//  test
//
//  Created by ztc on 16/9/21.
//  Copyright © 2016年 ZTC. All rights reserved.
//

#import "ViewController.h"
#import "HJDashLineView.h"
#import "UINavigationBar+ooExtension.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isNavgationbarHidden;
}
@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) UINavigationStatus vcstatus;
@property (nonatomic, assign)CGFloat marginTop;

@end

@implementation ViewController

- (id)initWithUINavigationStatus:(UINavigationStatus)status{
    self = [super init];
    if (self) {
        _vcstatus = status;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped ];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    
    
    //navbar
    
//    self.edgesForExtendedLayout = UIRectEdgeAll;
//    self.extendedLayoutIncludesOpaqueBars = NO;
    if(_vcstatus == UINavigationStatusNomal){
        [self.navigationController.navigationBar oo_setStatusBarBackgroundViewColor:[[UIColor whiteColor] colorWithAlphaComponent:1]];
        [self.navigationController.navigationBar oo_setNavigationBarBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1]];
        self.navigationController.navigationBar.tintColor = [UIColor redColor];
        self.title= @"正常navgationbar";
        
    }else     if(_vcstatus == UINavigationStatusAlpha){
        self.title= @"透明navgationbar";
        
//        [self.navigationController.navigationBar oo_setStatusBarBackgroundViewColor:[[UIColor whiteColor] colorWithAlphaComponent:0]];
        
        [self.navigationController.navigationBar oo_setNavigationBarBackgroundAlpha:0];
        [self.navigationController.navigationBar oo_setStatusBarBackgroundViewAlpha:0];
        
        
//        [self.navigationController.navigationBar oo_setNavigationBarBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0]];

        self.navigationController.navigationBar.tintColor = [UIColor redColor];

    }
    else     if(_vcstatus == UINavigationStatusHiden){
        [self.navigationController.navigationBar oo_setStatusBarBackgroundViewColor:[[UIColor whiteColor] colorWithAlphaComponent:1]];
        [self.navigationController.navigationBar oo_setNavigationBarBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1]];
        self.navigationController.navigationBar.tintColor = [UIColor redColor];
        self.title=   @"消失的navgationbar";
    }

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:(BOOL)animated];
    [self.navigationController.navigationBar oo_restoreNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if(_vcstatus == UINavigationStatusAlpha){
//        [self.navigationController.navigationBar oo_setStatusBarBackgroundViewColor:[[UIColor whiteColor] colorWithAlphaComponent:0]];
        CGFloat offsetY = self.tableView.contentOffset.y;
        CGFloat newoffsetY = offsetY + self.marginTop;
        if(_vcstatus == UINavigationStatusAlpha){
            [self setnvagationbarAlpha:newoffsetY];
            [self.navigationController.navigationBar oo_setStatusBarBackgroundViewColor:[[UIColor whiteColor] colorWithAlphaComponent:0]];
        }else if (_vcstatus == UINavigationStatusHiden) {
//            [self setnvagationbaroffset:newoffsetY];
        }
    }

    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    CGFloat offsetY = self.tableView.contentOffset.y;
    CGFloat newoffsetY = offsetY + self.marginTop;
    if(_vcstatus == UINavigationStatusAlpha){
        [self setnvagationbarAlpha:newoffsetY];
    }
    else if(_vcstatus == UINavigationStatusHiden){
        [self setnvagationbaroffset:newoffsetY];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.marginTop != scrollView.contentInset.top) {
        self.marginTop = scrollView.contentInset.top;
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat newoffsetY = offsetY + self.marginTop;

    if(_vcstatus == UINavigationStatusAlpha){
        [self setnvagationbarAlpha:newoffsetY];
    }
    else if(_vcstatus == UINavigationStatusHiden){
        [self setnvagationbaroffset:newoffsetY];
    }
}

- (void)setnvagationbarAlpha:(CGFloat)newoffsetY{
    if(newoffsetY  <= 60){
        [self.navigationController.navigationBar oo_setStatusBarBackgroundViewColor:[[UIColor whiteColor] colorWithAlphaComponent:0]];
    }else  if ( newoffsetY <= 150) {
        [self.navigationController.navigationBar oo_setStatusBarBackgroundViewColor:[[UIColor whiteColor] colorWithAlphaComponent:newoffsetY/150]];


    }else if (newoffsetY > 150){
        [self.navigationController.navigationBar oo_setStatusBarBackgroundViewColor:[[UIColor whiteColor] colorWithAlphaComponent:1]];


    }

}

- (void)setnvagationbaroffset:(CGFloat)newoffsetY{
    if (newoffsetY >= 100 && newoffsetY <= 200) {
        [self.navigationController.navigationBar oo_translationNavigationBarVerticalWithOffsetY:- (newoffsetY-100)/100.0*64];
//        self.navigationController.navigationBar.tintColor = [[UIColor whiteColor]colorWithAlphaComponent:1-newoffsetY/100];
        
    }else if (newoffsetY <100){
        [self.navigationController.navigationBar oo_translationNavigationBarVerticalWithOffsetY:0];
//        self.navigationController.navigationBar.tintColor = [[UIColor whiteColor]colorWithAlphaComponent:1];
        
    }else{
        [self.navigationController.navigationBar oo_translationNavigationBarVerticalWithOffsetY:-64];
//        self.navigationController.navigationBar.tintColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
    }
}




#pragma mark- TableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.contentView.backgroundColor = [UIColor yellowColor];
    }
    NSString *context = @"";
    if(indexPath.row%3 == 0){
        context= @"正常navgationbar";
    }else     if(indexPath.row%3  == 1){
        context= @"透明navgationbar";;
    }
    else     if(indexPath.row%3  == 2){
        context=   @"消失的navgationbar";
    }
    cell.textLabel.text = context;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UINavigationStatus status =  UINavigationStatusNomal;
    if(indexPath.row%3 == 0){
        status = UINavigationStatusNomal;
    }else     if(indexPath.row%3 == 1){
        status = UINavigationStatusAlpha;
    }
    else     if(indexPath.row%3 == 2){
        status = UINavigationStatusHiden;
    }
    ViewController *vc = [[ViewController alloc]initWithUINavigationStatus:status];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)extendedLayoutBar:(BOOL)yesOrNo
{
    if (yesOrNo) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    else {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = YES;
    }
}


@end

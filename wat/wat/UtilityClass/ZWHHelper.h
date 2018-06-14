//
//  ZWHHelper.h
//  wat
//
//  Created by 123 on 2018/6/6.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WatTabBarController.h"
#import <Foundation/Foundation.h>
@class ZWYCheckUserfaceInfoReponseModel;
typedef void(^blurHideBlockBlock)(void);
typedef void(^alertClickBlock)(int clickInt);
typedef void(^alertActionSheetClickBlock)(int clickInt, NSString *message);

@interface ZWHHelper : NSObject
+ (instancetype)sharedHelper;
+ (WatTabBarController *)rootTabbarViewController;
- (void)addBlurViewToView:(UIView *)toView frame:(CGRect)blurFrame withHideBlock:(blurHideBlockBlock)hide animated:(BOOL)animated;
- (void)hideClearView;
- (void)addClearViewToView:(UIView *)toView;
- (void)addAlertViewControllerToView:(UIViewController *)toView withClickBlock:(alertClickBlock)clickBlock title:(NSString *)title content:(NSString *)content cancleStr:(NSString *)cancleStr confirmStr:(NSString *)confirmStr;
//- (void)addAlertViewControllerToView:(UIView *)toView withClickBlock:(alertClickBlock)clickBlock title:(NSString *)title content:(NSString *)content cancleStr:(NSString *)cancleStr confirmStr:(NSString *)confirmStr animated:(BOOL)animated blurEnable:(BOOL)enable;
- (void)hideBlurAnimated:(BOOL)animated;

+ (NSString *)getStringReplaceColonWithSpace:(NSString *)originalStr;//获取navTitle
- (void)startCountWithButton:(UIButton *)btn;//验证码倒计时
- (void)stopTime;
- (void)loginUser;//用户登录
- (BOOL)isLogin;//判断用户是否已登录
- (void)textFileDeleate:(UITextField *)textFiled;

-(void)initButton:(UIButton*)btn;//实现 btn 图片在上文字在下的方法

- (void)alertActionSheet:(NSArray *)messages withClickBlock:(alertActionSheetClickBlock)clickBlock;
- (void)alertActionSheet:(NSArray *)messages AndView:(UIViewController *)view withClickBlock:(alertActionSheetClickBlock)clickBlock;

- (void)addCsrzNoneViewToView:(UIView *)view message:(NSString *)message;//添加没有数据提示
- (void)removeNoneView;//移除没有数据提示
- (BOOL )intervalFromLastDate:(NSString *) dateString2;//当前时间差 (yes 已超时)（no未超时）验证码是否超时
- (void)showImageInspectViewWithUrlArray:(NSArray *)imageArray withSourceViews:(NSArray *)sourceView clickView:(UIView *)clickView; //查看大图
@property (nonatomic, assign) BOOL blurEnable;


@property (nonatomic, strong) NSMutableDictionary *assectDic;

@property (nonatomic, strong) NSMutableArray *danbaoInfos;
- (void)Message:(NSString *)message;//添加界面提示信息
+ (NSString *)timeStampWithString:(NSString *)dateStr format:(NSString *)format;
- (BOOL)isPhoneByMobileNum:(NSString *)mobileNum;//手机正则表达式
- (BOOL) isIdentityCard: (NSString *)identityCard;//身份正则表达式

//计算文字所占宽度
- (CGSize)getSizeByString:(NSString*)string AndFontSize:(CGFloat)font;
//计算文字所占高度
- (CGSize)getHeightByString:(NSString*)string AndFontSize:(CGFloat)font AndWidth:(CGFloat)width;
//拨打电话
- (void)callUpByphone:(NSString *)phone;
#pragma mark - //图片点击事件
-(void)tapimageByImage:(NSString *)imageURL;
- (void)uprenzhengInfo;//更新认证状态信息
- (void)updateUserInfo;//更新用户信息
- (void)uprenzhengInfo:(alertClickBlock)bolck;
- (ZWYCheckUserfaceInfoReponseModel *)getUserInfo;//获取用户信息
- (void )rimeDifferenceByTime:(NSString *)time and:(UILabel *)label AndisZiChanBao:(BOOL)isZip;
- (void)updateRenZhengInfoByType:(NSString *)type;//获取认证全部信息

- (void)buttonSelectBy:(UIViewController *)Controller AndButton:(UIButton *)button;
- (NSString *)md5:(NSString *)input ;//MD5加密

- (UIButton *)textEndView;

- (void)endbuttonAction:(alertClickBlock)clickBlock;
@property (nonatomic, copy) void (^btnSelectIndex)(NSInteger integer);
@end


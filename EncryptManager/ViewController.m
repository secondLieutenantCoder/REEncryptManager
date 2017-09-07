//
//  ViewController.m
//  EncryptManager
//
//  Created by fcrj on 2017/9/7.
//  Copyright © 2017年 heshanwangluo. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"
#import <CommonCrypto/CommonDigest.h>

@interface ViewController ()<
UITextViewDelegate
>
@property (weak, nonatomic) IBOutlet UITextField *originTF;
@property (weak, nonatomic) IBOutlet UITextView *secretedTV;

@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.secretedTV.delegate = self;
    
    self.secretedTV.layer.borderWidth = 0.6;
    
    self.secretedTV.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.secretedTV.layer.cornerRadius = 10;
    
    /**
    * 同样只能监听 编辑状态的值改变，不能改变赋值时的值改变
    */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChangedExt:) name:UITextViewTextDidChangeNotification object:nil];
    
    /// KVO 监听textview的值改变，包括赋值的情况
    // 同时监听新旧值
    [self.secretedTV addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld context:nil];
    
}
#pragma mark - KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{

    if ([keyPath isEqualToString:@"text"]) {
        
        NSLog(@"po");
        NSString * new = change[@"new"];
        
        if (new.length == 0) {
            self.placeHolderLabel.hidden = NO;
        }else{
            self.placeHolderLabel.hidden = YES;
        }
    }
}
-(void)dealloc{

    [self.secretedTV removeObserver:self forKeyPath:@"text"];
}


- (IBAction)sha1Action:(id)sender {
    
    if (self.originTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请填写明文"];
    }else{
    
        NSString * sha1Str = [self getSha1Str:nil];
        
        self.secretedTV.text = sha1Str;
        
    }
}
#pragma mark - sha1加密方法
- (NSString *) getSha1Str:(NSString *) srcString{

    srcString = self.originTF.text;
    
    const char *cstr = [self.originTF.text cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    /**
     * int 强制转换 有类型冲突
     * wangwei
     */
    CC_SHA1(data.bytes, (int)data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH *2];
    
    for(int i =0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        
        [result appendFormat:@"%02x", digest[i]];
        
    }
    return result;
}

- (IBAction)sha156Action:(id)sender {
    if (self.originTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请填写明文"];
    }else{
    
        NSString * sha256Str = [self getSha256Str:nil];
        
        self.secretedTV.text = sha256Str;
        
    }
}
#pragma mark - sha256加密
-(NSString * ) getSha256Str:(NSString * )srcString{

    srcString = self.originTF.text;
    
    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (int)data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH *2];
    
    for(int i =0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        
        [result appendFormat:@"%02x", digest[i]];
        
    }
    return result;
}

- (IBAction)sha384Action:(id)sender {
    if (self.originTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请填写明文"];
    }else{
        NSString * sha384Str = [self getSha384Str:nil];
        self.secretedTV.text = sha384Str;
    }
}
#pragma mark - sha284加密
-(NSString * )getSha384Str:(NSString * )srcString{

    srcString = self.originTF.text;
    
    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
    
    uint8_t digest[CC_SHA384_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (int)data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA384_DIGEST_LENGTH *2];
    
    for(int i =0; i < CC_SHA384_DIGEST_LENGTH; i++) {
        
        [result appendFormat:@"%02x", digest[i]];
        
    }
    return result;
}

- (IBAction)sha512Action:(id)sender {
    if (self.originTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请填写明文"];
    }else{
    
        NSString * sha512Str = [self getSha512Str:nil];
        self.secretedTV.text = sha512Str;
    }
    
}
#pragma mark - sha512加密
-(NSString *) getSha512Str:(NSString *)srcString{

    srcString = self.originTF.text;
    
    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
    
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA512(data.bytes, (int)data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH *2];
    
    for(int i =0; i < CC_SHA512_DIGEST_LENGTH; i++)
        
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}

- (IBAction)MD515Action:(id)sender {
    if (self.originTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请填写明文"];
    }
    
}
- (IBAction)MD532Action:(id)sender {
    if (self.originTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请填写明文"];
    }else{
    
        NSString * md5Str = [self getMD532Str:nil];
        self.secretedTV.text = md5Str;
    }
    
}
#pragma mark - MD5加密
-(NSString * )getMD532Str:(NSString *) srcString{

    srcString = self.originTF.text;
    
    const char *cStr = [srcString UTF8String];
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5( cStr, (int)strlen(cStr), digest );
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH *2];
    
    for(int i =0; i < CC_MD5_DIGEST_LENGTH; i++)
        
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    self.placeHolderLabel.hidden = YES;
    
    return YES;
}


#pragma makr - 监听开始编辑textview
- (void)textViewDidEndEditing:(UITextView *)textView{

    if (textView.text.length == 0) {
        
        self.placeHolderLabel.hidden = NO;
        
    }
}


#pragma mark - 通知中心监听值改变的方法（不好使）
- (void) textChangedExt:(NSNotification *)notifi{

    if (self.secretedTV.text == 0) {
        self.placeHolderLabel.hidden = NO;
    }else{
        self.placeHolderLabel.hidden = YES;
    }
}
/**
 * 编辑时，能够监听到值改变事件
 * 给textview赋值时，监听不到。
 */
#pragma mark - textview值改变监听
- (void)textViewDidChange:(UITextView *)textView{

    if (textView.text.length == 0) {
        self.placeHolderLabel.hidden = NO;
    }else{
        self.placeHolderLabel.hidden = YES;
    }
    
    if (textView.markedTextRange ==nil) {
        NSLog(@"changed");
    }else{
    
        NSLog(@"changed");
    }
}

 
@end

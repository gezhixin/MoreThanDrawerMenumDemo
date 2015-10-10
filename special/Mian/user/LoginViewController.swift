//
//  LoginViewController.swift
//  special
//
//  Created by 葛枝鑫 on 15/4/17.
//  Copyright (c) 2015年 葛枝鑫. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var userAndPasswordContentView: UIView!
    
    var loginSuccessBlock: ((user: UserModel)->Void)? = nil
    
    //重写Init方法，加载xib文件
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?, loginSuccess:(user: UserModel)->Void) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.loginSuccessBlock = loginSuccess
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userAndPasswordContentView.setCornerRadius(4)
        self.userAndPasswordContentView.setBorder(0x4CD193, width: 2)
        loginBtn.setCornerRadius(4)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBAction func closeBtnClicked(sender: UIButton) {
        self.view.endEditing(true)  
        self.dismissViewControllerAnimated(true, completion: { () -> Void in })
    }
    
    
    @IBAction func loginBtnClicked(sender: UIButton) {
        self.view.endEditing(true)
        self.loginRequest();
    }
    func loginRequest() {
        let name: String = self.user.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let password = self.password.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        WebClient.Login(name: name, passwd: password, sucess: { (user) -> Void in
            print(user)
            if self.loginSuccessBlock != nil {
                self.view.endEditing(true)
                self.dismissViewControllerAnimated(true, completion: { () -> Void in })
                self.loginSuccessBlock!(user: user)
            }
        }) { (code, msg) -> Void in
            print("error ---> \(msg!)(\(code))")
        }
    }
}


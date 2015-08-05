//
//  LoginViewController.swift
//  rapidOs
//
//  Created by André Carvalho on 07/04/15.
//  Copyright (c) 2015 André Carvalho. All rights reserved.
//

import UIKit

//Extensão de UITextField para Padding
extension UITextField {
    func setTextLeftPadding(left:CGFloat) {
        let leftView:UIView = UIView(frame: CGRectMake(0, 0, left, 1))
        leftView.backgroundColor = UIColor.clearColor()
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewMode.Always;
    }
}


class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtUsuario: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnUrl: UIButton!
    @IBOutlet weak var imgLogo: UIImageView!
    
    //Variável para saber se teclado Esta Visivel
    var tecladoVisivel : Bool = false
    
    //Variáveis para armazenar as Imagens do TextField
    var imageViewUser = UIImageView()
    var imageUser = UIImage(named: "imgUser")
    var imageViewUserW = UIImageView()
    var imageUserW = UIImage(named: "imgUserW")
    var imageViewSenha = UIImageView()
    var imageSenha = UIImage(named: "imgPass")
    var imageViewSenhaW = UIImageView()
    var imageSenhaW = UIImage(named: "imgPassW")
    
    //Loading
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
    let mensagens = ["Entrar","Verificando credenciais...","Falha na autenticação","Acesso autorizado"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Mudar cor da Barra de Status
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIApplication.sharedApplication().statusBarHidden = false
        
        //Cor de Fundo do Botao Login
        self.btnLogin.backgroundColor = UIColor.orangeColor()
        
        //Bordas Arredondadas do Botao
        btnLogin.layer.cornerRadius = 5
        
        //Cores dos UITextField
        self.txtUsuario.backgroundColor = UIColor.clearColor()
        self.txtUsuario.textColor = UIColor.whiteColor()
        self.txtUsuario.tintColor = UIColor.orangeColor()
        self.txtSenha.backgroundColor = UIColor.clearColor()
        self.txtSenha.textColor = UIColor.whiteColor()
        self.txtSenha.tintColor = UIColor.orangeColor()
        //Cor do Placeholder
        let phUsuario = NSAttributedString(string: "Usuário", attributes: [NSForegroundColorAttributeName : UIColor.grayColor()])
        self.txtUsuario.attributedPlaceholder = phUsuario;
        let phSenha = NSAttributedString(string: "Senha", attributes: [NSForegroundColorAttributeName : UIColor.grayColor()])
        self.txtSenha.attributedPlaceholder = phSenha;
        
        //Barra Apenas Abaixo do UITextField
        //txtUsuario
        let borderUsuario = CALayer()
        let widthUsuario = CGFloat(1.0)
        borderUsuario.borderColor = UIColor.grayColor().CGColor
        borderUsuario.frame = CGRect(x: 0, y: txtUsuario.frame.size.height - widthUsuario, width: txtUsuario.frame.size.width, height: txtUsuario.frame.size.height)
        borderUsuario.borderWidth = widthUsuario
        borderUsuario.cornerRadius = 1
        txtUsuario.layer.addSublayer(borderUsuario)
        txtUsuario.layer.masksToBounds = true
        //txtSenha
        let borderSenha = CALayer()
        let widthSenha = CGFloat(1.0)
        borderSenha.borderColor = UIColor.grayColor().CGColor
        borderSenha.frame = CGRect(x: 0, y: txtSenha.frame.size.height - widthSenha, width: txtSenha.frame.size.width, height: txtSenha.frame.size.height)
        borderSenha.borderWidth = widthSenha
        borderSenha.cornerRadius = 1
        txtSenha.layer.addSublayer(borderSenha)
        txtSenha.layer.masksToBounds = true
        
        //Imagem a Esquerda do TextView
        //txtUsuario
        //Imagem Cinza
        imageViewUser.frame = CGRect(x: 0, y: 0, width: 30, height: 18)
        imageViewUser.image = imageUser
        imageViewUser.contentMode = UIViewContentMode.Center
        //Imagem Branca
        imageViewUserW.frame = CGRect(x: 0, y: 0, width: 30, height: 18)
        imageViewUserW.image = imageUserW
        imageViewUserW.contentMode = UIViewContentMode.Center
        txtUsuario.leftView = imageViewUser
        txtUsuario.leftViewMode = UITextFieldViewMode.Always
        txtUsuario.addSubview(imageViewUser)
        //txtSenha
        //Imagem Cinza
        imageViewSenha.frame = CGRect(x: 0, y: 0, width: 30, height: 18)
        imageViewSenha.image = imageSenha
        imageViewSenha.contentMode = UIViewContentMode.Center
        //Imagem Branca
        imageViewSenhaW.frame = CGRect(x: 0, y: 0, width: 30, height: 18)
        imageViewSenhaW.image = imageSenhaW
        imageViewSenhaW.contentMode = UIViewContentMode.Center
        txtSenha.leftView = imageViewSenha
        txtSenha.leftViewMode = UITextFieldViewMode.Always
        txtSenha.addSubview(imageViewSenha)
        
        //Animação da Chegada dos TextView no Login
        self.txtUsuario.alpha = CGFloat(0)
        self.txtSenha.alpha = CGFloat(0)
        self.btnLogin.alpha = CGFloat(0)
        
        
        UIView.animateWithDuration(0.5, delay: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.imgLogo.transform = CGAffineTransformMakeTranslation(0,-170)
            }, completion: nil)
        
        UIView.animateWithDuration(0.7, delay: 1.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.txtUsuario.frame = CGRectMake(self.txtUsuario.frame.origin.x, 200, self.txtUsuario.frame.width, self.txtUsuario.frame.height)
            self.txtUsuario.alpha = CGFloat(1)
            self.txtSenha.frame = CGRectMake(self.txtSenha.frame.origin.x, 150, self.txtSenha.frame.width, self.txtSenha.frame.height)
            self.txtSenha.alpha = CGFloat(1)
            self.btnLogin.frame = CGRectMake(self.btnLogin.frame.origin.x, 100, self.btnLogin.frame.width, self.btnLogin.frame.height)
            self.btnLogin.alpha = CGFloat(1)
            self.btnUrl.frame = CGRectMake(self.btnUrl.frame.origin.x, 50, self.btnUrl.frame.width, self.btnUrl.frame.height)
            }, completion: nil)
        
        txtUsuario.delegate = self
        txtSenha.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        //Mudar cor da Barra de Status para Escura (EM INFO DO PROJETO View controller-based status bar appearance NO para cada tela ter uma cor diferente)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Actions
    @IBAction func efetuarLogin(sender: AnyObject)
    {
        var translacao = CGFloat()
        if (tecladoVisivel)
        {
            translacao = -190.0
        }
        else
        {
            translacao = 0.0
        }
        //Verificar se usuario e senha foram digitados
        if (self.txtUsuario.text == "") || (self.txtSenha.text == "")
        {
            if (self.txtUsuario.text == "")
            {
                let phUsuario = NSAttributedString(string: "Usuário", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
                self.txtUsuario.attributedPlaceholder = phUsuario;
                txtUsuario.leftView = imageViewUserW
                UIView.animateWithDuration(0.1, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    let phUsuario = NSAttributedString(string: "Usuário", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
                    self.txtUsuario.attributedPlaceholder = phUsuario;
                    self.txtUsuario.transform = CGAffineTransformMakeTranslation(-3, translacao)
                }, completion: { (Bool) -> Void in
                    UIView.animateWithDuration(0.1, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                        self.txtUsuario.transform = CGAffineTransformMakeTranslation(3, translacao)
                        }, completion: { (Bool) -> Void in
                            UIView.animateWithDuration(0.1, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                                self.txtUsuario.transform = CGAffineTransformMakeTranslation(-3, translacao)
                                }, completion: { (Bool) -> Void in
                                    UIView.animateWithDuration(0.1, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                                        self.txtUsuario.transform = CGAffineTransformMakeTranslation(0, translacao)
                                        }, completion: { (Bool) -> Void in
                                            let phUsuario = NSAttributedString(string: "Usuário", attributes: [NSForegroundColorAttributeName : UIColor.grayColor()])
                                            self.txtUsuario.attributedPlaceholder = phUsuario;
                                            if !(self.txtUsuario.isFirstResponder())
                                            {
                                                self.txtUsuario.leftView = self.imageViewUser
                                            }
                                    })
                            })
                    })

                })
            }
            if (self.txtSenha.text == "")
            {
                let phSenha = NSAttributedString(string: "Senha", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
                self.txtSenha.attributedPlaceholder = phSenha;
                txtSenha.leftView = imageViewSenhaW
                UIView.animateWithDuration(0.1, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.txtSenha.transform = CGAffineTransformMakeTranslation(3, translacao)
                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.1, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                            self.txtSenha.transform = CGAffineTransformMakeTranslation(-3, translacao)
                            }, completion: { (Bool) -> Void in
                                UIView.animateWithDuration(0.1, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                                    self.txtSenha.transform = CGAffineTransformMakeTranslation(3, translacao)
                                    }, completion: { (Bool) -> Void in
                                        UIView.animateWithDuration(0.1, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                                            self.txtSenha.transform = CGAffineTransformMakeTranslation(0, translacao)
                                            }, completion: { (Bool) -> Void in
                                                let phSenha = NSAttributedString(string: "Senha", attributes: [NSForegroundColorAttributeName : UIColor.grayColor()])
                                                self.txtSenha.attributedPlaceholder = phSenha;
                                                if !(self.txtSenha.isFirstResponder())
                                                {
                                                    self.txtSenha.leftView = self.imageViewSenha
                                                }
                                        })
                                })
                        })
                        
                })
            }
            
        }
        else
        {
            //Desativar Iteração com o UIButton
            btnLogin.userInteractionEnabled = false
            
            //Desativar Iteração com a View
            self.view.userInteractionEnabled = false
            
            //Esconder teclado caso esteja aberto
            txtUsuario.resignFirstResponder()
            txtSenha.resignFirstResponder()
            esconderTeclado()
            
            //Mudar Imagem dos TextField para Cinza
            txtUsuario.leftView = imageViewUser
            txtSenha.leftView = imageViewSenha

            //Adicionar o Loading no Botao Login
            spinner.frame = CGRect(x: 15, y: 15, width: 10, height: 10)
            spinner.startAnimating()
            btnLogin.addSubview(spinner)
            
            txtSenha.resignFirstResponder()
            esconderTeclado()
            UIView.animateWithDuration(0.2, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.btnLogin.backgroundColor = nil
                self.txtUsuario.alpha = 0
                self.txtSenha.alpha = 0
                }, completion: nil)
            UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.btnLogin.setTitle("", forState: UIControlState.Normal)
                self.btnLogin.transform = CGAffineTransformMakeTranslation(0, -50)
                self.btnLogin.setTitle(self.mensagens[1], forState: UIControlState.Normal)
                
                }) { (Bool) -> Void in
                    //Verificação do Acesso
                    if ((self.txtUsuario.text!.uppercaseString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "ANDRÉ") || (self.txtUsuario.text!.uppercaseString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "ANDRE")) && (self.txtSenha.text == "123")
                    {
                        //Acesso Autorizado
                        self.spinner.stopAnimating()
                        self.btnLogin.backgroundColor = UIColor.greenColor()
                        self.btnLogin.setTitle(self.mensagens[3], forState: UIControlState.Normal)
                        //Próxima View
                        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
                        dispatch_after(delayTime, dispatch_get_main_queue()) {
                            //Reativar Iteração com o UIButton
                            self.btnLogin.userInteractionEnabled = true
                            //Reativar Iteração com a View
                            self.view.userInteractionEnabled = true
                            self.performSegueWithIdentifier("segueLogin", sender: nil)
                        }
                        
                    }
                    else
                    {
                        //Acesso Negado
                        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                            self.btnLogin.backgroundColor = UIColor.redColor()
                            self.spinner.alpha = 0
                            }, completion: {_ in
                                self.spinner.stopAnimating()
                                self.spinner.alpha = 1
                        })
                        
                        self.btnLogin.setTitle(self.mensagens[2], forState: UIControlState.Normal)
                        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
                        dispatch_after(delayTime, dispatch_get_main_queue()) {
                            //Reativar Iteração com o UIButton
                            self.btnLogin.userInteractionEnabled = true
                            //Reativar Iteração com a View
                            self.view.userInteractionEnabled = true
                            self.btnLogin.setTitle(self.mensagens[0], forState: UIControlState.Normal)
                            self.txtUsuario.text = ""
                            self.txtSenha.text = ""
                            UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                                self.btnLogin.backgroundColor = UIColor.orangeColor()
                                self.btnLogin.transform = CGAffineTransformMakeTranslation(0, 0)
                                }, completion: nil)
                            UIView.animateWithDuration(0.5, delay: 0.1, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                                self.txtUsuario.alpha = 1
                                self.txtSenha.alpha = 1
                                }, completion: nil)
                        }
                    }
            }
        }
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        tecladoVisivel = true
        //Mudar Imagem
        if textField == txtUsuario
        {
            txtUsuario.leftView = imageViewUserW
        }
        else if textField == txtSenha
        {
            txtSenha.leftView = imageViewSenhaW
        }
        //Subir UITextFields
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.txtUsuario.transform = CGAffineTransformMakeTranslation(0,-190)
            }, completion: nil)
        UIView.animateWithDuration(0.4, delay: 0.025, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.txtSenha.transform = CGAffineTransformMakeTranslation(0,-190)
            }, completion: nil)
        UIView.animateWithDuration(0.4, delay: 0.05, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.btnLogin.transform = CGAffineTransformMakeTranslation(0,-190)
            }, completion: nil)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //Descer UITextFields
        if textField == txtUsuario
        {
          txtSenha.becomeFirstResponder()
        }
        else
        {
          efetuarLogin(btnLogin)
        }
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        //Mudar Imagem
        if (txtUsuario.text == "")
        {
            txtUsuario.leftView = imageViewUser
        }
        else
        {
            txtUsuario.leftView = imageViewUserW
        }
        if (txtSenha.text == "")
        {
            txtSenha.leftView = imageViewSenha
        }
        else
        {
            txtSenha.leftView = imageViewSenhaW
        }
        return true
    }
    
    //Esconder Teclado ao Tocar na View
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        txtUsuario.resignFirstResponder()
        txtSenha.resignFirstResponder()
        esconderTeclado()
    }
    
    func esconderTeclado()
    {
        tecladoVisivel = false
        UIView.animateWithDuration(0.4, delay: 0.05, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.btnLogin.transform = CGAffineTransformMakeTranslation(0,0)
            }, completion: nil)
        UIView.animateWithDuration(0.4, delay: 0.075, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.txtSenha.transform = CGAffineTransformMakeTranslation(0,0)
            }, completion: nil)
        UIView.animateWithDuration(0.4, delay: 0.1, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.txtUsuario.transform = CGAffineTransformMakeTranslation(0,0)
            }, completion: nil)
    }

}

//
//  WebViewViewController.swift
//  rapidOs
//
//  Created by André Carvalho on 20/04/15.
//  Copyright (c) 2015 André Carvalho. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, WKNavigationDelegate, UIScrollViewDelegate {
    
    var webView: WKWebView!
    //Ultimo Offset para scrollview esconder o tab bar
    var lastOffset = CGPoint()
    @IBOutlet weak var barraProgresso: UIProgressView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var btnStop: UIBarButtonItem!
    @IBOutlet weak var btnRefresh: UIBarButtonItem!
    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var btnNext: UIBarButtonItem!
    @IBOutlet weak var btnFacebook: UIBarButtonItem!
    @IBOutlet weak var btnHome: UIButton!    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnEmail: UIBarButtonItem!
    @IBOutlet weak var flexible1: UIBarButtonItem!
    @IBOutlet weak var flexible2: UIBarButtonItem!
    @IBOutlet weak var flexible3: UIBarButtonItem!
    @IBOutlet weak var flexible4: UIBarButtonItem!
    
    //Variavel para pegar os Frames Originais do NavBar e Toolbar
    var originalFrameToolBar = CGRect()
    //Variaveis para saber se a ToolBar esta visivel ou nao apos o Dragging e o Delta do Scroll
    var toolBarVisivel = false
    var deltaOffset: CGFloat = 0
    var finalScroll = false
    var inicioScroll = true
    
    //Variavel para dizer que esta dando um zoom ao inves de dragging
    var zoom = false
    
    //Variavel scrollView para acessar o scrollView do WebView fora do delegate
    var scrollView = UIScrollView()
    
    //Variavel para saber quando esta desacelerando o Scroll
    var desacelerando = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Cor da Barra de Progresso
        barraProgresso.tintColor = UIColor.orangeColor()
        
        //Cor da NavBar
        UINavigationBar.appearance().barTintColor = UIColor.blackColor()
        
        //Cor da TabBar
        UIToolbar.appearance().barTintColor = UIColor.blackColor()
        
        //TintCor dos Botoes
        btnStop.tintColor = UIColor.orangeColor()
        btnRefresh.tintColor = UIColor.orangeColor()
        btnBack.tintColor = UIColor.orangeColor()
        btnNext.tintColor = UIColor.orangeColor()
        btnFacebook.tintColor = UIColor.orangeColor()
        btnClose.tintColor = UIColor.orangeColor()
        btnEmail.tintColor = UIColor.orangeColor()
        
        
        webView = WKWebView(frame: CGRectZero)
        webView.navigationDelegate = self
        self.view.insertSubview(webView, belowSubview: barraProgresso)
        //Constraints
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: self.webView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.webView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.webView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        ])
        barraProgresso.progress = 0
        barraProgresso.hidden = true
        btnRefresh.enabled = false
        btnStop.enabled = false
        
        //Setar a variavel scrollView para atualizala fora dos delegates
        scrollView = webView.scrollView
        
        //Delegate do ScrollView do WebView
        webView.scrollView.delegate = self
        
        //Observador do Progresso de Carregamento
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.New, context: nil)
        
        //Carregamento da Pagina Home da Inove
        let url = NSURL(string: "http://inovesistemasinfo.com.br")
        let requisicao = NSURLRequest(URL: url!)
        webView.loadRequest(requisicao)
        //Mostrar Atividade de Internet na barra de status
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        //Mostra Barra
        barraProgresso.hidden = false
        btnStop.enabled = true
        
        //Inset no Scroll para poder ver o final da página
      //  webView.scrollView.contentInset.bottom = 44
    }
    
    //Ao Aparecer a View Grava os Frames originais do Nav e ToolBar
    override func viewDidAppear(animated: Bool) {
        self.originalFrameToolBar = self.toolBar.frame;
        toolBarVisivel = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        //Removendo Delegate do ScrollView do WebView (Esta com bug se nao remover)
        webView.scrollView.delegate = nil
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        //Remover o Observador ao Fechar a View
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    //Observador do Progresso de Carregamento
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if (keyPath == "estimatedProgress")
        {
            self.barraProgresso.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fecharView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: Carregamento de Páginas
    @IBAction func goHome(sender: AnyObject)
    {
        //Carregamento da Pagina Home da Inove
        barraProgresso.progress = 0
        barraProgresso.hidden = false
        let url = NSURL(string: "http://inovesistemasinfo.com.br")
        let requisicao = NSURLRequest(URL: url!)
        webView.loadRequest(requisicao)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        btnRefresh.enabled = false
        btnStop.enabled = true
    }
    
    @IBAction func goFacebook(sender: AnyObject)
    {
        //Carregamento da Pagina Do Facebook
        barraProgresso.progress = 0
        barraProgresso.hidden = false
//        let url = NSURL(string: "http://www.gamevicio.com.br")
        let url = NSURL(string: "https://www.facebook.com/inovesistemaspe")!
        let requisicao = NSURLRequest(URL: url)
        webView.loadRequest(requisicao)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        btnRefresh.enabled = false
        btnStop.enabled = true
    }
    
    //MARK: Métodos Delegate do WebView
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!)
    {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        barraProgresso.progress = 0
        barraProgresso.hidden = true
        btnRefresh.enabled = true
        btnStop.enabled = false
    }
    
    func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError)
    {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        //Mostrar Msg de Erro
        if (error.code != -999)
        {
            let alerta = UIAlertController(title: "Ops!", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
            alerta.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alerta, animated: true, completion: nil)
        }
        
        barraProgresso.progress = 0
        barraProgresso.hidden = true
        btnRefresh.enabled = true
        btnStop.enabled = false
    }
    
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        toolBarVisivel = true
        self.toolBar.alpha = 1
        scrollView.contentInset.bottom = 0
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        barraProgresso.hidden = false
        btnRefresh.enabled = false
        btnStop.enabled = true
    }
    
    @IBAction func goBack(sender: AnyObject) {
        webView.goBack()
        barraProgresso.progress = 0
        barraProgresso.hidden = false
        btnRefresh.enabled = false
        btnStop.enabled = true
    }
    
    @IBAction func goFoward(sender: AnyObject) {
        webView.goForward()
        barraProgresso.progress = 0
        barraProgresso.hidden = false
        btnRefresh.enabled = false
        btnStop.enabled = true
    }
    
    @IBAction func stopLoading(sender: AnyObject) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        webView.stopLoading()
        barraProgresso.progress = 0
        barraProgresso.hidden = true
        btnRefresh.enabled = true
//        self.toolBar.items = [btnBack, flexible1, btnNext, flexible2, btnFacebook, flexible3, btnEmail, flexible4, btnRefresh]
        btnStop.enabled = false
    }

    @IBAction func reload(sender: AnyObject) {
        webView.reload()
        barraProgresso.progress = 0
        barraProgresso.hidden = false
        btnRefresh.enabled = false
//        self.toolBar.items = [btnBack, flexible1, btnNext, flexible2, btnFacebook, flexible3, btnEmail, flexible4, btnStop]
        btnStop.enabled = true
    }
    
    //MARK: Métodos Delegate do Scroll View do WebView
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        deltaOffset = yOffset - lastOffset.y
        print("\(deltaOffset) \(desacelerando)")
        if (deltaOffset > 0.0) && (toolBarVisivel) && !(zoom) && !(desacelerando)
        {
            self.toolBar.frame = CGRectMake(self.toolBar.frame.origin.x, self.originalFrameToolBar.origin.y + deltaOffset, self.toolBar.frame.size.width, self.toolBar.frame.size.height)
            if (deltaOffset >= 44.0)
            {
                toolBarVisivel = false
                self.toolBar.alpha = 0
            }
        }
    }
    
    //Inicion do Zoom do Scrool
    func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView?) {
        zoom = true
    }
    
    //Fim do Zoom
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        zoom = false
    }
    
    //Início do Scroll
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //Pegar o ultimo offset do scroll quando começa o Scroll
        lastOffset = scrollView.contentOffset
        //Se o tamanho do scroll menos a posicao menos 667.0(tamanho da view) for menor que 0.0 = final da view
        if ((scrollView.contentSize.height - scrollView.contentOffset.y - 667.0) <= 0.0) && (self.toolBar.alpha == 0)
        {
            finalScroll = true
            self.toolBar.frame = CGRectMake(self.toolBar.frame.origin.x, self.originalFrameToolBar.origin.y + 44.0, self.toolBar.frame.size.width, self.toolBar.frame.size.height)
            UIView.animateWithDuration(0.2, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                scrollView.contentInset.bottom = 44
                self.toolBar.alpha = 1
                self.toolBar.frame = CGRectMake(self.toolBar.frame.origin.x, self.originalFrameToolBar.origin.y, self.toolBar.frame.size.width, self.toolBar.frame.size.height)
            }, completion: nil)
        }
    }
    
    //ScrollView quando começa a desacelerar
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        print("iniciou")
        desacelerando = true
        if (deltaOffset < 0.0)
        {
            scrollView.contentInset.bottom = 0
            self.toolBar.alpha = 1
            finalScroll = false
            UIView.animateWithDuration(0.2, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.toolBarVisivel = true
                self.toolBar.frame = CGRectMake(self.toolBar.frame.origin.x, self.originalFrameToolBar.origin.y, self.toolBar.frame.size.width, self.toolBar.frame.size.height)
                }, completion: nil)
        }
    }
    
    //Final da desceleração do scrollView
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        print("parou")
        desacelerando = false
        if (deltaOffset > 0.0) && (deltaOffset < 44.0) && !(finalScroll) && !(inicioScroll)
        {
            UIView.animateWithDuration(0.1, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.toolBar.alpha == 0
                self.toolBarVisivel = false
                self.toolBar.frame = CGRectMake(self.toolBar.frame.origin.x, self.originalFrameToolBar.origin.y + 44.0, self.toolBar.frame.size.width, self.toolBar.frame.size.height)
                }, completion: nil
            )
        }
    }
    
    //ScrollView ao Clicar em Ir para o Topo
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        scrollView.contentInset.bottom = 0
        self.toolBar.alpha = 1
        finalScroll = false
        inicioScroll = true
        UIView.animateWithDuration(0.2, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.toolBarVisivel = true
            self.toolBar.frame = CGRectMake(self.toolBar.frame.origin.x, self.originalFrameToolBar.origin.y, self.toolBar.frame.size.width, self.toolBar.frame.size.height)
            }, completion: nil)
    }
    
    //Scroll Quando usuario solta o toque e nao baixou totalmente o toobar ainda (44)
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (deltaOffset > 0.0) && (deltaOffset < 44.0) && !(finalScroll)
        {
            UIView.animateWithDuration(0.2, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.toolBar.alpha == 1
                self.toolBarVisivel = true
                self.toolBar.frame = CGRectMake(self.toolBar.frame.origin.x, self.originalFrameToolBar.origin.y, self.toolBar.frame.size.width, self.toolBar.frame.size.height)
            }, completion: nil
            )
        }
    }
    
}

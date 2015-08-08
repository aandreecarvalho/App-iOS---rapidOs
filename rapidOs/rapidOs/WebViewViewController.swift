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
    
    //Não declarar variável como weak para só ser destruída no final da execução do app
    
    var webView: WKWebView!
    //Ultimo Offset para scrollview esconder o tab bar
    var lastOffset = CGPoint()
    @IBOutlet weak var barraProgresso: UIProgressView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet var btnStop: UIBarButtonItem!
    @IBOutlet var btnRefresh: UIBarButtonItem!
    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var btnNext: UIBarButtonItem!
    @IBOutlet weak var btnFacebook: UIBarButtonItem!
    @IBOutlet weak var btnHome: UIButton!    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnEmail: UIBarButtonItem!
    @IBOutlet weak var btnCall: UIBarButtonItem!
    @IBOutlet weak var flexible1: UIBarButtonItem!
    @IBOutlet weak var flexible2: UIBarButtonItem!
    @IBOutlet weak var flexible3: UIBarButtonItem!
    @IBOutlet weak var flexible4: UIBarButtonItem!
    @IBOutlet weak var flexible5: UIBarButtonItem!
    
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
        btnCall.tintColor = UIColor.orangeColor()
        
        
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
        //Iniciar Toolbar com botao Stop Invisivel
        toolBar.items = [btnBack,flexible1,btnNext,flexible2,btnFacebook,flexible3,btnCall,flexible4,btnEmail,flexible5,btnRefresh]
        //Iniciar Toolbar com botoes de anterior e proximo desativados
        btnBack.enabled = false
        btnNext.enabled = false
        
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
    }
    
    @IBAction func goFacebook(sender: AnyObject)
    {
        //Carregamento da Pagina Do Facebook
        barraProgresso.progress = 0
        barraProgresso.hidden = false
        let url = NSURL(string: "https://www.facebook.com/inovesistemaspe")!
        let requisicao = NSURLRequest(URL: url)
        webView.loadRequest(requisicao)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

    }
    
    //MARK: Métodos Delegate do WebView
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!)
    {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        barraProgresso.progress = 0
        barraProgresso.hidden = true
        toolBar.items = [btnBack,flexible1,btnNext,flexible2,btnFacebook,flexible3,btnCall,flexible4,btnEmail,flexible5,btnRefresh]
        
        //Verificar Lista de Back e Foward
        if (webView.canGoBack)
        {
            btnBack.enabled = true
        }
        else
        {
            btnBack.enabled = false
        }
        if (webView.canGoForward)
        {
            btnNext.enabled = true
        }
        else
        {
            btnNext.enabled = false
        }
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
        
        toolBar.items = [btnBack,flexible1,btnNext,flexible2,btnFacebook,flexible3,btnCall,flexible4,btnEmail,flexible5,btnRefresh]
        
        //Verificar Lista de Back e Foward
        if (webView.canGoBack)
        {
            btnBack.enabled = true
        }
        else
        {
            btnBack.enabled = false
        }
        if (webView.canGoForward)
        {
            btnNext.enabled = true
        }
        else
        {
            btnNext.enabled = false
        }
    }
    
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        toolBarVisivel = true
        self.toolBar.alpha = 1
        scrollView.contentInset.bottom = 0
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        barraProgresso.hidden = false
        
        toolBar.items = [btnBack,flexible1,btnNext,flexible2,btnFacebook,flexible3,btnCall,flexible4,btnEmail,flexible5,btnStop]
        
        //Verificar Lista de Back e Foward
        if (webView.canGoBack)
        {
            btnBack.enabled = true
        }
        else
        {
            btnBack.enabled = false
        }
        if (webView.canGoForward)
        {
            btnNext.enabled = true
        }
        else
        {
            btnNext.enabled = false
        }
    }
    
    @IBAction func goBack(sender: AnyObject) {
        webView.goBack()
        barraProgresso.progress = 0
        barraProgresso.hidden = false
    }
    
    @IBAction func goFoward(sender: AnyObject) {
        webView.goForward()
        barraProgresso.progress = 0
        barraProgresso.hidden = false
    }
    
    @IBAction func stopLoading(sender: AnyObject) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        webView.stopLoading()
        barraProgresso.progress = 0
        barraProgresso.hidden = true
        
        toolBar.items = [btnBack,flexible1,btnNext,flexible2,btnFacebook,flexible3,btnCall,flexible4,btnEmail,flexible5,btnRefresh]
        
    }

    @IBAction func reload(sender: AnyObject) {
        webView.reload()
        barraProgresso.progress = 0
        barraProgresso.hidden = false
    }
    
    //MARK: Métodos Delegate do Scroll View do WebView
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        deltaOffset = yOffset - lastOffset.y
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
    
    //MARK: Efetuar ligação pela operadora
    func efetuarLigacao(numero: String) {
        let fone: NSURL = NSURL(string: "tel://\(numero)")!
        UIApplication.sharedApplication().openURL(fone)
    }
    
    func selecionarOperadora(numero: String) {
        //Criar o ActionSheet
        let actionSheet = UIAlertController(title: "Operadora", message: "Caso não esteja no DDD 87", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let btnSemOperadora = UIAlertAction(title: "Sem operadora (Discagem direta)", style: UIAlertActionStyle.Default) { (btnSemOperadora) -> Void in
            self.efetuarLigacao(numero)
        }
        let btnOperadoraOi = UIAlertAction(title: "Oi (31)", style: UIAlertActionStyle.Default) { (btnOperadoraOi) -> Void in
            self.efetuarLigacao("03187" + numero)
        }
        let btnOperadoraTim = UIAlertAction(title: "Tim (41)", style: UIAlertActionStyle.Default) { (btnOperadoraTim) -> Void in
            self.efetuarLigacao("04187" + numero)
        }
        let btnOperadoraClaro = UIAlertAction(title: "Claro (21)", style: UIAlertActionStyle.Default) { (btnOperadoraClaro) -> Void in
            self.efetuarLigacao("02187" + numero)
        }
        let btnOperadoraVivo = UIAlertAction(title: "Vivo (15)", style: UIAlertActionStyle.Default) { (btnOperadoraVivo) -> Void in
            self.efetuarLigacao("01587" + numero)
        }
        let btnOperadoraNextel = UIAlertAction(title: "Nextel (77)", style: UIAlertActionStyle.Default) { (btnOperadoraNextel) -> Void in
            self.efetuarLigacao("07787" + numero)
        }
        let btnCancelar = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: nil)
        
        //Adicionar os Botões
        actionSheet.addAction(btnSemOperadora)
        actionSheet.addAction(btnOperadoraOi)
        actionSheet.addAction(btnOperadoraTim)
        actionSheet.addAction(btnOperadoraClaro)
        actionSheet.addAction(btnOperadoraVivo)
        actionSheet.addAction(btnOperadoraNextel)
        actionSheet.addAction(btnCancelar)
        
        //Mostrar
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func menuTelefones(sender: AnyObject) {
        //Criar o ActionSheet
        let actionSheet = UIAlertController(title: "Ligar para Inove Sistemas", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let btnFixo = UIAlertAction(title: "Fixo - (87) 3831-1594", style: UIAlertActionStyle.Default) { (btnFixo) -> Void in
            self.selecionarOperadora("38311594")
        }
        let btnTim = UIAlertAction(title: "Tim - (87) 99965-6771", style: UIAlertActionStyle.Default) { (btnTim) -> Void in
            self.selecionarOperadora("999656771")
        }
        let btnOi = UIAlertAction(title: "Oi - (87) 98843-9523", style: UIAlertActionStyle.Default) { (btnOi) -> Void in
            self.selecionarOperadora("988439523")
        }
        let btnCancelar = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: nil)
        
        //Adicionar os Botões
        actionSheet.addAction(btnFixo)
        actionSheet.addAction(btnTim)
        actionSheet.addAction(btnOi)
        actionSheet.addAction(btnCancelar)
        
        //Para mostrar popup no iPad
        actionSheet.popoverPresentationController?.sourceRect = (sender as! UIButton).frame
        actionSheet.popoverPresentationController?.sourceView = self.view
        actionSheet.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.Up
        
        //Mostrar
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
}

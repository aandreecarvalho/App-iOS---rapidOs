//
//  ListaOsViewController.swift
//  rapidOs
//
//  Created by André Carvalho on 07/04/15.
//  Copyright (c) 2015 André Carvalho. All rights reserved.
//

import UIKit

class ListaOsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrayServicos:[[String:String]] =
    [
    ["ID_OS":"12987","EMPRESA":"Inove Sistemas","PROBLEMA":"Computador não liga"],
    ["ID_OS":"12556","EMPRESA":"Altair Supermercado","PROBLEMA":"Entrada por XML"],
    ["ID_OS":"11234","EMPRESA":"Posto do Vale","PROBLEMA":"Verificar reserva"],
    ["ID_OS":"7823","EMPRESA":"Magalhães Informática","PROBLEMA":"PDV com problema"],
    ["ID_OS":"10453","EMPRESA":"Serra Vidros","PROBLEMA":"Não consegue emitir NFe"],
    ["ID_OS":"11332","EMPRESA":"Posto Renascer","PROBLEMA":"Atualizar i9 Controle"],
    ["ID_OS":"11234","EMPRESA":"Posto do Vale","PROBLEMA":"Verificar reserva"],
    ["ID_OS":"7823","EMPRESA":"Magalhães Informática","PROBLEMA":"PDV com problema"],
    ["ID_OS":"10453","EMPRESA":"Serra Vidros","PROBLEMA":"Não consegue emitir NFe"]
    ]


    @IBOutlet weak var tabelaOs: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Tamanho das Celulas
        tabelaOs.rowHeight = 88
        
        tabelaOs.delegate = self
        tabelaOs.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Protocolos
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayServicos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let celula = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "idCelula")
        celula.textLabel?.text = arrayServicos[indexPath.row]["EMPRESA"]
        celula.detailTextLabel?.text = arrayServicos[indexPath.row]["PROBLEMA"]
        
        return celula
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    //MARK: - Ações
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.performSegueWithIdentifier("segueDetalheOs", sender: indexPath)
        //Descelecionar celula ao clicar nela
        tabelaOs.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    //MARK: - Passagem de Dados
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "segueDetalheOs"
        {
            let viewDetalheOs: DetalheOsViewController = segue.destinationViewController as! DetalheOsViewController
            viewDetalheOs.codigoOs = arrayServicos[(sender as! NSIndexPath).row]["ID_OS"]
            viewDetalheOs.cliente = arrayServicos[(sender as! NSIndexPath).row]["EMPRESA"]
            viewDetalheOs.problema = arrayServicos[(sender as! NSIndexPath).row]["PROBLEMA"]
        }

    }
    
}

//
//  DetalheOsViewController.swift
//  rapidOs
//
//  Created by André Carvalho on 07/04/15.
//  Copyright (c) 2015 André Carvalho. All rights reserved.
//

import UIKit
import MapKit

class DetalheOsViewController: UIViewController {

    @IBOutlet weak var lblCodigoOs: UILabel!
    @IBOutlet weak var lblCliente: UILabel!
    @IBOutlet weak var lblProblema: UILabel!
    
    var cliente: String? = String()
    var problema: String? = String()
    var codigoOs: String? = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lblCliente.text = cliente
        lblProblema.text = problema
        lblCodigoOs.text = "OS \(codigoOs!)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

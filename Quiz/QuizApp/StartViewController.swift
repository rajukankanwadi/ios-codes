//
//  StartViewController.swift
//  QuizApp
//
//  Created by Raaj on 1/5/18.
//  Copyright © 2018 RVK. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var resumeBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        resumeBtn.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startQuiz(_ sender: Any) {
        
        performSegue(withIdentifier: "pushToTest", sender: self)
        
    }

    @IBAction func resumeBtnClicked(_ sender: AnyObject) {
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

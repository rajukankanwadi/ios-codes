//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Raaj on 1/5/18.
//  Copyright © 2018 RVK. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    var noCorrect = 0
    var total = 0
    var wrongNum = 0
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblResults: UILabel!
    
    @IBOutlet weak var unanswered: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the results
        lblResults.text = "You got \(noCorrect) out of \(total) correct"
        
        lblTitle.text = "Score !"
        unanswered.text = "Unanswered \(total - wrongNum - noCorrect)"

    }
    @IBAction func tryAgainClicked(_ sender: AnyObject) {
        
        performSegue(withIdentifier: "tryAgainSegue", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

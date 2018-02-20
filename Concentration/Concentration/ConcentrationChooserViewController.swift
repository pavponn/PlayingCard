//
//  ConcentrationChooserViewController.swift
//  Concentration
//
//  Created by Павел Пономарев on 17.02.2018.
//  Copyright © 2018 Pavel Ponomarev. All rights reserved.
//

import UIKit


class ConcentrationChooserViewController: UIViewController, UISplitViewControllerDelegate {
  
    let themes = ["Sports" : "⚽️🏀🏓⛳️🏋️‍♂️🎾🏄🏿‍♀️🥇🚴🏻‍♂️🥌🥊🏒", "Flags" : "🇧🇬🇧🇿🇬🇲🏳️‍🌈🇷🇺🇺🇸🇺🇦🇺🇾🇫🇷🇩🇪🏴󠁧󠁢󠁥󠁮󠁧󠁿🇪🇸", "Animals" : "🐶🙊🐥🐯🦁🐷🐼🦊🐫🐌🦉🐗"]
    override  func awakeFromNib() {
        splitViewController?.delegate = self
    }
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        } else if let cvc = lastSeguedToConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        } else {
            performSegue(withIdentifier: "Choose Theme", sender:  sender)
        }
    
    }
    private var  splitViewDetailConentrationViewController : ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle {
                if let theme = themes[themeName] {
                    if let cvc = segue.destination as? ConcentrationViewController {
                        cvc.theme = theme
                        lastSeguedToConcentrationViewController = cvc
                    }
                }
                
            }
        }
    }

}

//
//  SplashVC.swift
//  MovieCase
//
//  Created by Eren Üstünel on 13.03.2022.
//

import UIKit

final class SplashVC: UIViewController {
    
    @IBOutlet private weak var splashLbl: UILabel!
    private var window: UIWindow?

    private var splashTitle : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Reachability.isConnectedToNetwork() {
            getValuesFromFRC()
        }else {
            self.showTryAgainAlert(title: "Hata", message: "Lütfen internet bağlantınızı kontrol ediniz.", isCancelable: false) { (_) in
                self.viewDidLoad()
            }
        }
    }
    
    
   private func getValuesFromFRC(){
        if RCValues.shared.fetchComplete {
            updateSplashLbl()
        }
        RCValues.shared.loadingDoneCallback = updateSplashLbl
    }
    
    private func updateSplashLbl() {
        let splashLblText = RCValues.shared.string(forKey: .splashTitle)
        var charIndex = 0.0

        for letter in splashLblText {
            Timer.scheduledTimer(withTimeInterval: 0.2 * charIndex, repeats: false) { (timer) in
                self.splashLbl.text?.append(letter)
            }
            charIndex += 1
        }

        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            let vc = HomeVC(nibName: "HomeVC", bundle: nil)
            let navController = UINavigationController(rootViewController: vc)
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = navController
            self.window?.makeKeyAndVisible()
        }
    }

}


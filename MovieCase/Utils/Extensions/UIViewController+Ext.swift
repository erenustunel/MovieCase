//
//  UIViewController+Ext.swift
//  MovieCase
//
//  Created by Eren Üstünel on 15.03.2022.
//

import Foundation
import UIKit

extension UIViewController {

    func showTryAgainAlert(title: String, message: String, isCancelable: Bool, repeatAction: ((UIAlertAction) -> Void)?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if isCancelable {
            let cancelAction = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
        }
        let OKAction = UIAlertAction(title: "Tekrar Dene", style: .default, handler: repeatAction)
        alertController.addAction(OKAction)

        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion:nil)
        }
    }

    func showAlert(title: String, message: String?){

        let alertController = UIAlertController(title: title, message: message ?? "", preferredStyle: .alert)

        let OKAction = UIAlertAction(title: "Tamam", style: .default) { (action:UIAlertAction!) in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(OKAction)

        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion:nil)
        }
    }
    func animateNavigate(vc: UIViewController) {
        UIView.beginAnimations("Showinfo", context: nil)
        UIView.setAnimationCurve(.easeInOut)
        UIView.setAnimationDuration(0.75)
        self.navigationController?.pushViewController(vc, animated: true)
        if let view = navigationController?.view {
            UIView.setAnimationTransition(.flipFromRight, for: view, cache: false)
        }
    }
}

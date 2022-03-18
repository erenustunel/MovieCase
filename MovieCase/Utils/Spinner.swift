//
//  Spinner.swift
//
//  Created by Eren Üstünel on 5.10.2020.
//

import UIKit

func spinnerStop() {
    DispatchQueue.main.async {
        Spinner.stop()
    }
}

func spinnerStart() {
    DispatchQueue.main.async {
        Spinner.start()
    }
}

open class Spinner {

    internal static var spinner: UIActivityIndicatorView?
    public static var style =  UIActivityIndicatorView.Style.large
    public static var baseBackColor = UIColor.black.withAlphaComponent(0.4)
    public static var baseColor = UIColor.black

    public static func start(style: UIActivityIndicatorView.Style = style, backColor: UIColor = baseBackColor, baseColor: UIColor = baseColor) {
        DispatchQueue.main.async {
            if spinner == nil, let window = UIApplication.shared.keyWindow {
                let frame = UIScreen.main.bounds
                spinner = UIActivityIndicatorView(frame: frame)
                spinner!.backgroundColor = backColor
                spinner!.style = style
                spinner?.color = baseColor
                window.addSubview(spinner!)
                spinner!.startAnimating()
            }
        }
    }

    public static func stop() {
        DispatchQueue.main.async {
            if spinner != nil {
                spinner!.stopAnimating()
                spinner!.removeFromSuperview()
                spinner = nil
            }
        }
    }

    @objc public static func update() {
        if spinner != nil {
            stop()
            start()
        }
    }
}

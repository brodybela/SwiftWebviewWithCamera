//
//  ViewController.swift
//  IOS Web View with Native Camera Access
//
//  Created by Bela Brody on 04/02/2017.
//  Copyright © 2017 Brody Media. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    fileprivate var bridge: WebViewBridge!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet var createFoto: UIButton!
    @IBAction func createFoto(_ sender: Any) {
        let camera = UIImagePickerController()
        camera.delegate = self
        camera.sourceType = UIImagePickerControllerSourceType.camera
        camera.allowsEditing = false
        self.present(camera, animated: true) {
            print("Camera started")
        }
    }
    
    func startCamera () {
        
        let camera = UIImagePickerController()
        camera.delegate = self
        camera.sourceType = UIImagePickerControllerSourceType.camera
        camera.allowsEditing = false
        self.present(camera, animated: true) {
            print("Camera started")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageVIew.image = image
            print("Photo is ready")
            print("Base64 convert started")
            print("Base64 data on its way to JS")
            let base64StringForImg = imageToBase64String(image)
            //self.bridge.sendDataToJS(["msg": base64StringForImg! as String])
            print("Base64 data sent to JS")
            //print(base64StringForImg)
        } else {
            print("Image was not rendered")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var imageVIew: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bridge = WebViewBridge.bridge(webView, defaultHandler: { data, responseCallback in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            }
        })
        
        self.bridge.registerHandlerForJS(handlerName: "cameraStart", handler: {_,_ in
            print("WEB calling IOS Native Camera")
            self.startCamera ()
            
        })
        
        let mainBundle = Bundle.main
        let localfilePath = mainBundle.url(forResource: "index", withExtension: "html");
        let showWebView = NSURLRequest(url: localfilePath!);
        webView.loadRequest(showWebView as URLRequest);
        self.view.addSubview(webView)
        print("index.html loaded")
        
    }
    
    fileprivate func printReceivedParmas(_ data: AnyObject) {
        print("Swift recieved data passed from JS: \(data)")
    }
}

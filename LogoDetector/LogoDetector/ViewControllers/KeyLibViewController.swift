//
//  SomeView.swift
//  LogoDetector
//
//  Created by Oceanic on 5/10/17.
//  Copyright © 2017 altaibayar tseveenbayar. All rights reserved.
//

//This script needcs to be split into 2
//NewKeyView
//KeyLibView

import UIKit

class KeyLibViewController: UIViewController, UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imgSelectedImage: UIImageView!
    @IBOutlet weak var keyImageView: UIImageView!
    @IBOutlet weak var textKeyId: UILabel!
    var keyImageName : String = "imgKey"
    var savedDataStr : String = "no data";
    var cIndex : Int = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if(keyImageView != nil){
            LoadImage()
        }
        
        if(imgSelectedImage != nil){
            cIndex = CacheImageArray()
            textKeyId.text = "Key" + String(cIndex)
        }
        
    }
    
    @IBAction func OnCaptureImage(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .camera
        present(controller,animated:true,completion: nil)
    }
    @IBAction func OnSelectImage(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller,animated:true,completion: nil)
    }
    
    
    /*
    @IBAction func OnSave(_ sender: Any) {
        //If you used the capture.
        UIImageWriteToSavedPhotosAlbum(imgSelectedImage.image!, nil, nil, nil);
    }
    */
    
    
    
    
    
    
    
    
    @IBAction func LoadImage(_ sender: Any) {
        LoadImage()
    }
    
    @IBAction func OnClear(_ sender: Any){
        ClearImgs()
        keyImageView.image = nil
    }
    
    func LoadImage(){
        let size = CacheImageArray()
        
        if size == 0{
            return
        }
        
        if keyImageView == nil{
            return;
        }
        keyImageView.image = LoadImageFromLibrary(index: cIndex)
        
        textKeyId.text = "Key " + String(cIndex)
        
        cIndex += 1
        
        if cIndex >= size{
            cIndex = 0
        }
    }
    
    func LoadImageFromLibrary(index: Int) -> UIImage{
        let imgStr : String = "img" + String(index)
        let data = UserDefaults.standard.object(forKey: imgStr) as! NSData
        return UIImage(data: data as Data)!
    }
    
    func ClearImgs(){
        var curIndex : Int = 0
        var imgStr : String = "img" + String(curIndex)
        let size = CacheImageArray()
        
        while curIndex < size {
            UserDefaults.standard.removeObject(forKey: imgStr)
            imgStr = "img" + String(curIndex)
            
            print("removed" + String(curIndex))
            curIndex += 1
        }

    }
    
    func CacheImageArray() -> Int{
        //var digitCounts = Array(repeating: 0, count: 10)
        
        var curIndex : Int = 0
        var imgStr : String = "img" + String(curIndex)
        
        while isKeyPresentInUserDefaults(key: imgStr) {
            print("index: \(curIndex)!")

            curIndex += 1
            imgStr = "img" + String(curIndex)
        }
        
        return curIndex;
        
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }


    @IBAction func OnSaveImage(_ sender: Any) {
        
        if(imgSelectedImage.image == nil){
            return
        }
        
        //encode
        let image = imgSelectedImage.image;
        let imageData:NSData = UIImagePNGRepresentation(image!)! as NSData
        
        //Save
        UserDefaults.standard.set(imageData, forKey: "img" + String(cIndex))
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgSelectedImage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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

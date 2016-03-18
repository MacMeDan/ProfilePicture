//
//  ViewController.swift
//  ProfilePicture
//
//  Created by Dan Leonard on 3/18/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

//
//  AvatarView.swift
//  Weave
//
//  Created by Dan Leonard on 1/25/16.
//  Copyright © 2016 getweave. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
//import Alamofire

public class AvatarView: UIButton, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverControllerDelegate {
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func setImageForAvatarView(image: UIImage) {
        guard let imageData: NSData = UIImagePNGRepresentation(image) else {
            return print("Invalid Image Representation")
        }
        self.setImage(UIImage(data: imageData), forState: .Normal)
        
    }
    
     func setup(initials initials: String?, imageURL: NSURL?) {
        self.tintColor = UIColor.whiteColor()
        self.imageView?.contentMode = .ScaleAspectFill
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
        
        if imageURL == nil && initials == nil {
            setImage(UIImage(named: "blankAvatar"), forState: .Normal)
        } else {
            setTitle(initials, forState: .Normal)
//            sd_setImageWithURL(imageURL, forState: .Normal, placeholderImage:nil, options: .RefreshCached)
        }
    }
}

// MARK: - UIImagePickerControllerDelegate Methods
extension UIViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func newImgTapped(sender: UIButton) {
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        let status = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        if status == AVAuthorizationStatus.Denied {
            
            let changeYourSettingsAlert = UIAlertController(title: "You do not have permissions enabled for this.", message: "Would you like to change them in settings?", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: { (UIAlertAction) -> Void in
                guard let url = NSURL(string: UIApplicationOpenSettingsURLString) else {return}
                UIApplication.sharedApplication().openURL(url)
                print("opensettings")
                
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            
            changeYourSettingsAlert.addAction(okAction)
            changeYourSettingsAlert.addAction(cancelAction)
            presentAlert(changeYourSettingsAlert)
            
            
        } else {
            let Alert = UIAlertController(title: "Where would you like to get photos from?", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
            Alert.popoverPresentationController?.sourceRect = sender.bounds
            Alert.popoverPresentationController?.sourceView = sender
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            
            imgPicker.allowsEditing = true
            imgPicker.modalPresentationStyle = UIModalPresentationStyle.Popover
            imgPicker.popoverPresentationController?.sourceView = sender
            imgPicker.popoverPresentationController?.sourceRect = sender.bounds
            
            presentAlert(Alert)
            
            let camera = UIAlertAction(title: "Take a Photo", style: .Default) { (camera) -> Void in
                imgPicker.sourceType = .Camera
                self.presentViewController(imgPicker, animated: true, completion: nil)
            }
            
            let photoLibrary = UIAlertAction(title: "Choose from Library", style: .Default) { (Photolibrary) -> Void in
                
                imgPicker.sourceType = .PhotoLibrary
                self.presentViewController(imgPicker, animated: true, completion: nil)
                
            }
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
                Alert.addAction(camera)
            }
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
                Alert.addAction(photoLibrary)
            }
            Alert.addAction(cancelAction)
        }
    }
    
    public func presentAlert(sender: UIAlertController) {
        presentViewController(sender, animated: false, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
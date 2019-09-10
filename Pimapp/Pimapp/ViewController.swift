//
//  ViewController.swift
//  Pimapp
//
//  Created by Rakib Hasan Shayan on 22/7/19.
//  Copyright © 2019 Rakib Hasan Shayan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var loginInfo: LoginInfo?
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func loginPostAction(url: String, requestType: String, parameters: [String: Any]){
        let url = URL(string: url)
        var request = URLRequest(url: url!)
        request.setValue("appication/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = requestType
        
        let parameters = parameters
        //request.httpBody = parameters.percentEscaped().data(using: .utf8)
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data,
            let response = response as? HTTPURLResponse,
                error == nil else{    //// Check for fundamental networking error
                    print("Error:", error ?? "Unknown error")
                    return
            }
            guard (200 ... 299) ~= response.statusCode else{
                //check for http errors
                print("status should be 2xx, but is \(response.statusCode)")
                //print("response = \(response)")
                return
            }
//            let responseString = String(data: data, encoding: .utf8)
//            print("responseString = \(responseString)")
            do{
                let myData = try JSONDecoder().decode(LoginInfo.self, from: data)
                print(myData)
                self.loginInfo = myData
                print(self.loginInfo!.status_code)
                DispatchQueue.main.async {
                    if let myData = self.loginInfo{
                        print("Enter Segue block")
                        //set userDefaults
                        //UserDefaults.standard.set(myData, forKey: "loginInformation")
                        //set storyboad segue
                        self.performSegue(withIdentifier: "homePageSegue", sender: self)
                    }
                }
                
            }catch let jsonError{
                print("Error Serializing json: ",jsonError)
            }
        }
        task.resume()
    }
    
    @IBAction func loginActionBtn(_ sender: UIButton) {
        let url = "https://whatef.com/api/login"
        let requestType = "POST"
        
        if let userName = userNameTF.text, let password = passwordTF.text{
            let parameters: [String: Any] = [
                "username" : userName,
                "password" : password
            ]
            loginPostAction(url: url, requestType: requestType, parameters: parameters)
        }
        
    }
   
    
}


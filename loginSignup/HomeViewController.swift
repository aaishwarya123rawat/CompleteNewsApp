//
//  HomeViewController.swift
//  loginSignup
//
//  Created by apple on 10/22/18.
//  Copyright © 2018 apple. All rights reserved.
//


import UIKit
import Alamofire
import SlideMenuControllerSwift

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

  
    var sources:Sources?
    var source:[Source] = []
    var allSelectedSource:[String] = []
    var index = [Int]()
 
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var LogoutButtonLayout: UIButton!
    
    var collectionCellLayout: CollectionCellLayout!

    struct Sources: Decodable {
        var status:String?
        var sources: [Source]?
    }
    
    struct Source: Decodable {
        var id:String
        var name:String?
        var description:String?
         var url:String?
        var country:String?
        var category:String?
        var isSelectedSource:Bool = false
        
        private enum CodingKeys: String, CodingKey {
            case id
            case name
            case description
            case url
            case country
            case category
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionCellLayout = CollectionCellLayout(numberOfColumn: 3)
        collectionView.collectionViewLayout =  collectionCellLayout
        collectionView.reloadData()
        loadSources()

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu")!)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return source.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CellCollectionViewCell
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.cornerRadius = 4
        cell.layer.shadowColor = UIColor.gray.cgColor
        let cellDescription = source[indexPath.item]
        cell.title.text = cellDescription.name
        cell.checkImg.isHidden = !source[indexPath.item].isSelectedSource
        
        let lblNameInitialize = UILabel()
        lblNameInitialize.frame.size = CGSize.init(width: 40, height: 40)
        lblNameInitialize.layer.cornerRadius = 20
        lblNameInitialize.text = String((cell.title.text!.first!))
        lblNameInitialize.textColor = UIColor.white
        lblNameInitialize.textAlignment = NSTextAlignment.center
        lblNameInitialize.backgroundColor = pickColor(alphabet: cell.title.text!.first!)
        lblNameInitialize.isEnabled = true
        lblNameInitialize.clipsToBounds = true
   
        
        UIGraphicsBeginImageContext(lblNameInitialize.frame.size)
        lblNameInitialize.layer.render(in: UIGraphicsGetCurrentContext()!)
        cell.firstNameOfTitleImage.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return cell
    }
    
    func pickColor(alphabet: Character) -> UIColor {
        let alphabetColors = [ 0xEE2F41,  0xB2B7BB, 0x6FA9AB, 0xF5AF29, 0x0088B9, 0xF18636, 0xD93A37, 0xA6B12E, 0x5C9BBC, 0xF5888D, 0x9A89B5, 0x407887, 0x9A89B5, 0x5A8770, 0xD33F33, 0xA2B01F, 0xF0B126, 0x0087BF, 0xF18636, 0x0087BF, 0xB2B7BB, 0x72ACAE, 0x9C8AB4, 0x5A8770, 0xEEB424, 0x407887]

        let str = String(alphabet).unicodeScalars
        let unicode = Int(str[str.startIndex].value)
        if 65...90 ~= unicode {
//          let hex = alphabetColors[unicode - 65]
            let hex = alphabetColors.randomElement()
            return UIColor(red: CGFloat(Double((hex! >> 16) & 0xFF)) / 255.0, green: CGFloat(Double((hex! >> 8) & 0xFF)) / 255.0, blue: CGFloat(Double((hex! >> 0) & 0xFF)) / 255.0, alpha: 1.0)
        }
        return UIColor.white
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailNewsViewController") as! DetailNewsViewController
        
        vc.sourceID = source[indexPath.item].id
        print("vc.sourceID:\(vc.sourceID)")
        source[indexPath.item].isSelectedSource = !source[indexPath.item].isSelectedSource
        self.collectionView.reloadItems(at: [indexPath])
    }

    
    @IBAction func nextPageWithSelectedSource(_ sender: Any) {

        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailNewsViewController") as!                              DetailNewsViewController
        
        for selectedSource in source {
            if  selectedSource.isSelectedSource == true {
                allSelectedSource.append(selectedSource.id)
            }
        }
        vc.sourceIDs = allSelectedSource
        print(" vc.sourceIDs: \( vc.sourceIDs)")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func userloggedout(_ sender: Any) {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginNavigationController") as! UINavigationController
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDel.window?.rootViewController = loginVC
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
    
    
    func loadSources() {
        guard let url = URL(string: "https://newsapi.org/v2/sources?apiKey=4b28da7e32c047718042abf68f2f1df0") else { return }
        DispatchQueue.main.async {
            Alamofire.request(url,method: .get, parameters: ["sources": "true"]).validate()
                .responseJSON{ responce in guard responce.result.isSuccess else{
                    print("error")
                    return
                    }
                    switch responce.result{
                    case .success(_):
                        let json = responce.result.value
//                        print(json as Any)
                        
                        for aSource in (json as! [String:Any])["sources"] as! [Any]   {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: aSource, options: .prettyPrinted)
                            let reqJSONStr = String(data: jsonData, encoding: .utf8)
                            let data = reqJSONStr?.data(using: .utf8)
                            let jsonDecoder = JSONDecoder()
                            let aSource = try jsonDecoder.decode(Source.self, from:data!)
                            self.source.append(aSource)
//                            print(self.source)
                            self.collectionView.reloadData()
                        }
                        catch {
                            print(error)
                        }
                            
                    }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
            }.resume()
        }
    }
}


extension HomeViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
}



//
//  DetailNewsViewController.swift
//  loginSignup
//
//  Created by apple on 10/26/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import Alamofire
import SlideMenuControllerSwift

class DetailNewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var tableView: UITableView!


    var news:News?
    var article:[ArticleDes] = []
    var sourceID:String = ""
    var sourceIDs:[String] = []
    var selectedUserSource:User?
    
    struct News: Decodable {
        let status: String?
        let totalResults: Int?
        let articles: [ArticleDes]?
    }
    struct ArticleDes: Decodable {
        let source: sourceDes?
        let author: String?
        let title: String?
        let descriprion: String?
        let url: String?
        let urlToImage: String?
        let publishedAt: String?
        let content: String?
    }
    
    struct  sourceDes: Decodable {
        let id: String?
        let name: String?
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//            self.tableView.rowHeight = 300
//    navigationController?.navigationBar.prefersLargeTitles = true
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu")!)
        print()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataSave().saveSourceForSelectedUser(userSource: sourceIDs)
        let userSource = UserData.shared.userInformation
        if (userSource?.selectedSource == nil){
            let sources:[ String] = sourceIDs
            let allSources = sources.joined(separator: ",")
            loadData(allSources: allSources)
            print("sourceIDsInLoadData:\(String(describing: sources))")
        }
        else{
            let source = userSource?.selectedSource
            let allSources = source?.joined(separator: ",")
            loadData(allSources: allSources ?? "" )
            print("sourceIDs:\(String(describing: source))")
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return article.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myIndex = (indexPath.row % 5)
        let returnCell = tableView.dequeueReusableCell(withIdentifier: "detailViewCell") as! DetailViewCellTableViewCell
        
        if (myIndex == 0 ){
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailViewCell") as! DetailViewCellTableViewCell
            let articleDescription = article[indexPath.row]
            cell.title.text = articleDescription.title
            cell.source.text = articleDescription.source?.name
            cell.titleImage.downloadImage(from: ((articleDescription.urlToImage ?? "")))
            cell.titleImage.layer.cornerRadius = 5.0
            cell.backgroundCardView.backgroundColor = UIColor.white
            cell.backgroundColor = UIColor(red: 238/250.0, green: 238/250.0, blue: 238/250.0, alpha: 1.0)
            cell.backgroundCardView.layer.cornerRadius = 5.0
            cell.backgroundCardView.layer.masksToBounds = false
            cell.backgroundCardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
            cell.backgroundCardView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            cell.backgroundCardView.layer.shadowOpacity = 0.8
            tableView.rowHeight = 340
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "smallCell") as! SmallViewTableViewCell
            let articleDescription = article[indexPath.row]
            cell.smallCellTitleLbl.text = articleDescription.title
            cell.smallCellTitleLbl.text = articleDescription.title
            cell.smallCellSourceLbl.text = articleDescription.source?.name
            cell.samallCellImg.downloadImage(from: ((articleDescription.urlToImage ?? "")))
            cell.samallCellImg.layer.cornerRadius = 5.0
            cell.samllCellCardViewBgLbl.backgroundColor = UIColor.white
            cell.backgroundColor = UIColor(red: 238/250.0, green: 238/250.0, blue: 238/250.0, alpha: 1.0)
            cell.samllCellCardViewBgLbl.layer.cornerRadius = 5.0
            cell.samllCellCardViewBgLbl.layer.masksToBounds = false
            cell.samllCellCardViewBgLbl.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
            cell.samllCellCardViewBgLbl.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            cell.samllCellCardViewBgLbl.layer.shadowOpacity = 0.8
            tableView.rowHeight = 150
            return cell
            
        }
        return returnCell
    }

    func loadData(allSources : String ) {
        
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=bitcoin&apiKey=4b28da7e32c047718042abf68f2f1df0&sources=\(String(describing: allSources))") else { return }
        DispatchQueue.main.async {
            Alamofire.request(url,method: .get, parameters: ["articles": "true"]).validate()
                .responseJSON{ responce in guard responce.result.isSuccess else{
                    print("error")
                    return
                    }
                    switch responce.result{
                    case .success(_):
                        let json = responce.result.value
//                        print(json as Any)
                        
                        for aArticle in (json as! [String:Any])["articles"] as! [Any]   {
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: aArticle, options: .prettyPrinted)
                                let reqJSONStr = String(data: jsonData, encoding: .utf8)
                                let data = reqJSONStr?.data(using: .utf8)
                                let jsonDecoder = JSONDecoder()
                                let aArticle = try jsonDecoder.decode(ArticleDes.self, from:data!)
                                self.article.append(aArticle)
                                 print(self.article)
                                self.tableView.reloadData()
                            }
                            catch {
                            }
                            
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }.resume()
        }
    }
}

extension UIImageView {
    func downloadImage(from url: String){
        if let url = URL(string: url){
            let urlRequest = URLRequest(url:url)
            URLSession.shared.dataTask(with:urlRequest){(data, response, error) in
                DispatchQueue.main.async {
                    if  error != nil {
                        print("Faild to get data:", error!)
                        return
                    }
                    self.image = UIImage(data:data!)
                }
                }.resume()
            
        }
    }
}

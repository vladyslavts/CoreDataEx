//
//  TableViewController.swift
//  Img
//
//  Created by Vlad on 28.07.17.
//  Copyright © 2017 Vlad. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let context = AppDelegate.viewContext
    
    
    var posts = [Post]()
    
    @IBAction func addPost(_ sender: UIBarButtonItem) {
    
        let imgPicker = UIImagePickerController()
        imgPicker.sourceType = .photoLibrary
        imgPicker.delegate = self
        present(imgPicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            dismiss(animated: true, completion: { 
                self.createPost(with: image)
            })
        }
        
    }
    
    func createPost(with image: UIImage) {
        let post = Post(context: context)
        post.photo = NSData(data: UIImageJPEGRepresentation(image, 0)!)
        saveData()
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            loadData()
        print(posts.count)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return  1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        if let img = posts[indexPath.row].photo {
            cell.img.image = UIImage(data: img as Data)
        }
        
        
        return cell
    }
    
    func loadData() {
        let postsRequest: NSFetchRequest<Post> = Post.fetchRequest()
        
        do {
            posts = try context.fetch(postsRequest)
            tableView.reloadData()
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func saveData() {
        do {
            try context.save()
            print("SAVED")
        } catch  {
            print(error.localizedDescription)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            context.delete(posts[indexPath.row])

            posts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)

            saveData()
            //loadData()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    

}

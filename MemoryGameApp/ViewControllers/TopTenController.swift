//
//  TopTenController.swift
//  MemoryGameApp
//
//  Created by user196684 on 5/29/21.
//

import UIKit
import MapKit

class TopTenController: UIViewController {

    @IBOutlet weak var highscoresTable: UITableView!
    @IBOutlet weak var ttMap: MKMapView!
    @IBOutlet weak var tt_BTN_back: UIButton!
    var topTenManager = TopTenManager()
    var highscores: [Record] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        highscoresTable.delegate = self
        highscoresTable.dataSource = self
        
        highscores = topTenManager.getHighscores() as [Record]

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension TopTenController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Click on row \(indexPath)")
        if(indexPath.row < highscores.count){
            let record = highscores[indexPath.row]
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: record.lat, longitude: record.lng)
            annotation.title = "\(indexPath.row + 1). \(record.name)"
            ttMap.addAnnotation(annotation)
            let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
            ttMap.setRegion(region, animated: true)
        }
        
    }
}

extension TopTenController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighscoreCell", for: indexPath)
        if(indexPath.row < highscores.count){
            let record = highscores[indexPath.row]
            let time = record.time
            let hours = time / 3600
            let minutes = time / 60 % 60
            let seconds = time % 60
            cell.textLabel?.text = "\(indexPath.row + 1). \(record.name) - \(String(format: "%02i:%02i:%02i", hours, minutes, seconds))\nLocation: \(record.lng),\(record.lat)"
            cell.textLabel?.numberOfLines = 2
        }
        return cell
    }
    

}

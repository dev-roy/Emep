//
//  CalendarViewController.swift
//  Emep
//
//  Created by Hugo Flores Perez on 5/27/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import TimelineTableViewCell
import UIKit

class CalendarViewController: UITableViewController {

    private let timelineViewModel = TimelineViewModel()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setUpDataBinding()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpDataBinding() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let bundle = Bundle(for: TimelineTableViewCell.self)
        let nibUrl = bundle.url(forResource: "TimelineTableViewCell", withExtension: "bundle")
        let timelineTableViewCellNib = UINib(nibName: "TimelineTableViewCell",
        bundle: Bundle(url: nibUrl!)!)
        tableView.register(timelineTableViewCellNib, forCellReuseIdentifier: "TimelineTableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return timelineViewModel.getNumberOfYears()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timelineViewModel.getNumberOfAppointments(forSection: section)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Day " + String(describing: section + 1)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineTableViewCell", for: indexPath) as? TimelineTableViewCell else {
            return UITableViewCell()
        }

        let cellViewModel = timelineViewModel.getAppointment(forIndexPath: indexPath)
        cell.timelinePoint = TimelinePoint()
        cell.timeline.frontColor = .clear
        cell.timeline.backColor = .black
        cell.titleLabel.text = cellViewModel.title
        cell.descriptionLabel.text = cellViewModel.description
        cell.lineInfoLabel.text = "Line info Label"
        /*
        let (timelinePoint, timelineBackColor, title, description, lineInfo, thumbnails, illustration) = sectionData[indexPath.row]
        var timelineFrontColor = UIColor.clear
        if (indexPath.row > 0) {
            timelineFrontColor = sectionData[indexPath.row - 1].1
        }
        cell.timelinePoint = timelinePoint
        cell.timeline.frontColor = timelineFrontColor
        cell.timeline.backColor = timelineBackColor
        cell.titleLabel.text = title
        cell.descriptionLabel.text = description
        cell.lineInfoLabel.text = lineInfo
        
        if let thumbnails = thumbnails {
            cell.viewsInStackView = thumbnails.map { thumbnail in
                return UIImageView(image: UIImage(named: thumbnail))
            }
        }
        else {
            cell.viewsInStackView = []
        }
        
        if let illustration = illustration {
            cell.illustrationImageView.image = UIImage(named: illustration)
        }
        else {
            cell.illustrationImageView.image = nil
        }
        */
        return cell
    }
}

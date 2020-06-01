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
        tableView.tableFooterView = UIView()
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 36
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return timelineViewModel.getNumberOfYears()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timelineViewModel.getNumberOfAppointments(forSection: section)
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = .zero
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        label.text = timelineViewModel.getHeaderStringForSection(section)
        label.font = UIFont.systemFont(ofSize: 32)
        label.textAlignment = .center
        label.addToAndFill(parent: view)
        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineTableViewCell", for: indexPath) as? TimelineTableViewCell else {
            return UITableViewCell()
        }

        let cellViewModel = timelineViewModel.getAppointment(forIndexPath: indexPath)
        cell.timelinePoint = TimelinePoint(diameter: 16.0, lineWidth: 4.0, color: UIColor(red: 0, green: 173, blue: 184, alpha: 1), filled: true)
        cell.timeline = Timeline(width: 4.0, frontColor: .gray, backColor: .gray)
        cell.timeline.frontColor = cellViewModel.isTop ? .clear : .systemGray3
        cell.timeline.backColor = cellViewModel.isBottom ? .clear : .systemGray3

        let textContent = cellViewModel.getTitle()

        cell.titleLabel.text = textContent.title
        cell.descriptionLabel.text = textContent.description
        
        var imageResName = "ADN"
        switch cellViewModel.getAppointmentType() {
        case .fracture: imageResName = "Silla-ruedas"
        case .checkup: imageResName = "Check"
        case .operation: imageResName = "Telefono-beat"
        case .vaccine: imageResName = "Jeringa"
        default: break
        }

        if cellViewModel.getAppointmentType() != .undefined {
            cell.imageView?.image = UIImage(imageLiteralResourceName: imageResName)
            cell.imageView?.contentMode = .scaleAspectFit
            cell.imageView?.constrainToVerticalCenterAndLeading(leadingInset: 12)
            cell.imageView?.constraintToSize(width: 40, height: 40)
        }
        return cell
    }
}

//
//  CalendarViewController.swift
//  Emep
//
//  Created by Hugo Flores Perez on 5/27/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import JTAppleCalendar
import TimelineTableViewCell
import UIKit

class CalendarViewController: UIViewController {

    private let viewModel = CalendarViewModel()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendarView: JTACMonthView!
    @IBOutlet weak var calendarContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        setUpDataBinding()
        setUpCalendar()
    }
    
    private func setUpDataBinding() {
        viewModel.presentTimelineHandler = displayTimeline
        viewModel.presentCalendarHandler = displayCalendar
        viewModel.reloadCalendarDatesHandler = calendarView.reloadDates
    }
    
    private func displayTimeline() {
        tableView.isHidden = false
        calendarContainerView.isHidden = true
    }
    
    private func displayCalendar() {
        tableView.isHidden = true
        calendarContainerView.isHidden = false
    }
    
    private func setUpTable() {
        let bundle = Bundle(for: TimelineTableViewCell.self)
        let nibUrl = bundle.url(forResource: "TimelineTableViewCell", withExtension: "bundle")
        let timelineTableViewCellNib = UINib(nibName: "TimelineTableViewCell",
        bundle: Bundle(url: nibUrl!)!)
        tableView.register(timelineTableViewCellNib, forCellReuseIdentifier: "TimelineTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 10
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setUpCalendar() {
        calendarView.calendarDataSource = self
        calendarView.calendarDelegate = self
        calendarView.scrollingMode = .stopAtEachCalendarFrame
    }

    @IBAction func onSegmentedControlChanged(_ sender: Any) {
        viewModel.onSegmentedControlChanged(input: segmentedControl.selectedSegmentIndex)
    }
}

extension CalendarViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = .zero
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        label.text = viewModel.timelineViewModel.getHeaderStringForSection(section)
        label.font = UIFont.systemFont(ofSize: 32)
        label.textAlignment = .center
        label.addToAndFill(parent: view)
        return view
    }
}

extension CalendarViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.timelineViewModel.getNumberOfYears()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.timelineViewModel.getNumberOfAppointments(forSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineTableViewCell", for: indexPath) as? TimelineTableViewCell else {
            return UITableViewCell()
        }

        let cellViewModel = viewModel.timelineViewModel.getAppointment(forIndexPath: indexPath)
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

extension CalendarViewController: JTACMonthViewDataSource {
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let timeFrame = viewModel.timelineViewModel.getAppointmentsTimeframe()
        let startDate = timeFrame.startDate
        let endDate = timeFrame.endDate
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }
}

extension CalendarViewController: JTACMonthViewDelegate {
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        guard let cell = cell as? DateCell else { return }
        cell.setUpFor(cellState: cellState)
        cell.set(hasAppointments: viewModel.timelineViewModel.doesDateCellHasAppointments(date: cell))
        cell.set(selected: viewModel.isDateSelected(cellState.date))
    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        guard let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: DateCell.reuseIdentifier, for: indexPath) as? DateCell
            else { return JTACDayCell() }
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        let visibleDates = calendarView.visibleDates()
        calendarView.viewWillTransition(to: .zero, with: coordinator, anchorDate: visibleDates.monthDates.first?.date)
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        guard let cell = cell as? DateCell else { return }
        viewModel.setSelectedDate(cellState.date)
        cell.set(selected: true)
    }
    
    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        guard let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: DateHeader.reuseIdentifier, for: indexPath) as? DateHeader else { fatalError() }
        header.headerLabel.text = viewModel.getHeaderTitleFor(indexPath: indexPath)
        return header
    }
    
    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return MonthSize(defaultSize: 50)
    }
}

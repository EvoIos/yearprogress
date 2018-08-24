//
//  ViewController.swift
//  YearProgress
//
//  Created by z on 2018/8/17.
//  Copyright © 2018年 Pace.Z. All rights reserved.
//

import UIKit
import YearProgressFramework

class ViewController: UIViewController {
	
	@IBOutlet weak var containerView: UIView!
	
	@IBOutlet weak var yearProgressLabel: UILabel!
	
	let appGroupIdentifier = "group.zlanchun.yearprogress"
	let	resourceFile = "YearProgress"
	let helper = YearProgressHelper()
	var fileCoordinator: NSFileCoordinator {
		let fileCoordinator = NSFileCoordinator()
		fileCoordinator.purposeIdentifier = "zlchun.providerIdentifier"
		return fileCoordinator
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		configResouce()
	}
	
	func setupView() {
		containerView.layer.cornerRadius = 5
		containerView.layer.shadowColor = UIColor.black.cgColor
		containerView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
		containerView.layer.shadowOpacity = 0.2
		containerView.layer.shadowRadius = 4.0
		
		if let url = self.originalFileURL(),
			let progress = helper.yearprogress(resourcOf: url) {
			yearProgressLabel.text = progress
		}
	}
	
	func configResouce() {
		guard let groupContainerURL = helper.appGroupContainerURL(with: appGroupIdentifier) else {
			return
		}
		let fileURL = helper.fileURL(baseURL: groupContainerURL, name: resourceFile)
		if	FileManager.default.fileExists(atPath: fileURL.path) {
			return
		}
		fileCoordinator.coordinate(writingItemAt: fileURL, options: NSFileCoordinator.WritingOptions(), error: nil, byAccessor: { newURL in
			do {
				let data = try Data(contentsOf: self.originalFileURL()!, options: Data.ReadingOptions())
				FileManager.default.createFile(atPath: newURL.path, contents: data, attributes: nil)
			}
			catch {
				print(error)
			}
		})
	}
	
	func originalFileURL() -> URL? {
		return Bundle.main.url(forResource: "YearProgress", withExtension: "plist")
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}


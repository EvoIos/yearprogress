//
//  TodayViewController.swift
//  YearProgressExtension
//
//  Created by z on 2018/8/17.
//  Copyright © 2018年 Pace.Z. All rights reserved.
//

import UIKit
import NotificationCenter
import YearProgressFramework

class TodayViewController: UIViewController, NCWidgetProviding {
        
	@IBOutlet weak var yearProgressLabel: UILabel!
	
	let appGroupIdentifier = "group.zlanchun.yearprogress"
	let	resourceFile = "YearProgress"
	
	var fileCoordinator: NSFileCoordinator {
		let fileCoordinator = NSFileCoordinator()
		fileCoordinator.purposeIdentifier = "zlchun.providerIdentifier"
		return fileCoordinator
	}
	
	let helper = YearProgressHelper()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		yearProgressLabel.text = ""
				
		guard let documentFilePathURL = documentFilePathURL() else {
			return
		}
		fileCoordinator.coordinate(readingItemAt: documentFilePathURL, options: NSFileCoordinator.ReadingOptions(), error: nil) { (newURL) in
			if let progress = helper.yearprogress(resourcOf: newURL) {
				self.yearProgressLabel.text = progress
			}
		}
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
		
		guard let documentFilePathURL = documentFilePathURL() else {
			return
		}
		fileCoordinator.coordinate(readingItemAt: documentFilePathURL, options: NSFileCoordinator.ReadingOptions(), error: nil) { (newURL) in
			if let progress = helper.yearprogress(resourcOf: newURL) {
				self.yearProgressLabel.text = progress
			}
		}
		
        completionHandler(NCUpdateResult.newData)
    }
	
	func documentFilePathURL() -> URL? {
		guard let groupContainerURL = helper.appGroupContainerURL(with: appGroupIdentifier) else {
			return nil
		}
		return helper.fileURL(baseURL: groupContainerURL, name: resourceFile)
	}
    
}

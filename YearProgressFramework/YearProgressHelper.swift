//
//  YearProgressHelper.swift
//  YearProgressFramework
//
//  Created by z on 2018/8/23.
//  Copyright © 2018年 Pace.Z. All rights reserved.
//

import UIKit

public class YearProgressHelper {
	
	private let directoryName = "File Provider Storage"
	
	private let formatter = DateFormatter()
	
	private var currentDay: String {
		return formatter.string(from: Date())
	}
	
	public init() {
		formatter.dateFormat = "MM-dd"
	}
	
	open func yearprogress(resourcOf url: URL) -> String? {
		guard let progressDic = NSDictionary(contentsOf: url) as? [String: String] else {
			return nil
		}
		return progressDic[currentDay]
	}
	
	open func appGroupContainerURL(with identifier: String) -> URL? {
		
		let fileManager = FileManager.default
		guard let groupURL = fileManager
			.containerURL(forSecurityApplicationGroupIdentifier: identifier) else {
				return nil
		}
		let storageDirectoryUrl = groupURL.appendingPathComponent(directoryName)
		
		if !fileManager.fileExists(atPath: storageDirectoryUrl.path) {
			do {
				try fileManager.createDirectory(atPath: storageDirectoryUrl.path,
												withIntermediateDirectories: false,
												attributes: nil)
			} catch let error {
				print("error creating filepath: \(error)")
				return nil
			}
		}
		
		return storageDirectoryUrl
	}
	
	open func fileURL(baseURL URL: URL, name: String, _ extensionName: String = "plist") -> URL {
		let protectedName: String
		if name.isEmpty {
			protectedName = "Untitled"
		} else {
			protectedName = name
		}
		return URL.appendingPathComponent(protectedName).appendingPathExtension(extensionName)
	}
}

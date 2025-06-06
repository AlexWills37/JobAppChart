//
//  ApplicationInfo.swift
//  JobAppChart
//
//  Created by alex w on 6/5/25.
//
import GRDB

/// Joint record containing an Application and its Status.
struct ApplicationInfo: Decodable, FetchableRecord {
    var application: Application
    var status: Status
}

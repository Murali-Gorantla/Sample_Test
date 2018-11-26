//
//  MaterViewControllerTests.swift
//  TLI TestTests
//
//  Created by Murali Gorantla on 23/11/18.
//  Copyright © 2018 Murali Gorantla. All rights reserved.
//

import XCTest
@testable import TLITest

class MaterViewControllerTests: XCTestCase {
    
    var masterViewController: MasterViewController!
    var tableView: UITableView!
    var dataSource: UITableViewDataSource!
    var delegate: UITableViewDelegate!
    var newsData: [News] = []
    
    var jsonData = """
    {
    "status":"OK",
    "copyright":"Copyright (c) 2018 The New York Times Company. All Rights Reserved.",
    "num_results":1743,
    "results":[
    {
    "url":"https://www.nytimes.com/2018/11/14/technology/facebook-data-russia-election-racism.html",
    "adx_keywords":"Facebook Inc;Russian Interference in 2016 US Elections and Ties to Trump Associates;Data-Mining and Database Marketing;Sandberg, Sheryl K;Zuckerberg, Mark E;Rumors and Misinformation;Cyberwarfare and Defense;Privacy;United States Politics and Government;Political Advertising",
    "column":null,
    "section":"Technology",
    "byline":"By SHEERA FRENKEL, NICHOLAS CONFESSORE, CECILIA KANG, MATTHEW ROSENBERG and JACK NICAS",
    "type":"Article",
    "title":"Delay, Deny and Deflect: How Facebook  Leaders Fought Through Crisis",
    "abstract":"Russian meddling, data sharing, hate speech  the social network faced one scandal after another. This is how Mark Zuckerberg and Sheryl Sandberg responded.",
    "published_date":"2018-11-14",
    "source":"The New York Times",
    "id":100000006151342,
    "asset_id":100000006151342,
    "views":1,
    "des_facet":[
    "RUSSIAN INTERFERENCE IN 2016 US ELECTIONS AND TIES TO TRUMP ASSOCIATES",
    "RUMORS AND MISINFORMATION",
    "PRIVACY"
    ],
    "org_facet":[
    "FACEBOOK INC",
    "DATA-MINING AND DATABASE MARKETING",
    "CYBERWARFARE AND DEFENSE",
    "UNITED STATES POLITICS AND GOVERNMENT",
    "POLITICAL ADVERTISING"
    ],
    "per_facet":[
    "SANDBERG, SHERYL K",
    "ZUCKERBERG, MARK E"
    ],
    "geo_facet":"",
    "media":[
    {
    "type":"image",
    "subtype":"photo",
    "caption":"Under Mark Zuckerberg, the founder, and Sheryl Sandberg, the chief operating officer, Facebook has gone on the attack amid mounting scandals.",
    "copyright":"The New York Times",
    "approved_for_syndication":1,
    "media-metadata":[
    {
    "url":"https://static01.nyt.com/images/2018/11/15/business/15facebookdip-promo/15facebookdip-promo-square320.jpg",
    "format":"square320",
    "height":320,
    "width":320
    },
    {
    "url":"https://static01.nyt.com/images/2018/11/15/business/15facebookdip-promo/15facebookdip-promo-thumbStandard.jpg",
    "format":"Standard Thumbnail",
    "height":75,
    "width":75
    },
    {
    "url":"https://static01.nyt.com/images/2018/11/15/business/15facebookdip-promo/15facebookdip-promo-articleInline.jpg",
    "format":"Normal",
    "height":133,
    "width":190
    },
    {
    "url":"https://static01.nyt.com/images/2018/11/15/business/15facebookdip-promo/15facebookdip-promo-sfSpan.jpg",
    "format":"Large",
    "height":263,
    "width":395
    },
    {
    "url":"https://static01.nyt.com/images/2018/11/15/business/15facebookdip-promo/15facebookdip-promo-jumbo.jpg",
    "format":"Jumbo",
    "height":716,
    "width":1024
    },
    {
    "url":"https://static01.nyt.com/images/2018/11/15/business/15facebookdip-promo/15facebookdip-promo-superJumbo.jpg",
    "format":"superJumbo",
    "height":1433,
    "width":2048
    },
    {
    "url":"https://static01.nyt.com/images/2018/11/15/business/15facebookdip-promo/15facebookdip-promo-square640.jpg",
    "format":"square640",
    "height":640,
    "width":640
    },
    {
    "url":"https://static01.nyt.com/images/2018/11/15/business/15facebookdip-promo/15facebookdip-promo-thumbLarge.jpg",
    "format":"Large Thumbnail",
    "height":150,
    "width":150
    },
    {
    "url":"https://static01.nyt.com/images/2018/11/15/business/15facebookdip-promo/15facebookdip-promo-mediumThreeByTwo210.jpg",
    "format":"mediumThreeByTwo210",
    "height":140,
    "width":210
    },
    {
    "url":"https://static01.nyt.com/images/2018/11/15/business/15facebookdip-promo/15facebookdip-promo-mediumThreeByTwo440.jpg",
    "format":"mediumThreeByTwo440",
    "height":293,
    "width":440
    }
    ]
    }
    ]}]}
    """.data(using: .utf8)!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        guard let splitViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? UISplitViewController else {
            return XCTFail("Could not instantiate ViewController from main storyboard")
        }
        
        guard let navigationController = splitViewController.viewControllers.first as? UINavigationController else {
            return XCTFail("Could not instantiate ViewController from main storyboard")
        }
        
        guard let controller = navigationController.topViewController as? MasterViewController else {
            return XCTFail("Could not instantiate ViewController from main storyboard")
        }
        masterViewController = controller
        masterViewController.loadViewIfNeeded()
        tableView = masterViewController.tableView
        
        guard let ds = tableView.dataSource as? UITableViewDataSource else {
            return XCTFail("Controller's table view should have a UITableViewDataSource")
        }
        
        dataSource = ds
        delegate = tableView.delegate
        do {
             newsData = try JSONDecoder().decode([News].self, from: jsonData, keyPath: "results")
            XCTAssertEqual(newsData[0].title, "Delay, Deny and Deflect: How Facebook  Leaders Fought Through Crisis")
        } catch {
            return XCTFail("Decoding error issue")
        }
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        masterViewController = nil
        tableView = nil
        dataSource = nil
        delegate = nil
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testTableViewHasCells() {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseIdentifier)
        
        XCTAssertNotNil(cell,
                        "TableView should be able to dequeue cell with identifier: \(NewsTableViewCell.reuseIdentifier)")
    }
    
    func testViewConformsToTableViewDataSource() {
        
        XCTAssertTrue(tableView.dataSource === masterViewController,
                      "View does not conform to UITableView datasource protocol")
    }
    
    func testTableViewDelegateIsViewController() {
        XCTAssertTrue(tableView.delegate === masterViewController,
                      "MasterViewController should be delegate for the table view")
    }
    
    func testTheTableViewHasDataSource() {
        XCTAssertNotNil(masterViewController.tableView.dataSource, "Table datasource cannot be nil")
    }
    
    func testTableViewNumberOfRowsInSection() {
        let expectedRows: Int = 0
        let numberOfRows = self.masterViewController.tableView(self.tableView, numberOfRowsInSection: 0)
        XCTAssertTrue(self.masterViewController.tableView(self.tableView, numberOfRowsInSection: 0) == expectedRows, "Table has \(numberOfRows) rows but it should have \(expectedRows)")
    }
    
    func testTableViewCellCreateCellsWithReuseIdentifier() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = masterViewController.tableView(tableView, cellForRowAt: indexPath) as! NewsTableViewCell
        let expectedReuseIdentifier = String(format: "%ld/%ld", indexPath.section, indexPath.row)
        XCTAssertTrue((cell.reuseIdentifier == expectedReuseIdentifier), "Table does not create reusable cells")
    }
    
}

//
//  FollowerListViewController.swift
//  GithubFollowers
//
//  Created by Jaldeep Patel on 2022-02-04.
//

import UIKit

class FollowerListViewController: UIViewController {


    var userName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

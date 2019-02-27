//
//  FirebaseManager.swift
//
//  Created by Chris Coffin on 9/12/18.
//  Copyright © 2018 Chris Coffin. All rights reserved.
//





import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

class FirebaseManager {

	// Prevent clients from creating another instance
	private init() {}

	// Create shared instance
	static let sharedManager = FirebaseManager()
	
	// Create shared database reference
	lazy var dbReference: DatabaseReference = {
		return Database.database().reference()
	}()

	// Create shared child reference
	lazy var logEntriesReference: DatabaseReference = {
		return Database.database().reference().child("/logEntries")
	}()
	
	// Post notification when logEntries is updated
	private (set) var logEntries: [DataSnapshot]? {
		didSet {
			NotificationCenter.default.post(name: NSNotification.Name(rawValue: "firebaseDataDidUpdateNotification"), object: nil)
		}
	}

	// Firebase listener handle
	var observer: AuthStateDidChangeListenerHandle?
	
	// Checks whether user is logged in
	func checkLoginStatus() {
		Auth.auth().addStateDidChangeListener { (auth, user) in
			if user == nil {
				self.login()
			}
		}
	}

	// Log user in
	func login() {
		let email = ""
		let password = ""
		Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
			print(authResult!.description)
			print(authResult!.debugDescription)
			print(authResult!.additionalUserInfo.debugDescription)
		}
	}

	// Start observing update .childAdded events
	func claimObserver() {
		self.observer = Auth.auth().addStateDidChangeListener() { (auth, user) in
			var entries: [DataSnapshot] = []
			self.childReference.observe(.childAdded, with: { snapshot in
				if snapshot.hasChildren() {
					entries.append(snapshot)
				}
				self.logEntries = entries
			})
		}
	}
	
	// Release database observer
	func releaseObserver() {
		if self.observer != nil {
			Auth.auth().removeStateDidChangeListener(self.observer!)
			self.observer = nil
		}
	}

}

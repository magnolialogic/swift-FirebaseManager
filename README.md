# FirebaseManager
Firebase Realtime Database manager for Swift 4.2


Import FirebaseManager.swift into your Xcode project to easily work with Firebase Realtime Database across multiple View Controllers. `FirebaseManager.sharedManager` provides a single shared Firebase Realtime Database interface as well as convenience references and functions for common actions. This example code is configured for email/password-based login, to access and observe a "log entries" child node, and post notifications to NotificationCenter on update.


`.sharedManager`<br>
`.sharedManager.dbReference`<br>
`.sharedManager.logEntriesReference`<br>
`.sharedManager.logEntries`<br>
`.sharedManager.observer`<br>
`.sharedManager.checkLoginStatus()`<br>
`.sharedManager.login()`<br>
`.sharedManager.claimObserver()`<br>
`.sharedManager.releaseObserver()`

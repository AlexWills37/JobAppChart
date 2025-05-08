//
//  NotificationService.swift
//  JobAppChart
//
//  Created by Alex on 5/8/25.
//
import UserNotifications

class NotificationService {
    static let shared = NotificationService()
    
    private let center = UNUserNotificationCenter.current()
    private var authorized = false
    
    private init() {
        
    }
    
    func requestPermissions() async -> Bool{
        do {
            try await center.requestAuthorization(options: [.badge, .alert])
        } catch {
            print("Error: \(error)")
        }
        let settings = await center.notificationSettings()
        return settings.alertSetting == .enabled
    }
    
    func scheduleNotification(title: String, body: String, date: DateComponents, id: String) async {
        let settings = await center.notificationSettings()
        guard (settings.authorizationStatus == .authorized) else { return }
        if (settings.alertSetting == .enabled) {
            
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
            
            do {
                try await center.add(request)
                print("Added notification:" )
                print(trigger.description)
            } catch {
                print("Error adding notification: \(error)")
            }
            
        }
    }
    
    func cancelNotification(_ id: String) {
        center.removePendingNotificationRequests(withIdentifiers: [id])
    }
    
    func isNotificationPending(_ id: String) async -> Bool {
        let requests = await center.pendingNotificationRequests()
        printNotifications()
        return requests.contains { request in
            request.identifier == id
        }
    }
    func printNotifications() {
        Task {@MainActor in
            let requests = await center.pendingNotificationRequests()
            
            for request in requests {
                print (request.description)
            }
        }
    }
}

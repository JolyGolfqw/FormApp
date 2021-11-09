//
//  Notification.swift
//  formApp
//
//  Created by MacBook Pro on 07.04.2021.
//

import UIKit
import UserNotifications

final class LocalNotificationManager {

    // MARK: - Property
    var notifications: [Notifications] = []

    // MARK: - List Schdeuled Notification
    func listScheduledNotification() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            for notification in notifications {
                print(notification)
            }
        }
    }

    // MARK: - Request Authorization
    private func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in

            if granted == true && error == nil {
                self.scheduleNotifications()
            }
        }
    }

    // MARK: - Schedule
    func schedule() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in

            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization()
            case .authorized, .provisional:
                self.scheduleNotifications()
            default: break
            }
        }
    }

    // MARK: - Schedule Notifications
    private func scheduleNotifications() {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.body = notification.message
            content.sound = .default
        
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 172800, repeats: true)

            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else { return }

                print("Notification scheduled! --- ID = \(notification.id)")
            }
        }
    }
}



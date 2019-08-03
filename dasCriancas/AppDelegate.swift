//
//  AppDelegate.swift
//  dasCriancas
//
//  Created by Cassia Aparecida Barbosa on 27/06/19.
//  Copyright © 2019 Cassia Aparecida Barbosa. All rights reserved.
//


//está com problema nas animações quando ativa do background, storyView acaba a animação e relaxView não para o cronômetro
// contador de notificações
// balao está caindo



import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    private static var _count: Int = 0
    public static var numNotifications: Int {
        get {
            _count += 1
            return _count
        }
    }
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if !UserDefaults.standard.bool(forKey: "didSee") { //identificador da acao
            UserDefaults.standard.set(true, forKey: "didSee")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "infoScreen1") //identificador da tela que nao deve apareecr nas outras vezes
            
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
        }
        
        
        let notificationCenter = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert,.sound,.badge]
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("Notifications not allowed by user")
            }
        }
        notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                DispatchQueue.main.async {
                    let contentSundayNotification = UNMutableNotificationContent()
                    contentSundayNotification.sound = UNNotificationSound.default
                    contentSundayNotification.title = "Crie histórias e relaxe com sua criança!"
                    contentSundayNotification.body = "Você já tirou um tempinho para interagir com seu filho nesses últimos dias? O das Crianças pode ajudar."
                    contentSundayNotification.badge = AppDelegate.numNotifications as NSNumber
                    var dateComponentsSundayNotification = DateComponents()
                    
                    dateComponentsSundayNotification.hour = 18
                    dateComponentsSundayNotification.minute = 00
                    dateComponentsSundayNotification.weekday = 1
                    
                    let triggerSundayNotification = UNCalendarNotificationTrigger(dateMatching: dateComponentsSundayNotification, repeats: true)
                    
                    let sundayNotification = UNNotificationRequest(identifier: "sundayNotification", content: contentSundayNotification, trigger: triggerSundayNotification)
                    
                    let addSundayNotification = UNUserNotificationCenter.current()
                    addSundayNotification.add(sundayNotification) { (error : Error?) in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                    }
    
                }
            }
                
                
                
            else {
                print ("Impossivel mandar notificação para o usuário.")
            }
        }
        
    return true
            
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {

        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
//         UIApplication.shared.applicationIconBadgeNumber = 0

        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    

    func applicationDidBecomeActive(_ application: UIApplication) {
       UIApplication.shared.applicationIconBadgeNumber = 0
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext ()
    }

    // MARK: - Core Data stack

var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "dasCriancas")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    

}

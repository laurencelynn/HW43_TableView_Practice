//
//  SettingViewController.swift
//  HW43_TableView_Practice
//
//  Created by 林上閔 on 4/19/25.
//

import UIKit

// MARK: - 設定畫面
class SettingsViewController: UITableViewController {
    
    // 每個 section 的標題
    let sectionTitles = ["Network", "System", "Storage", "Cloud"]

    // 每個 section 對應的 cell 資料
    let sections: [[SettingItem]] = [
        [ // Section 0 - Network
            SettingItem(title: "Wi-Fi", iconName: "wifi", isSwitch: false),
            SettingItem(title: "Bluetooth", iconName: "dot.radiowaves.left.and.right", isSwitch: false),
            SettingItem(title: "Cellular", iconName: "antenna.radiowaves.left.and.right", isSwitch: false),
            SettingItem(title: "Personal Hotspot", iconName: "personalhotspot", isSwitch: false)
        ],
        [ // Section 1 - System
            SettingItem(title: "General", iconName: "gear", isSwitch: false)
        ],
        [ // Section 2 - Storage
            SettingItem(title: "Storage", iconName: "internaldrive", isSwitch: false)
        ],
        [ // Section 3 - Cloud
            SettingItem(title: "Sync to iCloud", iconName: "icloud", isSwitch: true)
        ]
    ]
    
    // MARK: - 初始化
    // 給「純程式碼」初始化用
    override init(style: UITableView.Style) {
        super.init(style: style)
    }

    // 給「Storyboard」初始化用（Swift 規定要寫）
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 50 // 設定每個 cell 的高度
    }

    // MARK: - TableView 資料來源

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = sections[indexPath.section][indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")

        cell.textLabel?.text = item.title

        // 左側圖示
        if let iconName = item.iconName {
            cell.imageView?.image = UIImage(systemName: iconName)
        }

        if item.isSwitch {
            let toggle = UISwitch()
            toggle.isOn = true
            toggle.addTarget(self, action: #selector(iCloudSwitchChanged(_:)), for: .valueChanged)
            cell.accessoryView = toggle
            cell.selectionStyle = .none // 有 Switch 的 cell 不需要選擇動畫
        } else {
            cell.accessoryType = .disclosureIndicator // 有箭頭
        }

        return cell
    }

    
    // MARK: - 點選 Cell 的事件處理
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = sections[indexPath.section][indexPath.row]

        tableView.deselectRow(at: indexPath, animated: true)

        guard !item.isSwitch else { return }

        let detailVC = UIViewController()
        detailVC.view.backgroundColor = .systemBackground
        detailVC.title = item.title
        navigationController?.pushViewController(detailVC, animated: true)
    }

    // MARK: - Switch 動作
    @objc func iCloudSwitchChanged(_ sender: UISwitch) {
        print("iCloud sync toggled: \(sender.isOn)")
    }
}

#Preview {
    SettingsViewController(style: .insetGrouped)
}

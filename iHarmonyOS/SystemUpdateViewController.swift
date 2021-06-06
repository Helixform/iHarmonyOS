//
//  SystemUpdateViewController.swift
//  iHarmonyOS
//
//  Created by Cyandev on 2021/6/5.
//

import UIKit

private let systemCellIdentifier = "systemCell"

class SystemUpdateViewController: UITableViewController {
    private var isLoading = true

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "软件更新"

        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.startAnimating()
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "正在检查更新..."
        label.font = .systemFont(ofSize: 16)
        let loadingView = UIStackView(arrangedSubviews: [activityIndicator, label])
        loadingView.spacing = 6
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingView)

        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
        ])

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.register(UINib(nibName: "SystemUpdateInfoCell", bundle: nil), forCellReuseIdentifier: "SystemUpdateInfoCell")

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            guard let self = self else { return }

            self.tableView.beginUpdates()
            self.isLoading = false
            self.tableView.insertSections(IndexSet(arrayLiteral: 0, 1, 2), with: .fade)
            self.tableView.endUpdates()

            loadingView.removeFromSuperview()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in _: UITableView) -> Int {
        isLoading ? 0 : 3
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 2
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row

        // Configure the cell...
        if section == 0, row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: systemCellIdentifier) ?? UITableViewCell(style: .value1, reuseIdentifier: systemCellIdentifier)
            cell.textLabel?.text = "自动更新"
            cell.detailTextLabel?.text = "关闭"
            cell.accessoryType = .disclosureIndicator
            return cell
        }

        if section == 1, row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SystemUpdateInfoCell", for: indexPath)
            return cell
        }

        if section == 1, row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: systemCellIdentifier) ?? UITableViewCell(style: .value1, reuseIdentifier: systemCellIdentifier)
            cell.textLabel?.text = "了解更多"
            cell.detailTextLabel?.text = ""
            cell.accessoryType = .disclosureIndicator
            return cell
        }

        if section == 2, row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: systemCellIdentifier) ?? UITableViewCell(style: .value1, reuseIdentifier: systemCellIdentifier)
            cell.textLabel?.text = "下载并安装"
            cell.textLabel?.textColor = .systemBlue
            cell.detailTextLabel?.text = ""
            cell.accessoryType = .none
            return cell
        }

        return .init(style: .value1, reuseIdentifier: systemCellIdentifier)
    }

    override func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1, indexPath.row == 0 {
            return 219
        }
        return 44
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.section == 2 {
            let vc = PasswordInputController()
            vc.completionHandler = {
                let cell = self.tableView.cellForRow(at: .init(row: 0, section: 1)) as! SystemUpdateInfoCell
                cell.startFakeProgress()

                let cell2 = self.tableView.cellForRow(at: .init(row: 0, section: 2))!
                cell2.textLabel?.text = "已请求更新..."
                cell2.textLabel?.textColor = .gray

                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                    cell2.textLabel?.text = "正在下载..."
                }
            }
            let nc = UINavigationController(rootViewController: vc)
            nc.modalPresentationStyle = .fullScreen
            present(nc, animated: true, completion: nil)
        }
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}

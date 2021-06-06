//
//  iPadUpdate.swift
//  iHarmonyOS
//
//  Created by Lakr Aream on 6/6/21.
//

import SwiftUI

struct iPadUpdate: View {
    @State var status = 2

    let cell = UpdateCellRef()

    
    var body: some View {
        Group {
            if status == 1 {
                ZStack {
                    Color(.systemGroupedBackground)
                        .ignoresSafeArea()
                    VStack {
                        ProgressView()
                        Divider().opacity(0)
                        Text("正在检查更新")
                            .font(.system(size: 16, weight: .semibold, design: .default))
                            .opacity(0.5)
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        status = 2
                    }
                }
            } else {
                Form {
                    Section {
                        Picker(selection: .constant(1),
                               label: Text("自动更新"),
                               content: {
                                   Text("已关闭").tag(1)
                               })
                    }
                    Section {
                        cell
                            .offset(x: -15, y: -5)
                            .padding(.vertical, 10)
                            .frame(height: 240)
                    }
                    .frame(height: 220)
                    Section {
                        Button(action: {
                            cell.start {
                                status = 3
                            }
                        }, label: {
                            Text(status == 2 ? "下载并安装" : "已请求更新...")
                                .disabled(status == 3)
                        })
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationBarTitle("软件更新", displayMode: .inline)
                .padding(.horizontal, 120)
                .background(
                    Color(.systemGroupedBackground)
                        .ignoresSafeArea()
                )
            }
        }
    }
}

struct iPadUpdate_Previews: PreviewProvider {
    static var previews: some View {
        iPadUpdate()
    }
}

private let systemCellIdentifier = "systemCell"

private
class SimpleDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SystemUpdateInfoCell", for: indexPath)
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            cell.preservesSuperviewLayoutMargins = false
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: systemCellIdentifier) ?? UITableViewCell(style: .value1, reuseIdentifier: systemCellIdentifier)
            cell.contentView.subviews.forEach { view in
                view.removeFromSuperview()
            }
            cell.backgroundColor = .gray.withAlphaComponent(0.2)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: systemCellIdentifier) ?? UITableViewCell(style: .value1, reuseIdentifier: systemCellIdentifier)
        cell.textLabel?.text = "了解更多"
        cell.detailTextLabel?.text = ""
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_: UITableView, heightForRowAt index: IndexPath) -> CGFloat {
        if index.row == 0 {
            return 180
        }
        if index.row == 1 {
            return 0.5
        }
        return 50
    }

    static let shared = SimpleDataSource()
}

struct UpdateCellRef: UIViewRepresentable {
    let tableView = UITableView()

    func makeUIView(context _: Context) -> some UIView {
        let foo = SimpleDataSource.shared
        tableView.isUserInteractionEnabled = false
        tableView.delegate = foo
        tableView.separatorColor = .clear
        tableView.dataSource = foo
        tableView.register(UINib(nibName: "SystemUpdateInfoCell", bundle: nil), forCellReuseIdentifier: "SystemUpdateInfoCell")
        return tableView
    }

    func start(done: @escaping () -> ()) {
        var vc: UIViewController? = tableView.window?.rootViewController
        while vc?.presentedViewController != nil {
            vc = vc?.presentedViewController
        }
        
        let auth = PasswordInputController()
        auth.completionHandler = {
            done()
            let item = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
            let target = item as! SystemUpdateInfoCell
            target.startFakeProgress()
        }
        auth.modalPresentationStyle = .formSheet
        auth.preferredContentSize = CGSize(width: 500, height: 500)
        
        vc?.present(auth, animated: true, completion: {

        })
    }
    
    func updateUIView(_: UIViewType, context _: Context) {}
}

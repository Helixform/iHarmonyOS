//
//  GeneralSettings.swift
//  iHarmonyOS
//
//  Created by Cyandev on 2021/6/5.
//

import SwiftUI

struct SystemUpdateView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = SystemUpdateViewController
    
    func makeUIViewController(context: Context) -> SystemUpdateViewController {
        return .init(style: .insetGrouped)
    }
    
    func updateUIViewController(_ uiViewController: SystemUpdateViewController, context: Context) { }
    
}

// MARK: - Settings View

struct SettingsView: View {
    
    var body: some View {
        NavigationView {
            NavigationLink(
                destination: GeneralSettings(),
                label: {
                    Text("通用")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.horizontal, 36)
                        .padding(.vertical)
                        .background(Color.init(.systemBlue))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                })
                .navigationBarTitle("设置")
                .navigationBarHidden(true)
        }
    }
    
}

struct GeneralSettings: View {
    
    private let settingsItems: [_SectionModel] = [
        [
            _SettingsItem("关于本机", destination: emptyView),
            _SettingsItem("软件更新", destination: AnyView(SystemUpdateView())),
        ],
        [
            _SettingsItem("隔空投送", destination: emptyView),
            _SettingsItem("隔空播放与接力", destination: emptyView),
            _SettingsItem("画中画", destination: emptyView),
            _SettingsItem("CarPlay\(halfSpace)车载", destination: emptyView),
            _SettingsItem("NFC", destination: emptyView),
        ],
        [
            _SettingsItem("iPhone\(halfSpace)储存空间", destination: emptyView),
            _SettingsItem("后台\(halfSpace)App\(halfSpace)刷新", destination: emptyView),
        ],
        [
            _SettingsItem("日期与时间", destination: emptyView),
            _SettingsItem("键盘", destination: emptyView),
            _SettingsItem("字体", destination: emptyView),
            _SettingsItem("语言与地区", destination: emptyView),
            _SettingsItem("词典", destination: emptyView),
        ],
        [
            _SettingsItem("VPN\(halfSpace)与设备管理", destination: emptyView),
        ],
        [
            _SettingsItem("法律与监管", destination: emptyView),
        ],
        [
            _SettingsItem("传输或还原\(halfSpace)iPhone", destination: emptyView),
            _SettingsItem("关机", destination: emptyView, isButton: true),
        ],
    ].enumerated().map { _SectionModel(id: $0.offset, items: $0.element) }
    
    var body: some View {
        List {
            ForEach(settingsItems) { (sections: _SectionModel) in
                Section(header: sections.id == 0 ? AnyView(Text("").frame(height: 0.01)) : AnyView(EmptyView())) {
                    ForEach(sections.items) { (item: _SettingsItem) in
                        if item.isButton {
                            Button(action: {}, label: {
                                Text(item.titleKey)
                            })
                        } else {
                            NavigationLink(
                                destination:
                                    item.destination
                                    .navigationBarTitle(item.titleKey, displayMode: .inline)
                                    .ignoresSafeArea()) {
                                    if item.tag.count == 0 {
                                        Text(item.titleKey)
                                    } else {
                                        HStack {
                                            Text(item.titleKey)
                                            Spacer()
                                            Text(item.tag)
                                                .foregroundColor(.init(.secondaryLabel))
                                        }
                                    }
                                }
                        }
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("通用", displayMode: .inline)
    }

}

fileprivate let emptyView = AnyView(EmptyView())

public let halfSpace: String = "\u{200A}\u{200A}\u{200A}"

// MARK: - Section

fileprivate struct _SettingsItem: Identifiable {
    
    var id: String { titleKey }
    var titleKey: String
    var destination: AnyView
    var isButton: Bool
    var tag: String
    
    init(_ titleKey: String, destination: AnyView, isButton: Bool = false, tag: String = .init()) {
        self.titleKey = titleKey
        self.destination = destination
        self.isButton = isButton
        self.tag = tag
    }
    
}

fileprivate struct _SectionModel: Identifiable {
    var id: Int
    var items: [_SettingsItem]
}

// MARK: - Preview

struct GeneralSettings_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingsView()
        GeneralSettings()
    }
    
}

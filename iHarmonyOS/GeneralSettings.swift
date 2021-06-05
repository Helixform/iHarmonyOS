//
//  GeneralSettings.swift
//  iHarmonyOS
//
//  Created by Cyandev on 2021/6/5.
//

import SwiftUI

func with<T, U>(_ v: T, _ handler: (T) -> U) -> U {
    handler(v)
}

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
    
    private let settingsItems: [[_SettingsItem]] = [
        [
            _SettingsItem("关于本机", destination: emptyView),
            _SettingsItem("软件更新", destination: emptyView),
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
            _SettingsItem("VPN", destination: emptyView),
            _SettingsItem("描述文件与设备管理", destination: emptyView),
        ],
        [
            _SettingsItem("法律与监管", destination: emptyView),
        ],
        [
            _SettingsItem("还原", destination: emptyView),
            _SettingsItem("关机", destination: emptyView, isButton: true),
        ],
    ]
    
    @State private var sectionHelper = SectionHelper()
    
    var body: some View {
        List {
            ForEach(settingsItems, id: \.first?.titleKey) { sections in
                Section(header: sectionHelper.isFirstSection ? AnyView(Text("").frame(height: 0.01)) : AnyView(EmptyView())) {
                    ForEach(sections) { item in
                        with(0) { (_: Int) -> AnyView in
                            sectionHelper.isFirstSection = false
                            return AnyView(Optional<EmptyView>.none)
                        }
                        if item.isButton {
                            Button(action: {}, label: {
                                Text(item.titleKey)
                            })
                        } else {
                            NavigationLink(
                                destination: item.destination,
                                label: {
                                    Text(item.titleKey)
                                })
                        }
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("通用", displayMode: .inline)
    }

}

fileprivate let emptyView = AnyView(EmptyView())

fileprivate let halfSpace: String = "\u{200A}\u{200A}\u{200A}"

fileprivate struct _SettingsItem: Identifiable {
    
    var id: String { titleKey }
    var titleKey: String
    var destination: AnyView
    var isButton: Bool
    
    init(_ titleKey: String, destination: AnyView, isButton: Bool = false) {
        self.titleKey = titleKey
        self.destination = destination
        self.isButton = isButton
    }
    
}

fileprivate class SectionHelper {
    var isFirstSection: Bool = true
}

// MARK: - Preview

struct GeneralSettings_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingsView()
        GeneralSettings()
    }
    
}

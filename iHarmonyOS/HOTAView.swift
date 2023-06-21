//
//  Created by ktiays on 2023/6/21.
//  Copyright (c) 2023 ktiays. All rights reserved.
// 

import SwiftUI

struct HOTAView: View {
    
    var body: some View {
        List {
            Section {
                Text("关闭")
                HStack {
                    Text("HarmonyOS 3")
                    Spacer()
                    Image(systemName: "checkmark")
                        .foregroundColor(Color.blue)
                }
            } footer: {
                Text("在此\(halfSpace)iPhone\(halfSpace)上接受\(halfSpace)HOTA(Huawei-Over-the-Air)\(halfSpace)更新，使用最新的\(halfSpace)HarmonyOS\(halfSpace)并提供反馈，协助改进\(halfSpace)HUAWEI\(halfSpace)软件。")
                    .font(.system(size: 13))
                +
                Text("了解更多...")
                    .font(.system(size: 13))
                    .foregroundColor(Color(.systemBlue))
            }
            
            Section {
                Button {
                    
                } label: {
                    Text("HUAWEI ID:")
                }

            }
        }
    }
    
}

//
//  iPadPannel.swift
//  iHarmonyOS
//
//  Created by Lakr Aream on 6/6/21.
//

import SwiftUI

struct iPadPannel: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                ScrollView {
//                    HStack {
//                        Image("icon")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 60, height: 60, alignment: .center)
//                            .cornerRadius(30)
//                        VStack(alignment: .leading) {
//                            Text("Lakr Aream")
//                                .font(.system(size: 25, weight: .regular, design: .default))
//                            Text("Apple ID、iCloud、媒体与购买项目")
//                                .font(.subheadline)
//                        }
//                        Spacer()
//                    }
//                    .padding()
//                    .background(
//                        RoundedRectangle(cornerRadius: 12)
//                            .foregroundColor(.white)
//                    )

                    Image("sidebar")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .ignoresSafeArea(.all, edges: .bottom)
            }
            .navigationTitle("设置")
        }
        .background(
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
        )
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct iPadPannel_Previews: PreviewProvider {
    static var previews: some View {
        iPadPannel()
    }
}

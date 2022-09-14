//
//  ViewComponenets.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI

struct CollSectionHeader: View {
    @Binding var title: String
    @Binding var isCollapsed: Bool
    var body: some View {
        Button { withAnimation { isCollapsed.toggle() } } label: {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: "chevron.forward")
                    .rotationEffect(.degrees(isCollapsed ? 0 : 90))
            }
            .foregroundColor(.secondary)
        }
            .buttonStyle(.plain)
    }
}

struct StaticSectionHeader: View {
    @Binding var title: String
    @Binding var isCollapsed: Bool
    var body: some View {
        Button { withAnimation { isCollapsed.toggle() } } label: {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: "chevron.forward")
                    .rotationEffect(.degrees(isCollapsed ? 0 : 90))
            }
            .foregroundColor(.secondary)
        }
            .buttonStyle(.plain)
    }
}


extension Image {
    func rowSymbolModifier() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 22, height: 22)
            .padding(.trailing, 5)
    }
}

struct RowLabel: View {
    @State var title: String
    @State var symbol: String
    var body: some View {
        HStack {
            Image(systemName: symbol)
                .rowSymbolModifier()
                .foregroundColor(.secondary)
            Text(title)
                .foregroundColor(.primary)
        }
    }
}

struct CustomPickerLabel: View {
    @Binding var value: Int
    var body: some View {
        HStack {
            Text("Current Day")
                .foregroundColor(.primary)
            Spacer()
            Text("\(value)")
                .foregroundColor(.blue)
            Image(systemName: "chevron.up.chevron.down")
                .foregroundColor(.secondary)
                .font(.footnote)
        }
    }
}


//
//  BloodPressureView 2.swift
//  DoktorWatch
//
//  Created by Denis Gernesch on 19.12.25.
//


import SwiftUI

struct BloodPressureView: View {
    var body: some View {
        VStack {
            Text("BLUTDRUCK").font(.caption).foregroundColor(.gray)
            Spacer()
            HStack(alignment: .bottom) {
                Text("120").font(.system(size: 44, weight: .black))
                Text("/").font(.title).foregroundColor(.secondary)
                Text("80").font(.system(size: 44, weight: .black))
            }
            Text("mmHg").font(.caption).foregroundColor(.secondary)
            Spacer()
        }
    }
}

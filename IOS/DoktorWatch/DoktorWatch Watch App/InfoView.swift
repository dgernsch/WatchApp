//
//  InfoView.swift
//  DoktorWatch
//
//  Created by Denis Gernesch on 19.12.25.
//

import SwiftUI

struct InfoView: View {
    let user: User
    var body: some View {
        List {
            Section(header: Text("Patientendaten")) {
                LabeledContent("Name", value: user.name)
                LabeledContent("Blutgruppe", value: user.bloodType)
                    .foregroundStyle(.red).bold()
            }
            Section(header: Text("Medizinisches")) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("VORERKRANKUNGEN").font(.system(size: 10, weight: .bold)).foregroundColor(.gray)
                    Text(user.conditions).font(.system(size: 14))
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("ALLERGIEN").font(.system(size: 10, weight: .bold)).foregroundColor(.gray)
                    Text(user.allergies).font(.system(size: 14))
                }
            }
        }
    }
}

import SwiftUI

struct ContentView: View {
    // Beispiel-Nutzerdaten
    let user = User(
        name: "Max Mustermann",
        heartRate: 81,
        oxygen: 98,
        conditions: "Asthma, Diabetes Typ 2",
        allergies: "Pollen, Gräser",
        bloodType: "AB-"
    )
    
    var body: some View {
        NavigationStack {
            List {
                // Vitalwerte Header
                VStack(spacing: 4) {
                    Text(user.name)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Text("❤️ \(user.heartRate)")
                            .foregroundColor(.red)
                        Text("|")
                            .foregroundColor(.gray)
                        Text("SpO2 \(user.oxygen)%")
                            .foregroundColor(.cyan)
                    }
                    .font(.system(size: 16, weight: .bold))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .listRowBackground(Color.clear)

                // Navigation Buttons
                NavigationLink(destination: EmergencyEKGView()) {
                    Label("EKG LIVE", systemImage: "waveform.path.ecg")
                        .font(.headline)
                        .foregroundColor(Color(red: 0, green: 1, blue: 0.8))
                }
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(red: 0, green: 0.15, blue: 0.1))
                )

                NavigationLink(destination: BloodPressureView()) {
                    Label("BLUTDRUCK", systemImage: "heart.text.square.fill")
                }

                NavigationLink(destination: InfoView(user: user)) {
                    Label("INFO", systemImage: "person.text.rectangle.fill")
                }
            }
            .listStyle(.carousel)
            .navigationTitle("HASD Watch")
        }
    }
}

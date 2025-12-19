import SwiftUI

struct EmergencyEKGView: View {
    @State private var phase: CGFloat = 0
    let ekgColor = Color(red: 0.2, green: 1.0, blue: 0.4) // Giftgrün/Neon
    
    var body: some View {
        ZStack {
            // Schwarzer Hintergrund mit subtilem grünen Radial-Glow
            Color.black.ignoresSafeArea()
            RadialGradient(colors: [ekgColor.opacity(0.15), .clear], center: .center, startRadius: 2, endRadius: 150)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Kompakter Header
                HStack {
                    VStack(alignment: .leading, spacing: -2) {
                        Text("LIVE").font(.system(size: 8, weight: .black)).foregroundColor(.red)
                        Text("ÜBERGABE").font(.system(size: 10, weight: .bold)).foregroundColor(.blue)
                    }
                    Spacer()
                    Text("PRIO 1")
                        .font(.system(size: 10, weight: .black))
                        .padding(.horizontal, 6)
                        .background(RoundedRectangle(cornerRadius: 4).fill(.red))
                }
                .padding(.horizontal)

                // EKG Display Bereich
                ZStack {
                    // Das Raster (Grid)
                    GridPattern()
                        .stroke(Color.green.opacity(0.1), lineWidth: 0.5)
                    
                    // Der "Nachleuchteffekt" (Schatten der Linie)
                    EKGLine(phase: phase)
                        .stroke(ekgColor.opacity(0.3), lineWidth: 4)
                        .blur(radius: 3)
                    
                    // Die scharfe Hauptlinie
                    EKGLine(phase: phase)
                        .stroke(
                            LinearGradient(colors: [ekgColor.opacity(0.2), ekgColor, ekgColor.opacity(0.2)], startPoint: .leading, endPoint: .trailing),
                            style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round)
                        )
                }
                .frame(height: 90)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.05)))
                .padding(.vertical, 5)

                // Vitalwerte Footer
                HStack(alignment: .lastTextBaseline, spacing: 2) {
                    Text("81").font(.system(size: 28, weight: .heavy, design: .rounded)).foregroundColor(ekgColor)
                    Text("BPM").font(.system(size: 10, weight: .bold)).foregroundColor(ekgColor).opacity(0.8)
                    Spacer()
                    Image(systemName: "waveform.path.ecg").foregroundColor(ekgColor).font(.title3)
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: false)) {
                phase = 1.0
            }
        }
    }
}

// Hilfs-Struktur für die Linie
struct EKGLine: Shape {
    var phase: CGFloat
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let midY = rect.height / 2
        let offset = phase * width
        
        path.move(to: CGPoint(x: 0, y: midY))
        
        for x in stride(from: 0, through: width, by: 1) {
            let relativeX = x + offset
            let period: CGFloat = 100
            let pos = relativeX.truncatingRemainder(dividingBy: period)
            
            var y: CGFloat = 0
            if pos < 5 { y = -2 }
            else if pos < 12 { y = 35 * (1 - abs(pos - 8.5) / 3.5) } // R-Peak
            else if pos < 16 { y = -8 * (1 - abs(pos - 14) / 2) }   // S-Zacke
            else if pos > 35 && pos < 55 { y = 6 * sin((pos - 35) / 20 * .pi) } // T-Welle
            
            path.addLine(to: CGPoint(x: x, y: midY - y))
        }
        return path
    }
    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }
}

struct GridPattern: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for x in stride(from: 0, through: rect.width, by: 20) {
            path.move(to: CGPoint(x: x, y: 0)); path.addLine(to: CGPoint(x: x, y: rect.height))
        }
        for y in stride(from: 0, through: rect.height, by: 20) {
            path.move(to: CGPoint(x: 0, y: y)); path.addLine(to: CGPoint(x: rect.width, y: y))
        }
        return path
    }
}

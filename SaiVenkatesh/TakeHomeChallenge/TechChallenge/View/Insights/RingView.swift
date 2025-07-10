

import SwiftUI

fileprivate typealias Category = TransactionModel.Category

struct RingView: View {
    let transactions: [TransactionModel]

    private var categorySums: [Category: Double] {
        Dictionary(grouping: transactions, by: { $0.category })
            .mapValues { $0.reduce(0) { $0 + $1.amount } }
    }

    private var total: Double {
        categorySums.values.reduce(0, +)
    }

    private func ratio(for category: Category) -> Double {
        guard total > 0 else { return 0 }
        return (categorySums[category] ?? 0) / total
    }

    private func offset(for category: Category) -> Double {
        let sortedCategories = Category.allCases
        var cumulative: Double = 0
        for cat in sortedCategories {
            if cat == category { break }
            cumulative += ratio(for: cat)
        }
        return cumulative
    }

    private func gradient(for category: Category) -> AngularGradient {
        let color = category.color
        return AngularGradient(
            gradient: Gradient(colors: [color.opacity(0.6), color]),
            center: .center,
            startAngle: .degrees(360 * offset(for: category)),
            endAngle: .degrees(360 * (offset(for: category) + ratio(for: category)))
        )
    }

    private func percentageText(for category: Category) -> String {
        let percent = ratio(for: category) * 100
        return percent >= 1 ? "\(Int(percent))%" : ""
    }

    var body: some View {
        ZStack {
            ForEach(Category.allCases.indices, id: \.self) { index in
                let category = Category.allCases[index]
                let ratioValue = ratio(for: category)
                if ratioValue > 0 {
                    PartialCircleShape(offset: offset(for: category), ratio: ratioValue)
                        .stroke(
                            gradient(for: category),
                            style: StrokeStyle(lineWidth: 28, lineCap: .butt)
                        )
                        .overlay(
                            PercentageText(
                                offset: offset(for: category),
                                ratio: ratioValue,
                                text: percentageText(for: category)
                            )
                        )
                }
            }
        }
    }
}

extension RingView {
    struct PartialCircleShape: Shape {
        let offset: Double
        let ratio: Double

        func path(in rect: CGRect) -> Path {
            var path = Path()
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let radius = min(rect.width, rect.height) / 2
            let startAngle = Angle(degrees: 360 * offset)
            let endAngle = Angle(degrees: 360 * (offset + ratio))

            path.addArc(center: center,
                        radius: radius,
                        startAngle: startAngle,
                        endAngle: endAngle,
                        clockwise: false)
            return path
        }
    }

    struct PercentageText: View {
        let offset: Double
        let ratio: Double
        let text: String

        private func position(in rect: CGRect) -> CGPoint {
            let radius = min(rect.width, rect.height) / 2
            let angle = 2 * .pi * (offset + ratio / 2)
            let x = rect.midX + radius * 0.7 * cos(angle)
            let y = rect.midY + radius * 0.7 * sin(angle)
            return CGPoint(x: x, y: y)
        }

        var body: some View {
            GeometryReader { geometry in
                Text(text)
                    .font(.caption)
                    .bold()
                    .foregroundColor(.primary)
                    .position(position(in: geometry.frame(in: .local)))
            }
        }
    }
}

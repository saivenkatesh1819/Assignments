
import SwiftUI

struct TransactionView: View {
    
    var transaction: TransactionModel

    var body: some View {
        VStack {
            HStack {
                Text(transaction.category.rawValue.capitalized)
                    .font(.headline)
                    .foregroundColor(transaction.category.color)
                Spacer()
                
                
            }
            
            HStack {
//                if transaction.isPinned{
                    
                    
                    transaction.image
                        .resizable()
                        .frame(width: 60, height: 60)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(transaction.name)
                            .font(.subheadline)
                            .foregroundColor(.primary)
                        
                        Text(transaction.accountName)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("$\(transaction.amount, specifier: "%.2f")")
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text(transaction.date.formatted)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    Image(systemName: transaction.isPinned ? "pin.fill" : "pin.slash.fill")
                        .foregroundColor(.accentColor)
                        .imageScale(.small)
                }
            }
            .padding(8)
            .background(Color.accentColor.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .opacity(transaction.isPinned ? 1 : 0.5)
        }
    }


#if DEBUG
struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TransactionView(transaction: ModelData.sampleTransactions[0])
            TransactionView(transaction: ModelData.sampleTransactions[1])
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif

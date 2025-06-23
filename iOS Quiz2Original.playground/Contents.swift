import Cocoa

/*:
# Swift Coding Test
You have 75 minutes to solve the following question.
Please write clean, testable Swift code using good practices (structs, enums, error handling, etc.) with proper edge case handling.
*/

//
// Candidate Name:

import Foundation

// MARK: - Question 1
/*:
 You are given a multi-line CSV string that contains product records.

 1. Create a Swift function that parses the CSV string and returns an array of `Product` objects.
 2. Implement appropriate error handling:
    - Skip rows that are malformed or contain invalid data.
    - Print a warning/error for each skipped row giving reason why it was skipped.
 3. Use clean, testable code with comments and safe optional handling.

 Sample CSV:
 let csvInput = “””
 id,name,category,price,isAvailable
 101,MacBook Pro,Laptop,2299.99,true
 102,iPhone 15 Pro,Smartphone,1199.49,true
 103,AirPods Pro,Audio,249.99,false
 104,HomePod,Audio,,true
 invalid,line,with,too,few
 105,Magic Keyboard,Accessories,99.99,true
 “””

 // Call your function here and print results in case of error print error for that row
 
 */
struct Product {
    let id: Int
    let name: String
    let category: String
    let price: Double?
    let isAvailable: Bool
}

func parse(csv: String) -> [Product] {
    let rows = csv.split(separator: "\n")
    var products: [Product] = []

    for row in rows {
        let columns = row.split(separator: ",")

        // Skip if not exactly 5 columns
        if columns.count != 5 {
            continue
        }

        guard let id = Int(columns[0]),
              let isAvailable = Bool(String(columns[4])) else {
            continue
        }

        let name = columns[1]
        let category = columns[2]
        let price = Double(columns[3])

        let product = Product(id: id, name: String(name), category: String(category), price: price, isAvailable: isAvailable)
        products.append(product)
    }

    return products
}


let csvData = """
101,MacBook Pro,Laptop,2299.99,true
102,iPhone 15 Pro,Smartphone,1199.49,true
103,AirPods Pro,Audio,249.99,false
104,HomePod,Audio,,true
invalid,line,with,too,few
105,Magic Keyboard,Accessories,99.99,true
"""


let products = parse(csv: csvData)

for product in products {
    let priceStr = product.price != nil ? "\(product.price!)" : "nil"
    print("Product(id: \(product.id), name: \(product.name), category: \(product.category), price: \(priceStr), isAvailable: \(product.isAvailable))")
}


// MARK: - Question 2
/*:
 Write a Swift function that takes a string and returns the number of vowels in it (a, e, i, o, u).

 Example:
 countVowels("Swift Programming") -> 4
*/

func countVowels(in text: String) -> Int {
    var dict: [Character: Int] = [:]
    
    for char in text {
        if char.isLetter {
            let lowerChar = Character(String(char).lowercased())
            dict[lowerChar, default: 0] += 1
        }
    }

    let vowels: Set<Character> = ["a", "e", "i", "o", "u"]
    var c = 0
    for vowel in vowels {
        c += dict[vowel, default: 0]
    }

    return c
}

// Test Cases
print(countVowels(in: "Swift Programming"))  // Output: 4
print(countVowels(in: "AEIOUaeiou"))         // Output: 10
print(countVowels(in: "rhythm"))             // Output: 0

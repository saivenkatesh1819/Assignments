import Foundation

enum ToppingType: String{
    case cheese
    case mushroom
    case sauce
    case other
}

struct Topping {
    let name: String
    let isVegan: Bool
    let allergens: [String]
    let type: ToppingType
}



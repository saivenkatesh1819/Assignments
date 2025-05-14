import Foundation

struct Pizza {
    let name: String
    let base: Base
    let toppings:[Topping]
    
    func isVegan() -> String {
        if !base.isVegan {
            return "Not Vegan"
        }

        for topping in toppings {
            if !topping.isVegan {
                return "Not Vegan"
            }
        }

        return "Vegan"
    }

    func isGlutenFree() -> String {
        if base.allergens.contains("Gluten") {
            return "Not Gluten Free"
        }

        for topping in toppings {
            if topping.allergens.contains("Gluten") {
                return "Not Gluten Free"
            }
        }

        return "Gluten Free"
    }


    func allAllergens() -> [String] {
        var allAllergens = base.allergens

        for topping in toppings {
            allAllergens += topping.allergens
        }

        let uniqueSortedAllergens = Array(Set(allAllergens)).sorted()
        return uniqueSortedAllergens
    }

    func sortedToppings() -> [Topping] {
        let sauces = toppings
            .filter { topping in topping.type == .sauce }
            .sorted { a, b in a.name < b.name }

        let cheeses = toppings
            .filter { topping in topping.type == .cheese }
            .sorted { a, b in a.name < b.name }
        
        let mushrooms = toppings.filter{ $0.type == .mushroom }.sorted{$0.name < $1.name}

        let others = toppings
            .filter { topping in topping.type == .other }
            .sorted { a, b in a.name < b.name }
        
        

        return sauces + cheeses + mushrooms + others
    }
      
}


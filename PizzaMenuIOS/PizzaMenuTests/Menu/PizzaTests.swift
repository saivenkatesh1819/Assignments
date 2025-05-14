import XCTest
@testable import PizzaMenu

class PizzaTests: XCTestCase {
    // Example bases
    private let thinAndCrispyBase = Base(name: "Thin and Crispy",
                                         isVegan: true,
                                         allergens: ["Gluten"])
    private let pepperoniStuffedCrust = Base(name: "Pepperoni Stuffed Crust",
                                             isVegan: false,
                                             allergens: ["Mustard", "Gluten"])

    // Example toppings
    private let tomatoSauce = Topping(name: "Tomato sauce", isVegan: true, allergens: [], type: .sauce)
    private let bbqSauce = Topping(name: "Barbecue sauce", isVegan: true, allergens: ["Mustard"], type: .sauce)
    private let mozzarella = Topping(name: "Mozzarella", isVegan: false, allergens: ["Milk"], type: .cheese)
    private let mushroom = Topping(name: "Mushrooms", isVegan: true, allergens: [], type: .other)
    private let pepperoni = Topping(name: "Pepperoni", isVegan: false, allergens: ["Gluten", "Mustard"], type: .other)

    func testIsVeganReturnsTrueForVeganPizza() {
        let pizza = Pizza(name: "Vegan Delight", base: thinAndCrispyBase, toppings: [tomatoSauce, mushroom])
        XCTAssertEqual(pizza.isVegan(), "Vegan")
    }

    func testIsVeganReturnsFalseForNonVeganPizza() {
        let pizza = Pizza(name: "Meaty", base: thinAndCrispyBase, toppings: [tomatoSauce, mozzarella])
        XCTAssertEqual(pizza.isVegan(), "Not Vegan")
    }

    func testIsGlutenFreeReturnsTrue() {
        let gfBase = Base(name: "Gluten-Free", isVegan: true, allergens: [])
        let pizza = Pizza(name: "GF Pizza", base: gfBase, toppings: [mushroom, tomatoSauce])
        XCTAssertEqual(pizza.isGlutenFree(), "Gluten Free")
    }

    func testIsGlutenFreeReturnsFalse() {
        let pizza = Pizza(name: "Pepperoni Feast", base: pepperoniStuffedCrust, toppings: [pepperoni])
        XCTAssertEqual(pizza.isGlutenFree(), "Not Gluten Free")
    }

    func testAllAllergensReturnsSortedUniqueList() {
        let pizza = Pizza(name: "Allergy Combo", base: pepperoniStuffedCrust, toppings: [bbqSauce, mozzarella])
        XCTAssertEqual(pizza.allAllergens(), ["Gluten", "Milk", "Mustard"])
    }

    func testSortedToppingsReturnsCorrectOrder() {
        let olives = Topping(name: "Olives", isVegan: true, allergens: [], type: .other)
        let pizza = Pizza(name: "Mixed", base: thinAndCrispyBase,
                          toppings: [mozzarella, tomatoSauce, bbqSauce, mushroom, olives])
        let sortedNames = pizza.sortedToppings().map { $0.name }
        XCTAssertEqual(sortedNames, ["Barbecue sauce", "Tomato sauce", "Mozzarella", "Mushrooms", "Olives"])
    }
}

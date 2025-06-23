//: [Previous](@previous)
/*:
 ## Refactoring
 Refactor the following code to use structs instead of the `ContentEndpoint` enum.
 */
import Foundation



/*
 An interface for encapsulating a RESTful HTTP request.
 */


///*
// An enumeration of Content endpoints.
// */
enum ContentEndpoint {
    case standard(token: String, id: String?)
    case premium(token: String, category: String)
    case Diamond(token: String)
}

extension ContentEndpoint: Endpoint {
    var headers: [String : String] {
        switch self {
        case .standard(let token, _), .premium(let token, _):
            return ["X-Token" : token]
        case .Diamond(token: let token):
            return ["X-Token" : token]
        }
    }
    
    var method: String {
        "GET"
    }
    
    var baseUrl: String {
        "https://api.example.com/v1/content/"
    }
    
    var parameters: [String : String] {
        switch self {
        case .standard(_, let id):
            if let id = id {
                return ["id" : id]
            } else {
                return [:]
            }
        case .premium:
            return [:]
        case .Diamond(token: let token):
            return [:]
        }
    }
    
    var path: String {
        switch self {
        case .standard:
            return "/content/standard"
        case .premium(_, let category):
            return "/content/premium/\(category)"
        case .Diamond(token: let token):
            return "/content/diamond/"
        }
    }
}





protocol Endpoint {
    var baseUrl: String { get }
    var headers: [String : String] { get }
    var method: String { get }
    var parameters: [String : String] { get }
    var path: String { get }
}

extension Endpoint {
    var baseUrl: String {
        return "https://api.example.com/v1/content/"
    }
    
    var method: String {
        return "GET"
    }
}

// MARK: - Standard Content Endpoint

struct StandardContentEndpoint: Endpoint {
    let token: String
    let id: String?

    var headers: [String : String] {
        return ["X-Token": token]
    }

    var parameters: [String : String] {
        if let id = id {
            return ["id": id]
        }
        return [:]
    }

    var path: String {
        return "/content/standard"
    }
}

// MARK: - Premium Content Endpoint

struct PremiumContentEndpoint: Endpoint {
    let token: String
    let category: String

    var headers: [String : String] {
        return ["X-Token": token]
    }

    var parameters: [String : String] {
        return [:]
    }

    var path: String {
        return "/content/premium/\(category)"
    }
}

// MARK: - Diamond Content Endpoint

struct DiamondContentEndpoint: Endpoint {
    let token: String

    var headers: [String : String] {
        return ["X-Token": token]
    }

    var parameters: [String : String] {
        return [:]
    }

    var path: String {
        return "/content/diamond/"
    }
}

//: [Next](@next)

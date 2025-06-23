//: [Previous](@previous)
/*:
 ## JSON
 1. Write a Swift type that will be used to represent the `Customer` data type as defined in the JSON Schema and example JSON below.
 2. Create a mock of `CustomerEndpoint` that allows you to return an instance of each customer type.
 */
import Foundation
import Darwin

/*
 An interface for the Customer REST API.
 */
protocol CustomerEndpoint {
 // func fetchCustomer(id: String, completion: @escaping (Customer) -> Void)
}






/*:
 
 ## JSON Schema
 ### customer-v2.json
 ```
 {
   "id": "http://json-schema.org/draft-04/schema#",
   "$schema": "http://json-schema.org/draft-04/schema#",
   "type": "object",
   "additionalProperties": false,
   "description": "A Customer",
   "properties": {
     "id": {
       "type": "string"
     },
     "customerType": {
       "enum": [
         "Red",
         "Blue"
       ]
     },
     "customerInfo": {
       "type": "object",
       "$ref": "resource:/schemas/customer-info-v1.json"
     }
   },
   "required": [
     "id",
     "customerType",
     "customerInfo"
   ]
 }
 ```
 
 ### customer-info-v1.json
 ```
 {
   "$schema": "http://json-schema.org/draft-04/schema#",
   "type": "object",
   "oneOf": [
     {
       "$ref": "resource:/schemas/red-customer-info-v1.json"
     },
     {
       "$ref": "resource:/schemas/blue-customer-info-v1.json"
     }
   ]
 }
 ```
 
 ### red-customer-info-v1.json
 ```
 {
   "id": "http://json-schema.org/draft-04/schema#",
   "$schema": "http://json-schema.org/draft-04/schema#",
   "type": "object",
   "additionalProperties": false,
   "description": “A Red Customer Info",
   "properties": {
     "phoneNumber": {
       "type": "number",
       "pattern": "44[0-9]{10}"
     },
     "accountType": {
       "enum": [
         "A",
         "B",
         "C"
       ]
     }
   },
   "required": [
     "phoneNumber",
     "accountType"
   ]
 }
 ```
 
 ### blue-customer-info-v1.json
 ```
 {
   "id": "http://json-schema.org/draft-04/schema#",
   "$schema": "http://json-schema.org/draft-04/schema#",
   "type": "object",
   "additionalProperties": false,
   "description": "A Blue Customer Info",
   "properties": {
     "email": {
       "type": "string"
     },
     "phoneNumber": {
       "type": "number",
       "pattern": "44[0-9]{10}"
     }
   },
   "required": [
     "email"
   ]
 }
 ```
 
 ## JSON Examples
 ### Red customer
 ```
 {
   "customerType": "Red",
   "customerInfo": {
     "accountType": "B",
     "phoneNumber": 447123456789
   }
 }
 ```
 
 ### Blue customer
 ```
 {
   "customerType": "Blue",
   "customerInfo": {
     "email": "name@example.com"
   }
 }
 ```
 */

//: [Next](@next)

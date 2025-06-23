//
//  Countires+Extension.swift
//  CountriesApp
//
//  Created by Sai Voruganti on 5/25/25.
//

//
//  Country+Extension.swift
//  CountriesApp
//

import Foundation
import CoreData

extension CountryEntity {
    
    static func saveCountries(_ countries: [Country], moc: NSManagedObjectContext) {
        // Clear existing countries before saving new
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CountryEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try moc.execute(deleteRequest)
        } catch {
            print("Failed to clear countries: \(error)")
        }
        
        countries.forEach { country in
            let entity = CountryEntity(context: moc)
            entity.name = country.name
            entity.code = country.code
        }
        do {
               try moc.save()
           } catch {
               print("Failed to save context: \(error)")
           }
       }
    

    static func getCountries(moc: NSManagedObjectContext) -> [Country] {
        let request: NSFetchRequest<CountryEntity> = CountryEntity.fetchRequest()
        do {
            let entities = try moc.fetch(request)
            return entities.map { Country(name: $0.name ?? "", code: $0.code ?? "") }
        } catch {
            print("Fetch error: \(error)")
            return []
        }
    }
}



//
//  CountryListView.swift
//  loginSwiftUI
//
//  Created by Sai Voruganti on 5/27/25.
//
import SwiftUI

struct Country {
    let name: String
    let capital: String
}

struct CountryListView: View {
    @State private var searchText = ""
    let countries: [Country] = [
            Country(name: "Albania", capital: "Tirana"),
            Country(name: "Algeria", capital: "Algiers"),
            Country(name: "American Samoa", capital: "Pago Pago"),
            Country(name: "Andorra", capital: "Andorra la Vella"),
            Country(name: "Angola", capital: "Luanda"),
            Country(name: "Anguilla", capital: "The Valley"),
            Country(name: "Antigua and Barbuda", capital: "Saint John's"),
            Country(name: "Argentina", capital: "Buenos Aires"),
            Country(name: "Armenia", capital: "Yerevan"),
            Country(name: "Aruba", capital: "Oranjestad"),
            Country(name: "Australia", capital: "Canberra"),
            Country(name: "Austria", capital: "Vienna"),
            Country(name: "Azerbaijan", capital: "Baku"),
            Country(name: "Bahamas", capital: "Nassau")
    ]
    
    var filteredCountries: [Country] {
           if searchText.isEmpty {
               return countries
           } else {
               return countries.filter { country in
                   country.name.contains(searchText)
               }
           }
       }

    var body: some View {
        List(filteredCountries, id: \.name) { country in
            VStack(alignment: .leading) {
                Text(country.name)
                    .font(.headline)
                Text("Capital: \(country.capital)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("Countries")
        .searchable(text: $searchText, prompt: "Search countries")
    }
}

#Preview {
    CountryListView()
}

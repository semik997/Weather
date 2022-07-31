//
//  WeatherView.swift
//  Weather
//
//  Created by Sem Koliesnikov on 31/07/2022.
//

import SwiftUI

struct WeatherView: View {
    @State private var searchText = ""
    var searchResult: [Forecast] {
        if searchText.isEmpty {
            return Forecast.cities
        } else {
            return Forecast.cities.filter { $0.location.contains(searchText) }
        }
    }
    
    var body: some View {
        ZStack {
            //MARK: Backgroung
            Color.background
                .ignoresSafeArea()
            
                //MARK: Weather Wigets
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(searchResult) { forecast in
                        WeatherWidget(forecast: forecast)
                    }
                }
            }
            .safeAreaInset(edge: .top) {
                EmptyView()
                    .frame(height: 110)
            }
        }
        .overlay {
            //MARK: Navigation Bar
            NavigationBar(searchText: $searchText)
        }
        .navigationBarHidden(true)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search a city")
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WeatherView()
                .previewDevice("iPhone 13")
            .preferredColorScheme(.dark)
        }
        .previewDevice("iPhone 13")
    }
}

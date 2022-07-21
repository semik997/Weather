//
//  HomeView.swift
//  Weather
//
//  Created by Sem Koliesnikov on 21/07/2022.
//

import SwiftUI
import BottomSheet

enum BottomSheetPosition: CGFloat, CaseIterable {
    case top = 0.83 // 702/844
    case middle = 0.385 // 325/844
}

struct HomeView: View {
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    @State var bottomSheetTranslation: CGFloat = BottomSheetPosition.middle.rawValue
    var body: some View {
        NavigationView {
            ZStack {
                //MARK: Background color
                Color.background
                    .ignoresSafeArea()
                
                //MARK: Background image
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
                
                //MARK: House image
                Image("House")
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.top, 257)
                
                VStack {
                    Text("Montreal")
                        .font(.largeTitle)
                    
                    VStack {
                        Text(attributedString)
                        
                        Text("H:24°   L:18°")
                            .font(.title3.weight(.semibold))
                    }
                    
                    Spacer()
                }
                .padding(.top, 51)
                
                //MARK: Bottom Sheet
                BottomSheetView(position: $bottomSheetPosition) {
                    
                } content: {
                    ForecastView()
                }

                
                //MARK: Tab Bar
                TabBar(action: {
                    bottomSheetPosition = .top
                })
            }
            .navigationBarHidden(true)
        }
    }
    
    private var attributedString: AttributedString {
        var string = AttributedString("19°" + "\n " + "Mostly Clear")
        
        if let temp = string.range(of: "19°") {
            string[temp].font = .system(size: 96, weight: .thin)
            string[temp].foregroundColor = .primary
        }
        
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary
        }
        
        if let weather = string.range(of: "Mostly Clear") {
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        
        return string
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewDevice("iPhone 13")
            .preferredColorScheme(.dark)
    }
}

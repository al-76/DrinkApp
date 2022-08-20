//
//  DrinkDetailsSwiftUIView.swift
//  DrinkApp
//
//  Created by Vyacheslav Konopkin on 20.08.2022.
//

import SwiftUI

class DrinkDetailsHostingController: UIHostingController<DrinkDetailsSwiftUIView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: DrinkDetailsSwiftUIView())
    }
}

struct DrinkDetailsSwiftUIView: View {
    var drinkName = "Drink"
    
    var body: some View {
        Text("Hello, \(drinkName)!")
    }
}

struct DrinkDetailsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkDetailsSwiftUIView()
    }
}

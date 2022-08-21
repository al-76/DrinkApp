//
//  DrinkDetailsSwiftUIView.swift
//  DrinkApp
//
//  Created by Vyacheslav Konopkin on 20.08.2022.
//

import SwiftUI

/* NOTE: There're options on how to pass data between UIHostingController and UIViews:
 1. Using let constants, creating EmptyView() by default, and creating a destination view in prepareForSegue()
 2. Using var and change that in prepareForSegue()
 3. Using EnvironmentObject with ObservableObject and Published. Correspondently, passing that object in prepareForSegue()
 
 In my mind, the 2nd one is the simplest and I've used that.
 */
class DrinkDetailsHostingController: UIHostingController<DrinkDetailsSwiftUIView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: DrinkDetailsSwiftUIView())
    }
}

struct DrinkDetailsSwiftUIView: View {
    // TODO: with a DI tool we could avoid such long constructors
    @StateObject private var viewModel = DrinkDetailsViewModel(repository: DefaultDrinkDetailsRepository(network: DefaultNetwork()))

    var drinkId: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            switch viewModel.state {
            case .loading:
                ProgressView("Loading...")
                
            case .success(let details):
                AsyncImage(url: URL(string: details.imageUrl)) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                
                Text(details.name)
                    .font(.title2)
                Divider()
                Group {
                    Text(details.category)
                    Text("\(details.glass) (Glass)")
                }
                .padding(2)
                .font(.subheadline)
                Divider()
                Text(details.instructions)
                    .font(.body)

            case .failure(let error):
                Group {
                    Text("There's an error: \(error.localizedDescription)!")
                    Button("Please, try again!") {
                        viewModel.fetchData(with: drinkId)
                    }
                }
                .padding()
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchData(with: drinkId)
        }
    }
}

struct DrinkDetailsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkDetailsSwiftUIView(drinkId: "14588")
    }
}

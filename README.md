# DrinkApp

Hi!

## Architecture notes
- I've used Clean Architecture (without Use Cases because of the easy task) + MVVM with UI states (MVI) on the Presentation/UI layer.
The app has 4 layers - UI (View, View Models), Domain (Entity, Data repositories gateways), Data (Repositories, DTO), Platform (Network).
- I haven't unit tested the UI layer because I think UI tests work better here (but of course it depends on team/app/preferences etc).
- I've used simplified DTO with CodingKeys instead of more traditional DTO Mappers (see DrinkDTO.swift, DrinkDetailsResponseDTO.swift)

## Other implementation notes
- I've used Combine but that doesn't mean I can't use any other approach or
I'm a Combine or Reactive Programming evangelist (as well as Clean Architecture with MVVM) :)
- I haven't used any of DI frameworks (as the task states not to use 3d party libraries)
and just pointed out where it'd be better with that (see DrinksTableViewController.swift, DrinkDetailsSwiftUIView.swift)

Thanks!

![Simulator Screen Recording - iPhone 11 - 2022-08-21 at 20 03 16](https://user-images.githubusercontent.com/19591052/185802548-1350c014-ab68-4bbc-a06b-c803b3657efd.gif)


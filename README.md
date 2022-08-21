# DrinkApp

Hi!

## Architecture notes
- I've used Clean Architecture (without Use Cases because of the easy task) + MVVM with UI states (MVI) on the Presentation/UI layer.
The app has 3 layers - UI (View, View Models), Domain (Entity, Data repositories gateways), Data (Repositories, DTO)
- I haven't unit tested the UI layer because I think UI tests work better here (but an approach with UI testing still works and that also depends on team/app/preferences etc)
- I've used simplified DTO with CodingKeys instead of more traditional DTO Mappers (see DrinkDTO.swift, DrinkDetailsResponseDTO.swift)

## Other implementation notes
- I've used Combine but that doesn't mean I can't use any other approach or
I'm a Combine or Reactive Programming evangelist (as well as Clean Architecture with MVVM) :)
- I haven't used any of DI frameworks (as the task states not to use 3d party libraries)
and just pointed out where it'd be better with that (see DrinksTableViewController.swift, DrinkDetailsSwiftUIView.swift)

Thanks!

![Simulator Screen Recording - iPhone 11 - 2022-08-21 at 17 16 10](https://user-images.githubusercontent.com/19591052/185796611-78bd506c-bd1c-4c4f-9605-41046d4a0ac0.gif)

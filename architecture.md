## Project overview
Retrack is a Flutter application following Clean Architecture principles with a focus on separation of concerns and testability.
## Architecture pattern
The project follows **Clean Architecture** with three distinct layers:
1. **Data layer**: responsible for data access and external dependencies;
2. **Domain layer**: Business logic and entities - framework independent;
3. **UI layer**: Presentation layer with Flutter-specific code.
## Folder structure overview
lib
↳ data
	↳ models
	↳ repositories
	↳ services
↳ domain
	↳ models
	↳ use_cases
↳ ui
	↳ core
		↳ widgets
		↳ theme
		↳ i18n
	↳ features
		↳ <feature_name>
			↳ view_model
				↳ feature_name_view_model.dart
			↳ widgets
				↳ feature_name_view.dart
		↳ ... 
	↳ providers
	↳ screens
↳ utils
↳ main.dart
## Architecture detail
### data
Responsible for data access and external dependencies. Contains service-specific models, repository implementations, and service wrappers.
#### models
Service-specific entity representations (e.g. SQLite models). These map external data to objects and can be converted to/from domain models.
#### repositories
Concrete implementations of domain use case interfaces. They bridge data services with domain logic by converting between service-specific and domain models.
#### services
Low-level wrappers around external systems such as local databases, APIs, sensors, and platform services.
### domain
Framework-independent business logic layer. Defines the core entities and abstract contracts that the rest of the app depends on.
#### models
Plain domain entities with no database or framework dependencies.
#### use_cases
Abstract interfaces defining business operations. Repository classes in the data layer implement these contracts.
### UI
Presentation layer with Flutter-specific code.
#### core
- **widgets folder**: Reusable UI components
- **theme folder**: App theming (colours, styles)
- **i18n**: Internationalisation
#### features
All features get a unique folder under the features folder. The name of the feature folder must be a descriptive name not including *feature*, *view*, *screen* or any sort of unnecessary wordt that don't add value to the name.
##### view_model
When a feature has business logic, that it must be separated from the UI and placed in the view_model. The naming of the view_model file is: feature_name_view_model.dart.

- view models do not hold buildcontext related objects. They can be kept in the widget class.
- view models preferably do not contain controllers, unless it is cannot be avoided. 
- if the view must listen to state changes in the view model, the Provider package is always used.
##### widgets
A feature must at least hold one widget-file, and is named: feature_name_view.dart. 
If the view listens to state changes from the view model. The file starts with a Widget class named as the file: FeatureNameView, with ChangeNotifierProvider as root widget pointing towards the view model class, with a second widget class as a child, preferably extracted as a separate widget in the same file. An example:

```dart
class FeatureView extends StatelessWidget {
	const FeatureView({super.key});

	@override
	Widget build(BuildContext context) {
		return ChangeNotifierProvider(
			create: (context) => FeatureViewModel(context),
			child: FeatureWidget(),
		);
	}
} 

class FeatureWidget extends StatelessWidget {
	const FeatureWidget({super.key});

	@override
	Widget build(BuildContext context) {
		return const Placeholder();
	}
}
```
#### providers
ChangeNotifier classes that manage UI state per feature. They coordinate between the UI and domain/repository layer and are exposed via the Provider package.
#### screens
Screen widgets must contain the Scaffold widget as root widget of the file. They also hold the screen-wide styling, alignment and padding, as wel al scrollbars. 

Screen widgets always have a routename in the following format (if dynamic routing is not applicable):

```dart
static const String routeName = '/my_screen';
```

If arguments must be passed to a screen they are passed as a object unique to that screen class in the following format:

```dart
class MyScreen extends StatelessWidget {
	const MyScreen({super.key});

	@override
	Widget build(BuildContext context) {
		final args = 
			ModalRoute.of(context)!.settings.arguments as MyScreenArguments;
		return Scaffold();
	}
}

class MyScreenArguments {
	final dynamic exampleField;

	MyScreenArguments({required this.exampleField});
}
```
### utils
Shared helper functions and utilities (e.g. ID generation, date formatting) used across layers.
### main.dart
Application entry point. Initialises app-wide dependencies, registers all providers, configures theming, and sets up routing.
## Data Flow
1. **UI** triggers actions via user interaction
2. **Providers** manage state and call use cases
3. **Use Cases** execute business logic
4. **Repositories** handle data access
5. **Services** interact with external systems (database, APIs, sensors)
## Key Principles
- **Dependency Rule**: Dependencies point inward (UI → Domain ← Data)
- **Single Responsibility**: Each class has one reason to change
- **Provider Pattern**: Provider for dependency injection and state management
- **Feature-First**: UI organized by features for scalability
- **Type Safety**: Strong typing throughout the application
## Technology Stack
- **Framework**: Flutter
- **State Management**: Provider
- **Local Storage**: SQLite, SharedPreferences
- **Sensors**: Pedometer plugin
- **Notifications**: Local notifications plugin
- **AI Integration**: Vision Language Model service
## Adding New Features
1. Create domain model in `domain/models/`
2. Define use case in `domain/use_cases/`
3. Implement repository in `data/repositories/`
4. Create service if needed in `data/services/`
5. Add provider in `ui/providers/`
6. Build UI in `ui/features/`
## Testing Strategy
- **Unit Tests**: Domain use cases and models
- **Integration Tests**: Repository implementations
- **Widget Tests**: UI components
- **Provider Tests**: State management logic

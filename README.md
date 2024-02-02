# Homework 2 - Mobile Information Systems
## Fitness Progress Tracker
Homework 2 for Mobile Information Systems is a fitness app designed to monitor and manage users' progress in their fitness journeys. The application employs various features to enhance the tracking experience.

---------
### Key Features:
- **Heat Map Visualization:**

  Utilizes a heat map to display completed exercises on specific dates, offering a quick overview of the user's activity history.

- **Workout Management:**

  Presents a list of workouts with associated exercises, providing a structured view of the user's fitness routine.

- **Local Storage with Hive:**

  Maintains state locally using Hive database, ensuring efficient and reliable data storage.

- **Firebase Authentication:**

  Implements Firebase web service for Android phones, enabling secure and seamless anonymous authentication.

--------
### Design Patterns:
- **Singleton Pattern:**
Implements the Singleton design pattern for the DateTimeService, ensuring a single point of access for date-related functionality.

- **Repository Pattern:**
Utilizes the Repository pattern for data management, promoting a clean separation between data sources and the rest of the application.

- **MVP Design Pattern:**
Adopts the Model-View-Presenter (MVP) architecture for clear separation of concerns, enhancing maintainability and testability.

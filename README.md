# knovator_gk_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
Dynamic Post List:

Fetches a list of posts from JSONPlaceholder API.
Displays titles of the posts in a scrollable list with light yellow highlights.
Detailed View:

Clicking on a post navigates to a detail screen.
Fetches detailed content from https://jsonplaceholder.typicode.com/posts/{postId}.
Offline Support:

Saves posts to local storage using shared_preferences.
Loads cached data when the device is offline.
Timer Integration:

Displays a random countdown timer (e.g., 10, 20, or 25 seconds) for each post.
Timer pauses when the post leaves the screen or when the user navigates to another page.
Connectivity Check:

Uses connectivity_plus to detect internet availability.
Syncs local data with the API when online.
State Management:

Built using Riverpod for efficient and scalable state management.

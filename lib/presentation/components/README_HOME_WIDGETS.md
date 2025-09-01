# Home Screen Widgets Documentation

## 🎯 Overview

This document describes the reusable custom widgets created for the home screen:

1. **QuickActionCard** - For applying leave/half day quickly
2. **RecentRequestCard** - For showing the last applied leave
3. **HomeController** - For managing the data and state

## 🚀 Quick Action Card

### Purpose

Provides quick access to common leave application types with a modern, card-based UI.

### Features

- ✅ **4 Action Types**: Apply Leave, Half Day, Sick Leave, Work From Home
- ✅ **Visual Design**: Color-coded buttons with icons and descriptions
- ✅ **Navigation**: Automatically navigates to apply leave screen
- ✅ **Responsive**: Adapts to different screen sizes

### Usage

```dart
import 'package:arch_approve/presentation/components/quick_action_card.dart';

// Basic usage
const QuickActionCard()

// The widget handles all navigation internally
```

### Customization

The widget automatically handles:

- Navigation to apply leave screen
- Pre-selection of leave types
- Visual feedback and animations

## 📋 Recent Request Card

### Purpose

Displays the most recent leave application with status, details, and actions.

### Features

- ✅ **Recent Leave Display**: Shows last applied leave with full details
- ✅ **Status Indicators**: Color-coded status chips (Pending/Approved/Rejected)
- ✅ **Attachment Support**: Displays file attachments if present
- ✅ **Empty State**: Handles cases when no leaves exist
- ✅ **Action Buttons**: View details and apply for new leave

### Usage

```dart
import 'package:arch_approve/presentation/components/recent_request_card.dart';

// With recent leave data
RecentRequestCard(
  recentLeave: leaveModel,
  onViewAll: () => navigateToHistory(),
)

// Without data (shows empty state)
RecentRequestCard(
  recentLeave: null,
  onViewAll: () => navigateToHistory(),
)
```

### Props

- `recentLeave`: The most recent LeaveModel (optional)
- `onViewAll`: Callback for viewing all leaves (optional)

## 🎮 Home Controller

### Purpose

Manages the data and state for the home screen widgets.

### Features

- ✅ **Data Loading**: Fetches recent leave from Firebase
- ✅ **State Management**: Handles loading, error, and success states
- ✅ **Statistics**: Provides leave count statistics
- ✅ **Refresh**: Supports pull-to-refresh functionality

### Usage

```dart
import 'package:arch_approve/presentation/controllers/home_controller.dart';

// Initialize in your screen
final homeController = Get.put(HomeController());

// Access data
final recentLeave = homeController.getRecentLeave;
final stats = homeController.getLeaveStats();
final isLoading = homeController.getIsLoading;

// Refresh data
await homeController.refreshData();
```

### Available Methods

- `refreshData()`: Reloads leave data
- `getLeaveStats()`: Returns leave statistics
- `viewAllLeaves()`: Navigation to leave history
- `viewLeaveDetails(leave)`: View specific leave details

### Observable Properties

- `recentLeave`: Most recent leave application
- `allLeaves`: List of all user leaves
- `isLoading`: Loading state
- `errorMessage`: Error message if any

## 🎨 Complete Home Screen Example

### Implementation

```dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: RefreshIndicator(
        onRefresh: () => homeController.refreshData(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Quick Actions
              const QuickActionCard(),

              // Recent Request
              Obx(() => RecentRequestCard(
                recentLeave: homeController.getRecentLeave,
                onViewAll: homeController.viewAllLeaves,
              )),

              // Additional content...
            ],
          ),
        ),
      ),
    );
  }
}
```

## 🔧 Customization Options

### Quick Action Card

- **Colors**: Modify the color scheme in the widget
- **Actions**: Add/remove action types by editing the widget
- **Navigation**: Customize navigation behavior
- **Icons**: Change icons for different action types

### Recent Request Card

- **Layout**: Adjust spacing and sizing
- **Status Colors**: Customize status chip colors
- **Empty State**: Modify the no-leaves message
- **Actions**: Add custom action buttons

### Home Controller

- **Data Source**: Change from Firebase to other services
- **Caching**: Implement data caching strategies
- **Error Handling**: Customize error messages and retry logic
- **Statistics**: Add more statistical calculations

## 📱 Responsive Design

### Mobile

- Cards stack vertically
- Touch-friendly button sizes
- Optimized for portrait orientation

### Tablet

- Cards can be arranged in grid
- Larger touch targets
- Landscape orientation support

### Desktop

- Hover effects on buttons
- Keyboard navigation support
- Larger content areas

## 🎯 Best Practices

### Performance

- Use `Obx()` only around widgets that need reactive updates
- Implement proper error boundaries
- Cache data when appropriate

### User Experience

- Provide clear loading states
- Handle empty states gracefully
- Give meaningful error messages
- Support pull-to-refresh

### Accessibility

- Use semantic labels for screen readers
- Provide sufficient color contrast
- Support keyboard navigation
- Include proper ARIA attributes

## 🚀 Future Enhancements

### Planned Features

- 🔄 **Real-time Updates**: Live status updates
- 🔄 **Push Notifications**: Status change notifications
- 🔄 **Offline Support**: Cache data for offline viewing
- 🔄 **Analytics**: Track user interactions

### Customization Requests

- 🔄 **Theme Support**: Dark/light mode
- 🔄 **Localization**: Multi-language support
- 🔄 **Custom Actions**: User-defined quick actions
- 🔄 **Widget Reordering**: Drag-and-drop customization

## 📞 Support

### Common Issues

1. **Widget not updating**: Ensure you're using `Obx()` or `GetBuilder`
2. **Navigation not working**: Check route constants and navigation setup
3. **Data not loading**: Verify Firebase configuration and authentication
4. **Performance issues**: Check for unnecessary rebuilds

### Getting Help

- Check the example implementation
- Review the controller logic
- Verify your data models
- Test with sample data first

## 🎉 Conclusion

These widgets provide a complete, professional home screen experience for leave management. They're designed to be:

- **Reusable** across different screens
- **Customizable** for different use cases
- **Performant** with proper state management
- **Accessible** for all users

Use them as building blocks to create engaging, functional home screens in your leave management application!

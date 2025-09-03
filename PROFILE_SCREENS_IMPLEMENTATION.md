# Profile Screens Implementation

This document outlines the three profile screens that have been implemented for the ArchApprove application.

## 1. Update Profile Screen (`update_profile_screen.dart`)

### Features:

- **Form Fields**: Full Name, Email Address, Contact Number
- **Validation**:
  - Name must be at least 2 characters
  - Email must be in valid format
  - Contact number must be at least 10 digits
- **Functionality**:
  - Loads existing user data from local storage
  - Updates user profile in Firestore database
  - Updates local storage with new information
  - Form validation with error messages
  - Success/error notifications
- **UI Components**:
  - Beautiful gradient header with icon
  - Themed text fields matching app design
  - Primary action button (Update Profile)
  - Secondary action button (Cancel)
  - Loading states during operations

### Technical Details:

- Uses `TextFormField` with custom validators
- Integrates with Firebase Firestore for data persistence
- Updates local SharedPreferences storage
- Follows app's theme colors and styling

## 2. Change Password Screen (`change_password_screen.dart`)

### Features:

- **Form Fields**: Current Password, New Password, Confirm Password
- **Validation**:
  - Current password required
  - New password must be at least 6 characters
  - Confirm password must match new password
- **Functionality**:
  - Re-authenticates user before password change
  - Updates Firebase Auth password
  - Comprehensive error handling for various scenarios
  - Success/error notifications
- **Security Features**:
  - Password visibility toggles for all fields
  - Re-authentication required for security
  - Handles Firebase Auth exceptions gracefully
- **UI Components**:
  - Gradient header with lock icon
  - Information card explaining password requirements
  - Themed password fields with visibility toggles
  - Primary action button (Change Password)
  - Secondary action button (Cancel)

### Technical Details:

- Uses `TextFormField` with password validation
- Integrates with Firebase Authentication
- Implements proper error handling for different Firebase error codes
- Follows app's theme colors and styling

## 3. Terms & Conditions Screen (`terms_conditions_screen.dart`)

### Features:

- **Content**: Comprehensive terms and conditions document
- **Sections**:
  - Acceptance of Terms
  - Use License
  - User Account
  - Leave Management
  - Data Privacy
  - Prohibited Uses
  - Disclaimer
  - Limitations
  - Revisions and Errata
  - Links
  - Modifications
  - Governing Law
- **Functionality**:
  - Scrollable content
  - Accept button with confirmation
  - Last updated timestamp
- **UI Components**:
  - Gradient header with document icon
  - Clean, readable content layout
  - Information card showing last update
  - Primary action button (I Accept)
  - Success notification on acceptance

### Technical Details:

- Static content display
- Responsive layout with proper spacing
- Follows app's theme colors and styling
- Uses GetX for navigation and notifications

## Common Features Across All Screens

### Theme Integration:

- **Colors**: Uses app's defined color constants (`kPrimaryColor`, `kSecondaryColor`, etc.)
- **Typography**: Follows app's text theme styles
- **Gradients**: Consistent use of `kL` gradient for headers
- **Shadows**: Consistent shadow styling for depth

### Navigation:

- **App Bar**: Consistent styling with app theme
- **Back Navigation**: Proper back button functionality
- **Route Integration**: All screens properly integrated into app routing

### Error Handling:

- **User Feedback**: Snackbar notifications for success/error states
- **Loading States**: Proper loading indicators during async operations
- **Validation**: Form validation with user-friendly error messages

## Route Configuration

All screens are properly configured in the app routing system:

```dart
// Profile Routes
GetPage(
  name: AppRoutesConstant.updateProfile,
  page: () => const UpdateProfileScreen(),
  transitionDuration: const Duration(milliseconds: 300),
  transition: Transition.fadeIn,
),

GetPage(
  name: AppRoutesConstant.changePassword,
  page: () => const ChangePasswordScreen(),
  transitionDuration: const Duration(milliseconds: 300),
  transition: Transition.fadeIn,
),

GetPage(
  name: AppRoutesConstant.terms,
  page: () => const TermsConditionsScreen(),
  transitionDuration: const Duration(milliseconds: 300),
  transition: Transition.fadeIn,
),
```

## Local Storage Updates

Enhanced the `UserPref` class with individual setters for profile updates:

```dart
static Future<void> setName(String name) async
static Future<void> setEmail(String email) async
static Future<void> setContactNo(String contactNo) async
```

## Integration with Profile Screen

Updated the main profile screen to enable navigation to all three new screens:

```dart
_buildTile(
  icon: Icons.person_outline,
  title: "Update Profile",
  onTap: () => Get.toNamed(AppRoutesConstant.updateProfile),
),
```

## Dependencies Used

- **Firebase**: Authentication and Firestore for data persistence
- **GetX**: State management, navigation, and notifications
- **Flutter**: Core UI components and form handling
- **SharedPreferences**: Local data storage

## Testing Status

All screens have been analyzed with `flutter analyze` and show no critical compilation errors. Only minor deprecation warnings about `withOpacity` usage were found, which don't affect functionality.

## Next Steps

The screens are ready for:

1. User testing and feedback
2. Integration with backend services
3. Additional validation rules if needed
4. Localization for multiple languages
5. Accessibility improvements

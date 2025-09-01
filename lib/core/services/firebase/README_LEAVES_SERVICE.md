# Firebase Leaves Service Documentation

## Overview

The Firebase Leaves Service provides a comprehensive solution for managing leave applications in the Arch Approve application. It follows the repository pattern and integrates with Firebase Firestore to store and manage leave data.

## Architecture

### 1. Data Model (`Leave_Model.dart`)

- **LeaveModel**: Represents a leave application with all necessary fields
- **LeaveStatus**: Enum for leave status (pending, accepted, rejected)
- **Fields**: Includes leave details, user information, timestamps, and approval data

### 2. Service Layer (`leave_services.dart`)

- **FirebaseLeavesService**: Core service that handles all Firebase operations
- **Collection**: Uses "Leaves post" collection in Firestore
- **Features**: CRUD operations, status updates, statistics, and real-time streams

### 3. Repository Pattern

- **FirebaseLeavesRepository**: Abstract interface defining the contract
- **FirebaseLeavesRepositoryImpl**: Concrete implementation using the service

## Key Features

### Leave Application Management

- ✅ Create new leave applications
- ✅ Submit with current user data automatically
- ✅ File attachment support (prepared for Firebase Storage)
- ✅ Status tracking (PENDING, ACCEPTED, REJECTED)

### Timestamps

- ✅ `createdAt` (submittedAt): When the leave was submitted
- ✅ `updatedAt`: Last modification timestamp
- ✅ `approvedAt`: When the leave was approved/rejected

### User Integration

- ✅ Automatically fetches current user data from FirebaseDataService
- ✅ Stores complete user information with each leave application
- ✅ User identification via UID

### Status Management

- ✅ **PENDING**: Initial state when leave is submitted
- ✅ **ACCEPTED**: When leave is approved by manager/admin
- ✅ **REJECTED**: When leave is rejected with reason

## Usage Examples

### Basic Leave Submission

```dart
final leavesService = FirebaseLeavesService();

final leaveId = await leavesService.createLeaveApplicationWithUser(
  leaveType: 'Annual Leave',
  startDate: '2024-01-15',
  endDate: '2024-01-17',
  reason: 'Family vacation',
  description: 'Taking time off for family vacation',
  attachment: fileInfo,
);
```

### Approve/Reject Leave

```dart
// Approve
await leavesService.updateLeaveStatus(
  leaveId,
  LeaveStatus.accepted,
  approvedBy: 'Manager Name',
);

// Reject
await leavesService.updateLeaveStatus(
  leaveId,
  LeaveStatus.rejected,
  rejectionReason: 'Insufficient notice period',
);
```

### Get User Leaves

```dart
final userLeaves = await leavesService.getUserLeaves(userId);
final pendingLeaves = await leavesService.getPendingLeaves();
final allLeaves = await leavesService.getAllLeaves();
```

### Real-time Updates

```dart
leavesService.streamUserLeaves(userId).listen((leaves) {
  // Handle real-time updates
  print('User has ${leaves.length} leave applications');
});
```

## Database Structure

### Collection: "Leaves post"

```json
{
  "leaveType": "Annual Leave",
  "startDate": "2024-01-15",
  "endDate": "2024-01-17",
  "reason": "Family vacation",
  "description": "Taking time off for family vacation",
  "status": "pending",
  "user": {
    "name": "John Doe",
    "email": "john@example.com",
    "uid": "user123",
    "role": "Employee"
  },
  "attachment": {
    "fileName": "vacation_request.pdf",
    "fileSize": 1024000,
    "uploadedAt": "2024-01-10T10:00:00Z"
  },
  "submittedAt": "2024-01-10T10:00:00Z",
  "updatedAt": "2024-01-10T10:00:00Z",
  "approvedBy": null,
  "approvedAt": null,
  "rejectionReason": null
}
```

## Integration with Existing Code

### ApplyLeaveController

- ✅ Updated to use FirebaseLeavesService instead of Appwrite
- ✅ Maintains same UI and user experience
- ✅ Automatically submits leave applications to Firebase
- ✅ Handles file attachments (prepared for Firebase Storage)

### FirebaseDataService

- ✅ Leverages existing user data retrieval
- ✅ Maintains consistency with current architecture
- ✅ Reuses authentication and Firestore instances

## Error Handling

### Service Level

- ✅ Comprehensive try-catch blocks
- ✅ Detailed error logging
- ✅ Graceful fallbacks for failed operations

### Controller Level

- ✅ User-friendly error messages
- ✅ Snackbar notifications for success/failure
- ✅ Form validation before submission

## Future Enhancements

### Firebase Storage Integration

- 🔄 File upload to Firebase Storage
- 🔄 Secure file access and permissions
- 🔄 File metadata management

### Notifications

- 🔄 Push notifications for status updates
- 🔄 Email notifications for approvals/rejections
- 🔄 In-app notification system

### Advanced Features

- 🔄 Leave balance tracking
- 🔄 Approval workflows
- 🔄 Leave calendar integration
- 🔄 Reporting and analytics

## Dependencies

### Required Packages

- `cloud_firestore`: Firestore database operations
- `firebase_auth`: User authentication
- `get`: State management and navigation

### Internal Dependencies

- `FirebaseDataService`: User data retrieval
- `UserModel`: User data structure
- `LeaveModel`: Leave data structure

## Security Considerations

### Firestore Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /Leaves post/{document} {
      allow read: if request.auth != null &&
        (resource.data.user.uid == request.auth.uid ||
         request.auth.token.role == 'admin');
      allow write: if request.auth != null;
    }
  }
}
```

### Data Validation

- ✅ Server-side validation in Firestore rules
- ✅ Client-side validation in controllers
- ✅ User authentication required for all operations

## Testing

### Unit Tests

- ✅ Service method testing
- ✅ Repository pattern testing
- ✅ Model serialization testing

### Integration Tests

- ✅ Firebase connectivity testing
- ✅ End-to-end leave submission flow
- ✅ Status update workflow testing

## Support and Maintenance

### Code Organization

- ✅ Clean separation of concerns
- ✅ Repository pattern for testability
- ✅ Comprehensive error handling
- ✅ Detailed documentation

### Performance

- ✅ Efficient Firestore queries
- ✅ Real-time streaming for updates
- ✅ Optimized data fetching

### Scalability

- ✅ Firestore's automatic scaling
- ✅ Efficient indexing strategies
- ✅ Pagination support for large datasets

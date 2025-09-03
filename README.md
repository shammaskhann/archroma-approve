# 🏢 ArchApprove - Employee Leave Management System

A comprehensive Flutter-based employee leave management application with role-based access control, real-time notifications, and modern UI/UX design.

## 📱 Features

### 🔐 Authentication & User Management

- **Firebase Authentication** - Secure user login/logout
- **Role-based Access Control** - Employee, Admin, IT, Manager roles
- **Password Reset** - Email-based password recovery
- **Profile Management** - Update personal information and change passwords

### 📋 Leave Management

- **Leave Applications** - Submit casual, annual, and sick leave requests
- **File Attachments** - Support for document uploads (Appwrite storage)
- **Leave History** - Track all leave applications and their status
- **Real-time Updates** - Live status changes and notifications

### 👨‍💼 Admin Features

- **Employee Management** - Add, edit, and manage employee records
- **Leave Approval System** - Approve/reject leave requests with reasons
- **Dashboard Analytics** - Overview of leave statistics and pending requests
- **Calendar View** - Visual representation of leave schedules

### 📊 Dashboard & Analytics

- **Personal Dashboard** - Individual leave statistics and recent activities
- **Admin Dashboard** - Comprehensive overview of all employees and requests
- **Leave Statistics** - Visual charts and data representation
- **Real-time Notifications** - FCM push notifications for updates

### 🎨 UI/UX Features

- **Responsive Design** - Web and mobile optimized layouts
- **Material Design 3** - Modern Flutter UI components
- **Custom Theme** - Consistent color scheme and typography
- **Dark/Light Mode** - Theme switching capabilities

## 🏗️ Architecture

### 📁 Project Structure

```
arch_approve/
├── lib/
│   ├── core/                           # Core application logic
│   │   ├── constants/                  # App constants and theme
│   │   ├── services/                   # Firebase, Appwrite, SharedPref services
│   │   └── utils/                      # Utility functions and helpers
│   ├── data/                           # Data layer
│   │   ├── models/                     # Data models (User, Leave, etc.)
│   │   └── repositories/               # Repository implementations
│   ├── domain/                         # Business logic layer
│   ├── presentation/                   # UI layer
│   │   ├── components/                 # Reusable UI components
│   │   ├── controllers/                # GetX state management
│   │   ├── routes/                     # App navigation and routing
│   │   ├── screens/                    # Main app screens
│   │   └── screens_admin/              # Admin-specific screens
│   └── main.dart                       # App entry point
├── assets/                             # Images, icons, and fonts
├── android/                            # Android-specific configurations
├── ios/                                # iOS-specific configurations
├── web/                                # Web platform configurations
└── pubspec.yaml                        # Dependencies and project configuration
```

### 🔥 Firebase Integration

#### Firestore Collections

```
users/
├── {userId}/
│   ├── name: String
│   ├── email: String
│   ├── role: String (employee/admin/it/manager)
│   ├── contactNo: String
│   ├── department: String
│   └── createdAt: Timestamp

employee/
├── {userId}/
│   ├── name: String
│   ├── email: String
│   ├── role: String
│   ├── contactNo: String
│   ├── department: String
│   ├── isDeleted: Boolean
│   ├── deletedAt: Timestamp
│   └── deletedBy: String

leaves/
├── {leaveId}/
│   ├── userId: String
│   ├── leaveType: String (casual/annual/sick)
│   ├── startDate: String
│   ├── endDate: String
│   ├── reason: String
│   ├── description: String
│   ├── status: String (pending/accepted/rejected)
│   ├── attachment: String (file URL)
│   ├── leaveDuration: String
│   ├── shouldDeduct: Boolean
│   ├── deductForm: String
│   ├── submittedAt: Timestamp
│   ├── updatedAt: Timestamp
│   ├── approvedBy: String
│   ├── rejectionReason: String
│   └── approvedAt: Timestamp

leave_stats/
├── {userId}/
│   ├── casualLeaves: Number
│   ├── annualLeaves: Number
│   ├── sickLeaves: Number
│   └── lastUpdated: Timestamp
```

#### Firebase Authentication

- **Email/Password Authentication**
- **User Role Management**
- **Password Reset via Email**
- **Secure Session Management**

### 📁 Appwrite Storage Structure

#### Buckets

```
attachments/
├── leave_documents/                    # Leave application attachments
│   ├── {userId}/{timestamp}_{filename}
│   └── {leaveId}/{filename}
├── profile_pictures/                   # User profile images
│   └── {userId}/{filename}
└── company_documents/                  # Company-wide documents
    └── {category}/{filename}
```

#### File Management

- **Automatic File Organization** - Structured folder hierarchy
- **File Type Validation** - PDF, DOC, DOCX, Images support
- **Size Limits** - Configurable file size restrictions
- **Access Control** - Role-based file access permissions

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (^3.9.0)
- Dart SDK
- Android Studio / VS Code
- Firebase Project
- Appwrite Instance

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/arch_approve.git
   cd arch_approve
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Configure Firebase**

   - Create a Firebase project
   - Download `google-services.json` for Android
   - Download `GoogleService-Info.plist` for iOS
   - Enable Authentication and Firestore

4. **Configure Appwrite**

   - Set up Appwrite instance
   - Create storage buckets
   - Configure API keys

5. **Update configuration files**

   - `lib/firebase_options.dart`
   - Environment variables for Appwrite

6. **Run the application**
   ```bash
   flutter run
   ```

## 🛠️ Tech Stack

### Frontend

- **Flutter** - Cross-platform UI framework
- **Dart** - Programming language
- **GetX** - State management and navigation
- **Material Design 3** - UI components

### Backend Services

- **Firebase Authentication** - User authentication
- **Cloud Firestore** - NoSQL database
- **Appwrite** - File storage and management
- **Firebase Cloud Messaging** - Push notifications

### State Management

- **GetX** - Reactive state management
- **Observable Variables** - Real-time UI updates
- **Dependency Injection** - Service management

### Local Storage

- **SharedPreferences** - User preferences and cache
- **Local Notifications** - In-app notifications

## 📱 Screenshots

### Employee Dashboard

- Personal leave statistics
- Recent leave applications
- Quick leave application form

### Admin Dashboard

- Employee management
- Leave approval interface
- Analytics and reports

### Profile Management

- Update personal information
- Change password
- Terms & conditions

## 🔧 Configuration

### Environment Variables

```dart
// Firebase Configuration
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_API_KEY=your_api_key

// Appwrite Configuration
APPWRITE_ENDPOINT=your_appwrite_endpoint
APPWRITE_PROJECT_ID=your_project_id
APPWRITE_API_KEY=your_api_key
```

### Build Configuration

```yaml
# Android
android/app/build.gradle
android/app/src/main/AndroidManifest.xml

# iOS
ios/Runner/Info.plist
ios/Runner/GoogleService-Info.plist
```

## 📊 Performance Features

- **Lazy Loading** - Efficient data loading
- **Image Caching** - Optimized file storage
- **Real-time Updates** - Live data synchronization
- **Offline Support** - Basic offline functionality
- **Memory Management** - Optimized resource usage

## 🔒 Security Features

- **Firebase Security Rules** - Database access control
- **Role-based Permissions** - User access management
- **Secure File Storage** - Encrypted file handling
- **Input Validation** - Form security measures
- **Session Management** - Secure authentication

## 🧪 Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/

# Generate test coverage
flutter test --coverage
```

## 📦 Build & Deploy

### Android APK

```bash
flutter build apk --release
```

### Android App Bundle

```bash
flutter build appbundle --release
```

### Web Build

```bash
flutter build web --release
```

### iOS Build

```bash
flutter build ios --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Team

- **Lead Developer** - [Your Name]
- **UI/UX Designer** - [Designer Name]
- **Backend Developer** - [Backend Developer Name]

## 📞 Support

- **Email**: support@archapprove.com
- **Documentation**: [Wiki Link]
- **Issues**: [GitHub Issues](https://github.com/yourusername/arch_approve/issues)

## 🚀 Roadmap

- [ ] **Mobile App** - iOS and Android native apps
- [ ] **Advanced Analytics** - Business intelligence dashboard
- [ ] **API Integration** - Third-party service integrations
- [ ] **Multi-language Support** - Internationalization
- [ ] **Advanced Reporting** - Custom report generation
- [ ] **Workflow Automation** - Automated approval processes

---

⭐ **Star this repository if you find it helpful!**

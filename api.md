# Todo App Authentication & API Integration Documentation

This document provides the complete, corrected implementation of the authentication system, including login, logout, user details fetching, and route protection.

---

## 1. Storage Utility (`TLocalStorage`)
Used to persist `accessToken` and `refreshToken` locally using `shared_preferences`.

**File Path:** `lib/utils/helpers/storage_utility.dart`

```dart
import 'package:shared_preferences/shared_preferences.dart';

class TLocalStorage {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveData(String key, dynamic value) async {
    if (value is String) await _prefs?.setString(key, value);
    if (value is bool) await _prefs?.setBool(key, value);
    if (value is int) await _prefs?.setInt(key, value);
    if (value is double) await _prefs?.setDouble(key, value);
  }

  static dynamic readData(String key) => _prefs?.get(key);

  static Future<void> clearAll() async => await _prefs?.clear();
}
```

---

## 2. Mandatory Login & Route Protection
The app entry point checks for an `accessToken` to decide whether to show the Login screen or the Dashboard.

**File Path:** `lib/main.dart`

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TLocalStorage.init(); // Initialize storage before app starts
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Check for tokens to determine initial route
    final String? accessToken = TLocalStorage.readData('accessToken');
    final String initialRoute = accessToken != null ? "/home-navigation" : "/";

    return GetMaterialApp(
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: "/", page: () => const SplashScreen()),
        GetPage(name: "/login", page: () => const LoginScreen()),
        GetPage(name: "/home-navigation", page: () => const BottomNavigation()),
        // ... other routes
      ],
    );
  }
}
```

---

## 3. Login Implementation (Username/Password)
Handles authentication and extracts tokens from both the **Response Body** and **Set-Cookie Headers**.

**Endpoint:** `POST https://authentication-liart-kappa.vercel.app/api/auth/login`

**File Path:** `lib/screens/auth/login/login_form.dart`

```dart
Future<void> login() async {
  try {
    final dio = Dio();
    final response = await dio.post(
      'https://authentication-liart-kappa.vercel.app/api/auth/login',
      data: {
        'username': usernameController.text.trim(),
        'password': passwordController.text.trim(),
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final dynamic responseBody = response.data;
      String accessToken = '';
      String refreshToken = '';

      // 1. Extract from Body (Check nested 'data' field)
      if (responseBody is Map) {
        final dataField = responseBody['data'];
        if (dataField is Map) {
          accessToken = dataField['accessToken']?.toString() ?? '';
          refreshToken = dataField['refreshToken']?.toString() ?? '';
        }
        if (accessToken.isEmpty) accessToken = responseBody['accessToken']?.toString() ?? '';
      }

      // 2. Extract from Set-Cookie Headers (Critical for this API)
      final List<String>? cookies = response.headers['set-cookie'];
      if (cookies != null) {
        for (var cookie in cookies) {
          if (cookie.contains('accessToken=')) {
            accessToken = cookie.split('accessToken=')[1].split(';')[0];
          }
          if (cookie.contains('refreshToken=')) {
            refreshToken = cookie.split('refreshToken=')[1].split(';')[0];
          }
        }
      }

      if (accessToken.isNotEmpty) {
        await TLocalStorage.saveData('accessToken', accessToken);
        await TLocalStorage.saveData('refreshToken', refreshToken);
        Get.offAll(() => const BottomNavigation());
      }
    }
  } catch (e) {
    Get.snackbar('Login Failed', 'Invalid credentials or server error');
  }
}
```

---

## 4. Fetching User Details (Protected Route)
Uses the `accessToken` as a Bearer token to fetch user profile data.

**Endpoint:** `GET https://authentication-liart-kappa.vercel.app/api/user/details`

**File Path:** `lib/screens/user_profile.dart`

```dart
Future<void> fetchUserDetails() async {
  try {
    final dio = Dio();
    final accessToken = TLocalStorage.readData('accessToken');

    final response = await dio.get(
      'https://authentication-liart-kappa.vercel.app/api/user/details',
      options: Options(
        headers: {'Authorization': 'Bearer $accessToken'},
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = response.data;
      if (responseData['success'] == true && responseData['data'] != null) {
        setState(() {
          user = UserModel.fromJson(responseData['data']);
        });
      }
    }
  } catch (e) {
    print("Fetch Error: $e");
  }
}
```

---

## 5. Logout Implementation
Clears local storage and invalidates the session on the server.

**Endpoint:** `POST https://authentication-liart-kappa.vercel.app/api/auth/logout`

**File Path:** `lib/screens/user_profile.dart`

```dart
Future<void> logout() async {
  try {
    final dio = Dio();
    final refreshToken = TLocalStorage.readData('refreshToken');

    await dio.post(
      'https://authentication-liart-kappa.vercel.app/api/auth/logout',
      data: {'refreshToken': refreshToken},
    );
  } finally {
    // Always clear local data and redirect to login/splash
    await TLocalStorage.clearAll();
    Get.offAllNamed("/");
  }
}
```

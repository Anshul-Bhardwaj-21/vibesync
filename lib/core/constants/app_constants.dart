class AppConstants {
  // API Endpoints
  static const String baseUrl = 'https://api.vibesync.com/v1';
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'app_theme';
  
  // Asset Paths
  static const String imagePath = 'assets/images';
  static const String iconPath = 'assets/icons';
  static const String animationPath = 'assets/animations';
  
  // Animation Durations
  static const Duration splashDuration = Duration(seconds: 2);
  static const Duration pageTransitionDuration = Duration(milliseconds: 300);
  
  // Player Constants
  static const double minPlayerHeight = 60.0;
  static const double maxPlayerHeight = 400.0;
  
  // Cache Duration
  static const Duration cacheDuration = Duration(days: 7);
  
  // Pagination
  static const int defaultPageSize = 20;
  
  // Error Messages
  static const String networkError = 'Please check your internet connection';
  static const String serverError = 'Something went wrong. Please try again later';
  static const String authError = 'Authentication failed. Please login again';
  
  // Success Messages
  static const String loginSuccess = 'Successfully logged in';
  static const String logoutSuccess = 'Successfully logged out';
  static const String downloadSuccess = 'Successfully downloaded';
  
  // Validation Messages
  static const String emailRequired = 'Email is required';
  static const String passwordRequired = 'Password is required';
  static const String invalidEmail = 'Please enter a valid email';
  static const String invalidPassword = 'Password must be at least 6 characters';
} 
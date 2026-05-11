# General Flutter rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Stripe specific rules to handle missing classes in R8
-dontwarn com.stripe.**
-keep class com.stripe.** { *; }

# Handling references from react-native-stripe-sdk logic (used by flutter_stripe)
-dontwarn com.reactnativestripesdk.**
-keep class com.reactnativestripesdk.** { *; }

# If R8 still fails due to missing classes, this tells it to ignore them
-ignorewarnings

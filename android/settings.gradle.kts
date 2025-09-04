import kotlin.io.path.name

pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
    plugins {
        // Manage the versions of commonly used plugins here
        // Use the versions you found in the new project:
        id("com.android.application") version "8.9.1" apply false
        id("org.jetbrains.kotlin.android") version "2.1.0" apply false
        // This is the plugin loader you found, declare it here as well
        id("dev.flutter.flutter-plugin-loader") version "1.0.0" apply false
    }
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.name = "my_app"
include(":app")

// This section is often added by Flutter to apply its settings
// It might be in a separate flutter.gradle file, but can also be her// Or potentially "flutter_settings.gradle" if that's what your project uses


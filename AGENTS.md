# appmovilwidgets

Flutter app implementing PageView and ProgressBar widgets.

## Rutas

- Flutter SDK: `/home/snz/development/flutter`
- Android SDK: `/opt/android-sdk`

## Comandos

```bash
export PATH="/home/snz/development/flutter/bin:$PATH"
export ANDROID_SDK_ROOT="/opt/android-sdk"
flutter run                    # Linux (ya configurado)
flutter build apk --debug      # Android
```

## Configuración del entorno

- Usar **Java 17** (no Java 26). Configurar con `flutter config --jdk-dir=/usr/lib/jvm/java-17-openjdk`.
- Gradle 8.11 configurado en `android/gradle/wrapper/gradle-wrapper.properties`.
- Plugin Android 8.7.0 en `android/settings.gradle`.

## Estructura

- Entrypoint: `lib/main.dart`
- Widgets implementados: PageView (3 páginas), LinearProgressIndicator, CircularProgressIndicator
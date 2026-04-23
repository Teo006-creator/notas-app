# AppMovilWidgets

Aplicación Flutter que demuestra el uso de widgets interactivos: **PageView** (navegación entre páginas) y **ProgressBar** (indicadores de progreso lineales y circulares).

## Arquitectura del Proyecto

```
appmovilwidgets/
├── lib/
│   └── main.dart          # Entrypoint y toda la UI
├── android/               # Configuración Android
├── ios/                   # Configuración iOS
├── linux/                 # Configuración Linux
├── test/                  # Pruebas automáticas
├── pubspec.yaml           # Dependencias y metadatos
└── README.md              # Este archivo
```

### Estructura de Código

El archivo `lib/main.dart` contiene toda la aplicación organizada en:

| Componente | Descripción |
|------------|-------------|
| `MyApp` | Widget raíz stateless que configura MaterialApp con tema y título |
| `DemoPage` | StatefulWidget principal que gestiona el estado de navegación y progreso |
| `_DemoPageState` | Lógica de negocio: PageController, navegación y control de progreso |

### Flujo de la Aplicación

```
MyApp (StatelessWidget)
    │
    └── MaterialApp
            │
            └── DemoPage (StatefulWidget)
                    │
                    └── Scaffold
                            ├── AppBar (título)
                            │
                            ├── PageView (3 páginas con navegación)
                            │
                            ├── Botones Anterior/Siguiente
                            │
                            ├── LinearProgressIndicator
                            │
                            └── CircularProgressIndicator
```

## Widgets Demonstrados

### PageView
- **Función**: Contenedor de scroll horizontal para múltiples páginas
- **Navegación**: Botones manual + swipe táctil
- **Control**: `PageController` para control programático
- **Delegados**: `onPageChanged` para sincronizar estado

### LinearProgressIndicator
- **Función**: Barra de progreso horizontal
- **Propiedad**: `value` (0.0 a 1.0) controla el porcentaje
- **Estilo**: `minHeight` para grosor

### CircularProgressIndicator
- **Función**: Indicador circular de progreso
- **Propiedad**: `value` (0.0 a 1.0) controla el porcentaje
- **Estilo**: `strokeWidth` para grosor del arco

## Requisitos

- **Flutter SDK**: 3.x o superior
- **Dart**: 3.x o superior
- **Android SDK**: Configurado (para compilar APK)
- **Java**: OpenJDK 17

## Instalación

### 1. Clonar el Repositorio

```bash
git clone https://github.com/Teo006-creator/appmovilwidgets.git
cd appmovilwidgets
```

### 2. Instalar Dependencias

```bash
flutter pub get
```

### 3. Configurar Android (si es necesario)

```bash
export ANDROID_SDK_ROOT="/opt/android-sdk"
flutter config --jdk-dir=/usr/lib/jvm/java-17-openjdk
```

### 4. Ejecutar la Aplicación

```bash
flutter run                    # Linux (ya configurado)
flutter run -d windows       # Windows
flutter run -d macos        # macOS
```

### 5. Compilar APK de Debug

```bash
flutter build apk --debug
```

El APK se genera en: `build/app/outputs/flutter-apk/app-debug.apk`

### 6. Compilar APK de Release

```bash
flutter build apk --release
```

## Uso de la Aplicación

1. **Navegar páginas**: Toca los botones "Anterior" / "Siguiente" o desliza horizontalmente
2. **Ver progreso**: Los indicadores se actualizan según la página actual
   - Página 1 → 33%
   - Página 2 → 66%
   - Página 3 → 100%

## Tecnologías

| Categoría | Tecnología |
|----------|-----------|
| Framework | Flutter |
| Lenguaje | Dart |
| Estado | StatefulWidget (setState) |
| Diseño | Material Design 3 |
| Control | PageController |
| Entorno | Arch Linux |
| SO Desarrollo | Arch Linux |

## Licencia

Este proyecto está bajo licencia MIT.
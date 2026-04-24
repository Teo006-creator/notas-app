# Notas App

Aplicación Flutter que demuestra el uso de **widgets interactivos** en Flutter, diseñada como proyecto de taller sobre el impacto de los widgets en aplicaciones móviles.

## Arquitectura del Proyecto

```
notas-app/
├── lib/
│   └── main.dart          # Entrypoint y toda la UI
├── android/               # Configuración Android
├── ios/                   # Configuración iOS
├── linux/                 # Configuración Linux
├── test/                  # Pruebas automáticas
├── pubspec.yaml           # Dependencias y metadatos
└── README.md              # Este archivo
```

## Widgets Demonstrados

### Navegación y Estructura
| Widget | Descripción |
|--------|-------------|
| `AppBar` | Barra superior con título y acciones |
| `TabBar` + `TabController` | Sistema de pestañas (3 tabs) |
| `Drawer` | Menú lateral desplegable |
| `ListView` | Lista scrolleable de notas |
| `BottomSheet` | Hoja inferior para configuración |

### Entrada y Control
| Widget | Descripción |
|--------|-------------|
| `TextField` | Campos de texto para título y descripción |
| `Checkbox` | Marcar notas como completadas |
| `Switch` + `SwitchListTile` | Toggle para notificaciones y tema |
| `Radio` | Selector de prioridad (Baja/Media/Alta) |
| `Slider` | Control de tamaño de texto |

### Visualización
| Widget | Descripción |
|--------|-------------|
| `Card` | Tarjetas individuales por nota |
| `ExpansionTile` | Expandir/colapsar detalles de nota |
| `Chip` | Etiquetas de prioridad y fecha |
| `CircleAvatar` | Avatar del usuario en drawer |
| `NetworkImage` | Imagen de fondo en header |

### Interacción
| Widget | Descripción |
|--------|-------------|
| `FloatingActionButton` | Botón principal para agregar notas |
| `PopupMenuButton` | Menú contextual en AppBar y notas |
| `AlertDialog` | Diálogos de confirmación |
| `AboutDialog` | Información de la app |
| `SnackBar` | Notificaciones con acción "Deshacer" |

### Otros
| Widget | Descripción |
|--------|-------------|
| `Wrap` | Contenedor flexible para Chips |
| `Icon` | Iconos en toda la UI |
| `Divider` | Separador en drawer |
| `ListTile` | Items de navegación |

## Estructura de Código

El archivo `lib/main.dart` contiene:

| Clase | Tipo | Descripción |
|-------|------|-------------|
| `NotaApp` | StatelessWidget | Widget raíz con MaterialApp |
| `Nota` | Modelo | Clase de datos para notas |
| `HomePage` | StatefulWidget | Página principal con estado |
| `_HomePageState` | State | Lógica y gestión de UI |

### Flujo de la Aplicación

```
NotaApp (StatelessWidget)
    │
    └── MaterialApp
            │
            └── HomePage (StatefulWidget)
                    │
                    └── Scaffold
                            ├── AppBar + TabBar
                            ├── Drawer (menú lateral)
                            ├── TabBarView (3 pestañas)
                            │     └── ListView de Cards
                            └── Column + FloatingActionButtons
```

## Requisitos

- **Flutter SDK**: 3.x o superior
- **Dart**: 3.x o superior
- **Android SDK**: Configurado (para compilar APK)
- **Java**: OpenJDK 17

## Instalación

### 1. Clonar el Repositorio

```bash
git clone https://github.com/Teo006-creator/notas-app.git
cd notas-app
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
flutter run                    # Linux
flutter run -d windows       # Windows
flutter run -d macos        # macOS
```

### 5. Compilar APK

```bash
flutter build apk --debug     # Debug
flutter build apk --release   # Release
```

## Funcionalidades

1. **Agregar notas**: Título, descripción, prioridad e indicador de importancia
2. **Marcar completadas**: Checkbox para marcar/destacar notas
3. **Eliminar notas**: Botón con confirmación y opción deshacer
4. **Filtrar**: 3 pestañas (Todas, Importantes, Completadas)
5. **Ordenar**: Por fecha, prioridad o nombre
6. **Configuración**: Notificaciones, tema oscuro, tamaño de texto
7. **Navegación**: Drawer con perfil y secciones

## Impacto de los Widgets en UX

| Aspecto | Widgets Usados | Impacto |
|---------|----------------|---------|
| **Navegación** | TabBar, Drawer | Facilita acceso rápido a secciones |
| **Entrada de datos** | TextField, Radio, Switch | Formularios intuitivos y claros |
| **Visualización** | Card, Chip, ListView | Información organizada y legible |
| **Feedback** | SnackBar, Dialog | Comunicación clara con el usuario |
| **Acciones** | FAB, PopupMenu | Acciones rápidas siempre disponibles |

## Tecnologías

| Categoría | Tecnología |
|-----------|------------|
| Framework | Flutter |
| Lenguaje | Dart |
| Estado | StatefulWidget (setState) + TabController |
| Diseño | Material Design 3 |
| Control de versiones | Git + GitHub |
| Entorno | Arch Linux |

## Licencia

Este proyecto está bajo licencia MIT.
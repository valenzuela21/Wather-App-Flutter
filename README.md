# 🌦️ WeatherApp

Aplicación móvil desarrollada con Flutter para consultar información meteorológica en tiempo real, utilizando una arquitectura escalable, almacenamiento local y monitoreo de conectividad.

---

## 📋 Descripción

WeatherApp permite obtener datos climáticos desde una API externa y mostrarlos de forma sencilla e intuitiva. El proyecto implementa buenas prácticas de desarrollo, separación de responsabilidades y manejo robusto de errores.

## ✨ Características

- 🌤️ Consulta del clima actual.
- 🌍 Información meteorológica por ubicación.
- 📡 Detección de conexión a Internet.
- 💾 Almacenamiento local con Realm.
- ⚡ Arquitectura escalable y mantenible.
- 🔄 Manejo de estados y navegación con GetX.
- 📝 Registro de peticiones HTTP con Dio Logger.

---

## 🛠️ Tecnologías

### Framework

- Flutter
- Dart SDK ^3.11.1

### Dependencias principales

| Dependencia | Uso |
|------------|-----|
| get | Gestión de estado, navegación e inyección de dependencias |
| dio | Consumo de APIs REST |
| pretty_dio_logger | Logging de peticiones HTTP |
| connectivity_plus | Detección de conectividad |
| flutter_connectivity_service | Monitoreo de cambios de red |
| realm | Base de datos local |
| dartz | Programación funcional y manejo de errores |

---

## 📂 Estructura del Proyecto

```text
lib/
├── core/
│   ├── constants/
│   ├── network/
│   ├── services/
│   └── utils/
│
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
│
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
│
├── presentation/
│   ├── controllers/
│   ├── pages/
│   └── widgets/
│
└── main.dart
```

### Generar código (Realm)

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Ejecutar aplicación

```bash
flutter run
```

---

## 🧪 Pruebas

El proyecto incluye **41 tests** (unitarios, de integración y de widgets) que validan la lógica de negocio sin depender de la API real, de Realm ni de conectividad del dispositivo.

### Ejecutar tests

```bash
# Todos los tests
flutter test

# Solo integración del datasource remoto
flutter test test/data/datasource/weather_remote_datasource_test.dart

# Solo widgets de pantallas
flutter test test/presentation/pages/pages_widget_test.dart

# Por nombre
flutter test --name "WeatherPage"

# Cobertura de código
flutter test --coverage
```

### Estructura de `test/`

```text
test/
├── fixtures/
│   └── weather_fixtures.dart
├── fakes/                                 # Dobles manuales (repositorio, caché, red)
├── mocks/                                 # mocktail: Dio y NetworkInfo
│   ├── mock_dio.dart
│   └── mock_network_info.dart
├── helpers/
│   └── widget_test_helpers.dart           # Harness GetX para widgets
├── data/
│   ├── datasource/
│   │   └── weather_remote_datasource_test.dart  # Integración con Dio mock
│   ├── models/
│   └── repositories/
├── domain/usecase/
├── presentation/
│   ├── controllers/
│   └── pages/
│       └── pages_widget_test.dart         # WeatherPage + EventsPage
└── widget_test.dart
```

### Tipos de prueba

| Tipo | Archivo(s) | Descripción |
|------|------------|-------------|
| **Unitarios** | `models/`, `repositories/`, `usecase/`, `controllers/` | Lógica aislada con fakes manuales |
| **Integración** | `weather_remote_datasource_test.dart` | `WeatherRemoteDatasource` + Dio/`NetworkInfo` mockeados con **mocktail** |
| **Widgets** | `pages_widget_test.dart` | UI de `WeatherPage` y `EventsPage` con `WidgetTestHarness` |

### Tests de integración — `WeatherRemoteDatasource`

Usan **mocktail** para simular `Dio` y `NetworkInfo` sin llamadas HTTP reales:

- `getLast5Days` devuelve `WeatherModel` y verifica URL/parámetros de la API.
- `getEvents` parsea la lista de días como eventos.
- Lanza `NetworkException` sin conexión.
- Propaga `DioException` ante errores del servidor.

`WeatherRemoteDatasource` acepta un `Dio` opcional en el constructor para inyección en tests:

```dart
datasource = WeatherRemoteDatasource(
  networkInfo: mockNetworkInfo,
  dio: mockDio,
);
```

### Tests de widgets — `WeatherPage` y `EventsPage`

`WidgetTestHarness` registra un `WeatherController` con `FakeWeatherRepository` antes de montar cada pantalla:

| Pantalla | Escenarios cubiertos |
|----------|---------------------|
| **WeatherPage** | Loading, datos del clima, pronóstico, navegación a `NoInternetPage` |
| **EventsPage** | Loading, lista de eventos, estado vacío, sin internet, navegación al detalle |

Los tests de widgets que usan GetX están agrupados en un solo archivo (`pages_widget_test.dart`) para evitar conflictos con el estado global de GetX al ejecutar tests en paralelo.

### Fakes y fixtures

- **`fixtures/`** — JSON de Visual Crossing y entidades de ejemplo.
- **`fakes/`** — Sustitutos manuales de repositorio, datasources y conectividad.
- **`mocks/`** — Mocks generados con mocktail para capa HTTP.

### Agregar nuevos tests

1. Crear el archivo reflejando la capa de `lib/`.
2. Reutilizar `fixtures/`, `fakes/` y `mocks/` existentes.
3. Para pantallas con GetX, usar `WidgetTestHarness` o agrupar en el mismo archivo.
4. Ejecutar `flutter test` antes de subir cambios.

---

## 🌐 Configuración

Configura la URL base y la API Key del proveedor meteorológico:

```dart
class ApiConfig {
  static const String baseUrl = "https://api.weather.com";
 static String get baseUrl {
    if (appFlavor == Flavor.prod) {
      return "https://weather.visualcrossing.com";
    }else{
      return "https://weather.visualcrossing.com";
    }
  }
}
```

---

## 📡 Conectividad

La aplicación utiliza:

- `connectivity_plus`
- `flutter_connectivity_service`

Para detectar cambios de red y permitir una mejor experiencia offline.

---

## 💾 Persistencia Local

Se utiliza Realm para:

- Cachear respuestas de la API.
- Acceso rápido a datos recientes.
- Soporte básico offline.



// Before insert config
````agsl
flutter clean
flutter pub get
cd ios
pod install
cd ..
flutter run
````

## 📦 Build Release

### Generate Build Bundle Android With Flavors
Generate the build so you can upload it to the Play Store
More info: https://docs.flutter.dev/deployment/flavors

````agsl
flutter build appbundle --flavor development -t lib/main.dart
flutter build appbundle --flavor production -t lib/main.dart
````

### Generate Build APK Android With Flavors
````agsl
flutter build apk --flavor development -t lib/main.dart
flutter build apk --flavor production -t lib/main.dart
````

### Config Run Android

![Config Android Barra](https://github.com/valenzuela21/Wather-App-Flutter/blob/master/barra_config.png?raw=true)
![Config Android](https://github.com/valenzuela21/Wather-App-Flutter/blob/master/config_android.png?raw=true)
![Config Android Two](https://github.com/valenzuela21/Wather-App-Flutter/blob/master/config_android_two.png?raw=true)


### Config Run Xcode
Xcode already includes environment preconfiguration.

![Configuración iOS Desarrollo](https://github.com/valenzuela21/Wather-App-Flutter/blob/master/production-ios.png?raw=true)

![Configuración iOS Producción](https://github.com/valenzuela21/Wather-App-Flutter/blob/master/development-ios.png?raw=true)

### Generate Icons DEV o Prod
````agsl
flutter_launcher_icons -f flutter_launcher_icons_dev.yaml 
flutter_launcher_icons -f flutter_launcher_icons_prod.yaml  
````

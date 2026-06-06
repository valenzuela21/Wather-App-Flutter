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

# Star Wars Characters Flutter App

Una aplicación web/móvil en Flutter para explorar personajes de Star Wars, con buscador, paginación y favoritos.

## Características

- Mostrar lista de personajes desde la API
- Búsqueda por nombre en tiempo real
- Paginación y control de páginas
- Marcar/desmarcar favoritos y filtrado de favoritos
- Manejo de errores y placeholder de imagen
- Tests unitarios y de widget incluidos

## Requisitos previos

- Flutter SDK >= 3.7.2
- Dart >= 3.7.2
- Git instalado

## Clonar el repositorio

```bash
git clone https://github.com/iairbaron/star-wars-characters.git
cd myapp
```

## Instalación de dependencias

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

- `flutter pub get` instala las dependencias de Flutter.
- `build_runner` genera los mocks para pruebas (mockito).

## Ejecutar la aplicación

### Web

```bash
flutter run -d chrome
```

### Dispositivo móvil o emulador

```bash
flutter run
```

> El banner de debug está desactivado (`debugShowCheckedModeBanner: false`).

## Estructura del proyecto

```
lib/               # Código fuente de la app
  controllers/     # Lógica de estado (Riverpod)
  models/          # Clases de dominio (Character, State)
  services/        # Llamadas a API y almacenamiento local
  widgets/         # Componentes de UI reutilizables
  screens/         # Páginas principales
  main.dart        # Punto de entrada
test/              # Pruebas unitarias y de widgets
```

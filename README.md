#  MeLiTestPedroF - Challenge Técnico por Pedro Ferreira

Aplicación iOS desarrollada como prueba técnica para Mercado Libre , enfocada en el consumo de la API de Space Flight News. La app permite listar y buscar artículos sobre vuelos espaciales, ver sus detalles, y obtener la ubicación del usuario mediante Core Location.

---

##  Requisitos

- iOS 16.0+
- Xcode 16.3 
- Swift 5.9+

-La aplicación no requiere instalar pod o dependencias, se desarrolló en un entorno de herramientas nativas de Swift. 

Para clonar: 
-git clone https://github.com/lewhub474/MeLiTest.git

---

##  Tecnologías y frameworks utilizados

- **SwiftUI**: Para la construcción de la interfaz de usuario declarativa.
- **Combine**: Para manejo reactivo del estado (como el `SearchBar`).
- **CoreLocation**: Para acceder a la ubicación del usuario.
- **MVVM + UseCases + Repository Pattern**
- **Arquitectura basada en Atomic Design**: organización modular por componentes.
- **Pruebas unitarias** están desarrolladas con la nueva libreria Testing. Más información: https://developer.apple.com/documentation/testing/migratingfromxctest

---

## Estructura del proyecto

📁 Domain  
├── 📁 Entities  
│   └── 📁 Models  
│       ├── Articles  
│       └── ArticleResponse  
├── 📁 UseCases  
│   ├── UseCaseProtocol  
│   ├── FetchCityUseCase  
│   ├── FetchArticlesUseCase  
│   └── FetchArticlesUseCaseProtocol  
📁 Presentation  
├── 📁 Dashboard  
│   ├── DashboardView  
│   └── DashboardViewModel  
├── 📁 ArticleList  
│   └── ArticleListView  
├── 📁 ArticleCard  
│   ├── ArticleCardView  
│   └── ArticleCardViewModel  
├── 📁 ArticleDetail  
│   ├── ArticleDetailView  
│   └── ArticleDetailViewModel  
├── 📁 Components  
│   ├── BackgroundView  
│   ├── SearchBar  
│   ├── ImageActionButton  
│   ├── LocationPopup  
│   └── SplashScreen  
📁 Data  
├── 📁 Networking  
│   ├── NetworkingProvider  
│   ├── APIClient  
│   ├── RequestBuilder  
│   ├── HTTPMethod  
│   └── APIClientError  
└── 📁 Repositories  
    ├── 📁 LocationRepository  
    │   ├── LocationRepository  
    │   └── LocationRepositoryImpl  
    └── 📁 ArticleRepository  
        └── ArticleRepository  

Se basa en los principios propuestos por Robert C. Martin, también conocido como "Uncle Bob", autor del libro "Clean Architecture: A Craftsman's Guide to Software Structure and Design".
![CleanArc](https://github.com/user-attachments/assets/e75f896d-808e-482c-ba1b-05d961a9dfef)

---

## Funcionalidades destacadas

- **SplashScreen inicial** al abrir la app.
- **SearchBar reactiva** para filtrar artículos por texto.
- **Botón de búsqueda** adicional que permite iniciar la búsqueda manualmente.
- **Lista de artículos** con título y resumen. Cada ítem es cliqueable y navega a una vista de detalle.
- **Botón flotante** para obtener la **ciudad actual del usuario**, solicitando permisos de ubicación.
- Consumo de la [Space Flight News API](https://api.spaceflightnewsapi.net/).

---

##  Arquitectura

El proyecto sigue una arquitectura limpia basada en:

- **MVVM** (Model - View - ViewModel)
- **Use Cases** para encapsular lógica de negocio
- **Repositories** para desacoplar la lógica de los orígenes de datos
- **APIClient abstraído** para manejar peticiones HTTP

Además, se organiza siguiendo el principio de **Componentes reutilizables** como `ImageActionButton` y `BackgroundView`.

---

##  Permisos requeridos

Para obtener la ubicación del usuario, la app solicita permiso de localización:

- `NSLocationWhenInUseUsageDescription` en el `Info.plist`

Este permiso solo se solicita **cuando el usuario pulsa el botón de localización**, no al iniciar la app.

---

## Tests

Incluye pruebas unitarias básicas para `DashboardViewModel` y mocks de casos de uso como `MockFetchArticlesUseCase`.

---

## Autor

Pedro Ferreira Agamez  
[LinkedIn](https://www.linkedin.com/in/pedroferreiraagamez)


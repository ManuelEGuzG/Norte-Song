# Norte Songs 
### Cancionero Digital — Iglesia del Norte

Aplicación web multimedia desarrollada con **Vue 3** para la gestión y presentación del repertorio musical de la Iglesia del Norte.

---

##  Instrucciones de ejecución

### Requisitos
- Node.js 18 o superior
- npm 9 o superior

### Instalación y ejecución

```bash
# Clonar el repositorio
git clone https://github.com/TU_USUARIO/norte-songs.git
cd norte-songs

# Instalar dependencias
npm install

# Iniciar servidor de desarrollo
npm run dev

# Para acceder desde la red local
npm run dev -- --host
```

La aplicación estará disponible en `http://localhost:5173`

---

##  Framework utilizado

**Vue 3** con Composition API  
Versión: 3.x | Herramienta de construcción: **Vite**

---

##  Estructura del proyecto

```
norte-songs/
├── public/
│   ├── canciones.json        # Datos de las 16 canciones
│   └── audio/                # Clips de audio descriptivo
├── src/
│   ├── assets/
│   │   └── logo/             # Logo de Iglesia del Norte
│   ├── components/
│   │   ├── EncabezadoApp.vue     # Navbar con toggle modo oscuro
│   │   ├── TarjetaCancion.vue    # Card de canción con imagen
│   │   ├── MostrarAcordes.vue    # Visualizador de letra y acordes
│   │   ├── BuscadorFiltro.vue    # Búsqueda y filtros
│   │   ├── ReproductorYouTube.vue # Reproductor embebido
│   │   ├── AudioPlayer.vue        # Reproductor de audio propio
│   │   └── AcordeGuitarraSVG.vue  # Diagrama SVG de acordes
│   ├── views/
│   │   ├── VistaInicio.vue       # Página de inicio con partículas
│   │   ├── VistaCanciones.vue    # Lista con búsqueda y filtros
│   │   ├── VistaDetalleCancion.vue # Detalle con letra y acordes
│   │   ├── VistaPresentacion.vue  # Modo presentación pantalla completa
│   │   └── VistaAcordes.vue      # Enciclopedia de acordes guitarra
│   ├── router/
│   │   └── index.js             # Rutas de la aplicación
│   ├── style.css                # Estilos globales + modo oscuro
│   └── main.js
└── package.json
```

---

##  Funcionalidades principales

-  **Cancionero** — 16 canciones con letra, acordes y video YouTube
-  **Modo Presentación** — Pantalla completa con control de tamaño de texto
-  **Búsqueda en tiempo real** — Filtro por título, artista y género
-  **Enciclopedia de acordes** — Diagramas SVG de guitarra para los 12 tonos
-  **Modo oscuro/claro** — Toggle con preferencia guardada en localStorage
-  **Reproductor de audio** — Integrado en el detalle de cada canción
-  **Responsivo** — Funciona en escritorio y móvil

---

##  Capturas de pantalla

![Inicio](screenshots/inicio.png)
![Canciones](screenshots/canciones.png)
![Detalle](screenshots/detalle.png)
![Presentación](screenshots/presentacion.png)
![Acordes](screenshots/acordes.png)

---

##  Conceptos de Vue 3 aplicados

| Concepto | Dónde se usa |
|---|---|
| `ref()` y `reactive()` | Estado de búsqueda, índice de presentación, modo oscuro |
| `computed()` | Filtrado en tiempo real de canciones |
| `onMounted()` / `onUnmounted()` | Carga de JSON, listeners de teclado |
| `v-for` | Renderizado de canciones, acordes, secciones de letra |
| `v-if` / `v-else` | Mostrar/ocultar acordes, secciones especiales |
| `defineProps` | Paso de datos entre componentes |
| `vue-router` | Navegación entre vistas |
| `fetch()` | Carga dinámica de `canciones.json` |
| CSS Variables | Sistema de temas claro/oscuro |

---

##  Autor

**Brax** — Proyecto Personal IF7102 Multimedios  
Universidad de Costa Rica | I Ciclo 2026  
Opción elegida: **Opción 4 — Enciclopedia Temática Interactiva**
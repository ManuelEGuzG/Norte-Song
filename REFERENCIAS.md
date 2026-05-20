# REFERENCIAS.md
## Norte Songs — IF7102 Multimedios | I Ciclo 2026
### Aplicación Web Multimedia con Vue 3

---

##  Tutoriales y videos consultados

- **"Vue 3 Crash Course 2024" — Traversy Media (YouTube)**
  https://www.youtube.com/watch?v=YrxBCBibVo0
  Para aprender la estructura básica de Composition API, `ref`, `computed` y componentes.

- **"Vue 3 Tutorial for Beginners" — The Net Ninja (YouTube Playlist)**
  https://www.youtube.com/playlist?list=PL4cUxeGkcC9hYYGbV60Vq3IXYNfDk8At1
  Serie completa: desde Options API hasta Composition API, props, eventos, vue-router.

- **"Vue 3 Full Course for Beginners" — freeCodeCamp (YouTube)**
  https://www.youtube.com/watch?v=VeNfHj6MhgA
  Para estructura de proyectos reales con Vite y organización de componentes.

- **"Vue Router 4 Tutorial" — Laith Academy (YouTube)**
  https://www.youtube.com/watch?v=GD9X1lNHtu4
  Para configurar navegación entre vistas y rutas dinámicas.

- **"Build a Music App with Vue 3" — Program With Erik (YouTube)**
  https://www.youtube.com/watch?v=LW6d6n8g7W4
  Referencia para el manejo de audio con `ref` y control del DOM en Vue 3.

---

##  Acordes de Guitarra

- **"Acordes para Guitarra" — Guía de 120 posiciones (PDF)**
  Recurso físico consultado para verificar las posiciones de los acordes principales.
  Convención usada: cuerdas de izquierda a derecha (E grave → e aguda), trastes de arriba abajo.

- **"Libro de Acordes para Guitarra" — MiGuitarraEléctrica**
  https://miguitarraelectrica.com/acordes-guitarra/
  Consultado para acordes mayores, menores, séptimas, Maj7, cejillas y sistema CAGED.

- **Sistema CAGED — Justin Guitar**
  https://www.justinguitar.com/guitar-lessons/caged-system
  Consultado para entender la lógica de acordes móviles en toda la escala del diapasón.

- **"Guitar Chord Theory" — MusicTheory.net**
  https://www.musictheory.net/lessons/40
  Consultado para verificar las notas que forman cada acorde (tríadas, séptimas).

---

##  Recursos de Diseño y Tipografía

- **Google Fonts — Playfair Display**
  https://fonts.google.com/specimen/Playfair+Display
  Licencia: SIL Open Font License (OFL). Usada para títulos y encabezados.

- **Google Fonts — Cormorant Garamond**
  https://fonts.google.com/specimen/Cormorant+Garamond
  Licencia: SIL Open Font License (OFL). Usada para el cuerpo de texto y letra de canciones.

- **Google Fonts — JetBrains Mono**
  https://fonts.google.com/specimen/JetBrains+Mono
  Licencia: SIL Open Font License (OFL). Usada para acordes y texto monoespaciado.

- **CSS Animation Tricks — Kevin Powell (YouTube)**
  https://www.youtube.com/kepowob
  Referencia para animaciones `fadeInUp`, partículas en canvas y transiciones suaves.

- **Canvas API — HTML5 Canvas Tutorial**
  https://developer.mozilla.org/en-US/docs/Web/API/Canvas_API/Tutorial
  Consultado para implementar las partículas doradas animadas en la pantalla de inicio.

---

##  Recursos Multimedia

### Imágenes de portada
Las imágenes de portada de cada canción son las miniaturas oficiales de YouTube,
cargadas desde el servidor de Google:

Estas corresponden a los videos musicales oficiales de cada artista publicados en YouTube.
Los videos son de los artistas: Danilo Montero, Majo y Dan, Marcos Witt, Hillsong UNITED,
Evan Craft, En Espíritu Y En Verdad, Julio Melgar, Generación 12, Ingrid Rosario,
Cristine D'Clario, Bethel Music, Peregrinos y Extranjeros, Proposito Music.

### Videos embebidos
Los videos se reproducen directamente desde YouTube mediante `<iframe>`.
No se almacenan localmente. Son videos oficiales de cada artista.

| # | Canción | Artista | URL |
|---|---|---|---|
| 1 | Bendito Jesús | Danilo Montero | https://youtu.be/N_obYr-RPJA |
| 2 | Fiel | Majo y Dan | https://youtu.be/w66bfbeKny0 |
| 3 | Tu mirada | Marcos Witt | https://youtu.be/YNou3YGzP_M |
| 4 | Desde Mi Interior | Hillsong UNITED | https://youtu.be/pORjEfnPALk |
| 5 | Oceanos | Evan Craft | https://youtu.be/rbHIRvfNxBA |
| 6 | Gracia Sublime Es | En Espíritu Y En Verdad | https://youtu.be/0pOVNIsyIXM |
| 7 | Creo En Ti | Julio Melgar | https://youtu.be/xJ_ZZkM5fGY |
| 8 | Tu Amor No Tiene Fin | Generación 12 | https://youtu.be/-fz292HNU_w |
| 9 | Cuán Grande Es Dios | En Espíritu Y En Verdad | https://youtu.be/yhSQZHZZy08 |
| 10 | Abre Mis Ojos Oh Cristo | Danilo Montero | https://youtu.be/sAm49exVyZc |
| 11 | Cante Al Señor | Ingrid Rosario | https://youtu.be/kIsrX9_ld64 |
| 12 | Admirable | Cristine D'Clario | https://youtu.be/vQiBdYP1TmI |
| 13 | Alaba | Evan Craft ft. Intimidad Worship | https://youtu.be/naG_gVo8buc |
| 14 | Bondad de Dios | Bethel Music | https://youtu.be/SnIzImY9wO4 |
| 15 | Mi Confianza Eres Tu | Peregrinos y Extranjeros | https://youtu.be/IdAVbVAgDgE |
| 16 | En la Cruz | Proposito Music | https://youtu.be/QmuHMNGMTVw |

### Logo Iglesia del Norte
Imagen del árbol con raíces — propiedad de Iglesia del Norte.
Formato: PNG. Integrado en `src/assets/logo/logo-iglesia.png`.


##  Uso de Inteligencia Artificial

Durante el desarrollo del proyecto se utilizó **Claude (Anthropic)** como asistente:

- **Herramienta:** Claude Sonnet — claude.ai
- **Uso:** Asistencia en la escritura de componentes Vue 3, resolución de errores de CSS,
  generación de datos del `canciones.json`, diseño del sistema de presentación,
  implementación de diagramas SVG de acordes, y estructura general del proyecto.
- **Comprensión del código:** Todo el código fue revisado y comprendido por el estudiante.
  Se aprendió la lógica de `ref`, `computed`, ciclo de vida, `vue-router`, CSS variables,
  el sistema CAGED de acordes, y la API de audio/video del navegador.
- **Declaración de transparencia:** El uso de IA fue una herramienta de apoyo al aprendizaje,
  no un sustituto del mismo. El estudiante puede explicar cualquier parte del código.

---

##  Dependencias del proyecto

| Paquete | Versión | Uso |
|---|---|---|
| `vue` | ^3.x | Framework principal |
| `vue-router` | ^4.x | Navegación entre vistas |
| `vite` | ^5.x | Herramienta de build y dev server |
| `@vitejs/plugin-vue` | ^5.x | Plugin de Vue para Vite |

---

*IF7102 Multimedios — Universidad de Costa Rica — Sede Regional de Guanacaste — I Ciclo 2026*
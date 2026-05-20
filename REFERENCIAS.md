# REFERENCIAS.md
## Norte Songs — IF7102 Multimedios | I Ciclo 2026

---

##  Framework — Vue 3

### Documentación oficial
- **Vue 3 Official Docs** — https://vuejs.org/guide/introduction.html  
  Consulté principalmente: Composition API, `ref`, `computed`, ciclo de vida (`onMounted`, `onUnmounted`), `defineProps`, `v-for`, `v-if`, `v-model`.

- **Vue Router 4 Docs** — https://router.vuejs.org/guide/  
  Para configuración de rutas, `useRoute()`, parámetros dinámicos (`:id`).

- **Vite Docs** — https://vitejs.dev/guide/  
  Para configuración del proyecto, alias `@`, y comando de build.

### Tutoriales y videos
- **"Vue 3 Crash Course" — Traversy Media (YouTube)**  
  https://www.youtube.com/watch?v=YrxBCBibVo0  
  Intro a Composition API, estructura de componentes, `ref` y `computed`.

- **"Vue 3 Tutorial for Beginners" — Net Ninja (YouTube playlist)**  
  https://www.youtube.com/playlist?list=PL4cUxeGkcC9hYYGbV60Vq3IXYNfDk8At1  
  Series completa: Options API → Composition API, props, eventos, router.

- **"Vue 3 + Vite Full Course" — freeCodeCamp (YouTube)**  
  https://www.youtube.com/watch?v=VeNfHj6MhgA  
  Estructura de proyecto real, organización de componentes.

- **"Build a Music App with Vue 3" — Vue Mastery**  
  https://www.vuemastery.com/courses/  
  Referencia para reproductor de audio con `ref` y control del DOM.

---

##  Diseño y CSS

- **MDN Web Docs — CSS Custom Properties (Variables)**  
  https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties  
  Para el sistema de temas claro/oscuro con `data-theme`.

- **MDN Web Docs — CSS Grid Layout**  
  https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_grid_layout  
  Para la grilla de canciones y la enciclopedia de acordes.

- **Google Fonts — Playfair Display + Cormorant Garamond + JetBrains Mono**  
  https://fonts.google.com/  
  Licencia: SIL Open Font License (OFL) — libre para uso web.

---

##  Acordes de Guitarra

- **"Acordes para Guitarra" (PDF)**  
  Guía de 120 posiciones de acordes. Consultado para verificar posiciones del sistema CAGED.

- **"Libro de Acordes para Guitarra" — MiGuitarraEléctrica (PDF)**  
  https://miguitarraelectrica.com  
  Referencia para acordes mayores, menores, séptimas y cejillas.

- **Sistema CAGED explicado — Justin Guitar**  
  https://www.justinguitar.com/guitar-lessons/caged-system  
  Para entender la lógica de acordes con barre en toda la escala.

---

##  Recursos Multimedia

### Imágenes de portada
Las imágenes de portada de cada canción provienen de las miniaturas de YouTube:  
`https://img.youtube.com/vi/{VIDEO_ID}/hqdefault.jpg`  
Estas son thumbnails de los videos musicales oficiales de cada artista.

### Videos
Los videos son embebidos directamente desde YouTube mediante iframe.  
No se almacenan localmente — se reproducen desde la plataforma oficial.

### Logo
Logo del árbol — producción propia de Iglesia del Norte.

### Audio descriptivo
Los clips de audio en `/public/audio/` son grabaciones propias  
producidas específicamente para este proyecto.  
Formato: MP3, grabados con [indicar herramienta usada].

---

##  Uso de Inteligencia Artificial

Durante el desarrollo de este proyecto se utilizó **Claude (Anthropic)** como herramienta de asistencia:

- **Qué se usó:** Claude Sonnet (claude.ai)
- **Para qué:** Asistencia en la escritura de componentes Vue 3, resolución de errores de CSS, generación de los datos del JSON de canciones, diseño del layout de presentación y diagrama SVG de acordes.
- **Comprensión del código:** Todo el código generado fue revisado, modificado y comprendido por el estudiante. Durante el proceso se aprendió la lógica de cada parte: `computed`, `ref`, ciclo de vida, `vue-router`, CSS variables, y el sistema CAGED para los acordes.
- **Declaración:** El uso de IA fue una herramienta de apoyo al aprendizaje, no un sustituto del mismo.

---

##  Dependencias del proyecto

```json
{
  "vue": "^3.x",
  "vue-router": "^4.x",
  "vite": "^5.x"
}
```

---

*IF7102 Multimedios — Universidad de Costa Rica — I Ciclo 2026*
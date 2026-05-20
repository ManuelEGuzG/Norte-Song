import { createRouter, createWebHistory } from 'vue-router'
import VistaInicio from '../views/VistaInicio.vue'
import VistaCanciones from '../views/VistaCanciones.vue'
import VistaDetalleCancion from '../views/VistaDetalleCancion.vue'
import VistaPresentacion from '../views/VistaPresentacion.vue'
import VistaAcordes from '../views/VistaAcordes.vue'

const rutas = [
  { path: '/', component: VistaInicio },
  { path: '/canciones', component: VistaCanciones },
  { path: '/cancion/:id', component: VistaDetalleCancion },
  { path: '/presentacion/:id', component: VistaPresentacion },
  { path: '/acordes', component: VistaAcordes }
]

export default createRouter({
  history: createWebHistory(),
  routes: rutas
})
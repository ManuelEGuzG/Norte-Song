<template>
  <div class="vista-canciones">
    <div class="pagina-header fade-in">
      <p class="header-supra">Repertorio</p>
      <h2 class="header-titulo">Canciones</h2>
      <p class="header-contador">
        <span class="contador-num">{{ filtradas.length }}</span>
        canción{{ filtradas.length !== 1 ? 'es' : '' }}
      </p>
    </div>

    <div class="contenido fade-in-2">
      <BuscadorFiltro v-model:search="busqueda" v-model:genre="genero" :genres="generos" />

      <!-- Skeleton loader mientras carga -->
      <div v-if="cargando" class="grilla-canciones">
        <SkeletonCard v-for="n in 6" :key="n" />
      </div>

      <!-- Resultados -->
      <div v-else-if="filtradas.length" class="grilla-canciones">
        <TarjetaCancion
          v-for="(cancion, i) in filtradas"
          :key="cancion.id"
          :cancion="cancion"
          :style="{ animationDelay: `${i * 0.06}s` }"
        />
      </div>

      <!-- Sin resultados -->
      <div v-else class="sin-resultados">
        <div class="sin-icono">♩</div>
        <p class="sin-titulo">Sin resultados</p>
        <p class="sin-sub">Intentá con otra búsqueda o filtro</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import BuscadorFiltro from '../components/BuscadorFiltro.vue'
import TarjetaCancion from '../components/TarjetaCancion.vue'
import SkeletonCard   from '../components/SkeletonCard.vue'

const canciones = ref([])
const busqueda  = ref('')
const genero    = ref('')
const cargando  = ref(true)

onMounted(async () => {
  const res = await fetch(import.meta.env.BASE_URL + 'canciones.json')
  canciones.value = await res.json()
  cargando.value = false
})

const generos   = computed(() => [...new Set(canciones.value.map(c => c.genero))].sort())
const filtradas = computed(() => canciones.value.filter(c => {
  const ok1 = !busqueda.value || c.titulo.toLowerCase().includes(busqueda.value.toLowerCase()) || c.artista.toLowerCase().includes(busqueda.value.toLowerCase())
  const ok2 = !genero.value  || c.genero === genero.value
  return ok1 && ok2
}))
</script>

<style scoped>
.vista-canciones { max-width: 1200px; margin: 0 auto; padding: 0 24px 80px; }
.pagina-header { padding: 110px 0 48px; }
.header-supra { font-family: var(--font-display); font-size: 0.6rem; letter-spacing: 0.45em; text-transform: uppercase; color: var(--text-muted); margin-bottom: 10px; }
.header-titulo { font-family: var(--font-display); font-size: clamp(2.4rem, 6vw, 3.8rem); font-weight: 700; color: var(--text-primary); letter-spacing: -0.01em; line-height: 1; margin-bottom: 10px; }
.header-contador { font-size: 1rem; color: var(--text-muted); font-style: italic; }
.contador-num { color: var(--gold-primary); font-weight: 600; margin-right: 5px; }
.contenido { display: flex; flex-direction: column; gap: 32px; }
.grilla-canciones { display: grid; grid-template-columns: repeat(auto-fill, minmax(290px, 1fr)); gap: 16px; }
.sin-resultados { text-align: center; padding: 80px 24px; }
.sin-icono { font-size: 3rem; color: var(--text-faint); margin-bottom: 16px; }
.sin-titulo { font-family: var(--font-display); font-size: 1.2rem; color: var(--text-secondary); margin-bottom: 8px; }
.sin-sub { font-size: 0.95rem; color: var(--text-muted); font-style: italic; }
@media (max-width: 600px) { .grilla-canciones { grid-template-columns: 1fr; } }
</style>
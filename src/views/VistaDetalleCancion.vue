<template>
  <div class="detalle" v-if="cancion">
    <div class="detalle-header">
      <div class="detalle-header-inner">
        <router-link to="/canciones" class="btn-volver fade-in">← Volver</router-link>
        <div class="cancion-info fade-in-2">
          <div class="badges">
            <span class="badge-genero">{{ cancion.genero }}</span>
            <span class="badge-tono">{{ cancion.tono }}</span>
          </div>
          <h1 class="cancion-titulo">{{ cancion.titulo }}</h1>
          <p class="cancion-artista">{{ cancion.artista }}</p>
        </div>
        <div class="acciones fade-in-3">
          <router-link :to="`/presentacion/${cancion.id}`" class="btn-accion btn-presentacion">
            ⛶ Presentación
          </router-link>
        </div>
      </div>
    </div>

    <div class="detalle-cuerpo">
      <!-- Columna principal: letra -->
      <div class="col-letra fade-in-2">
        <MostrarAcordes :cancion="cancion" />
        <!-- Canciones relacionadas al final de la letra -->
        <CancionesRelacionadas
          v-if="todasCanciones.length"
          :cancion-actual="cancion"
          :todas="todasCanciones"
        />
      </div>

      <!-- Columna lateral: video + audio + metrónomo -->
      <div class="col-lateral fade-in-3">
        <ReproductorYouTube :video-id="cancion.youtubeId" />
        <AudioPlayer
          v-if="cancion.audio"
          :src="cancion.audio"
          :titulo="cancion.titulo"
          subtitulo="Descripción de la canción"
        />
        <Metronomo />
      </div>
    </div>
  </div>

  <!-- Skeleton mientras carga -->
  <div v-else class="cargando">
    <div class="cargando-icono">♪</div>
    <p>Cargando canción...</p>
  </div>
</template>

<script setup>
import { ref, watch, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import MostrarAcordes        from '../components/MostrarAcordes.vue'
import ReproductorYouTube    from '../components/ReproductorYouTube.vue'
import AudioPlayer           from '../components/AudioPlayer.vue'
import Metronomo             from '../components/Metronomo.vue'
import CancionesRelacionadas from '../components/CancionesRelacionadas.vue'

const route          = useRoute()
const cancion        = ref(null)
const todasCanciones = ref([])

async function cargarCancion(id) {
  cancion.value = null
  if (!todasCanciones.value.length) {
    const res = await fetch('/canciones.json')
    todasCanciones.value = await res.json()
  }
  cancion.value = todasCanciones.value.find(c => c.id === parseInt(id))
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

onMounted(() => cargarCancion(route.params.id))

// Recargar cuando cambia el ID en la URL
watch(() => route.params.id, (nuevoId) => {
  if (nuevoId) cargarCancion(nuevoId)
})
</script>

<style scoped>
.detalle { min-height: 100vh; background: #ffffff; }

.detalle-header {
  background: linear-gradient(180deg, #f8f5ef 0%, #ffffff 100%);
  border-bottom: 1px solid var(--border-faint); padding: 110px 24px 44px;
}
.detalle-header-inner { max-width: 1100px; margin: 0 auto; display: flex; flex-direction: column; gap: 24px; }

.btn-volver {
  font-family: var(--font-display); font-size: 0.62rem; letter-spacing: 0.25em;
  text-transform: uppercase; color: var(--text-muted); transition: var(--transition); width: fit-content;
}
.btn-volver:hover { color: var(--gold-dark); }

.badges { display: flex; gap: 8px; margin-bottom: 12px; }
.badge-genero {
  font-family: var(--font-display); font-size: 0.58rem; letter-spacing: 0.18em;
  text-transform: uppercase; color: var(--gold-dark);
  background: rgba(184,134,42,0.1); border: 1px solid rgba(184,134,42,0.25);
  padding: 4px 12px; border-radius: 20px;
}
.badge-tono {
  font-family: var(--font-mono); font-size: 0.68rem; color: var(--text-muted);
  background: var(--bg-elevated); border: 1px solid var(--border-faint);
  padding: 4px 12px; border-radius: 20px;
}
.cancion-titulo {
  font-family: var(--font-display); font-size: clamp(2rem, 5vw, 3rem);
  font-weight: 700; color: var(--text-primary); letter-spacing: -0.01em; margin-bottom: 8px; line-height: 1.1;
}
.cancion-artista { font-size: 1.1rem; color: var(--text-secondary); font-style: italic; }

.acciones { display: flex; flex-wrap: wrap; gap: 10px; }
.btn-accion {
  font-family: var(--font-display); font-size: 0.62rem; letter-spacing: 0.18em;
  text-transform: uppercase; color: var(--text-muted);
  background: var(--bg-card); border: 1px solid var(--border-card);
  padding: 10px 18px; border-radius: var(--radius-sm); transition: var(--transition);
  display: inline-flex; align-items: center; gap: 7px;
  box-shadow: 0 1px 4px rgba(90,64,32,0.06);
}
.btn-presentacion {
  background: linear-gradient(135deg, var(--gold-dark), var(--gold-primary)) !important;
  color: #faf7f2 !important; border-color: transparent !important; font-weight: 700;
  box-shadow: 0 4px 16px rgba(184,134,42,0.3) !important;
}
.btn-presentacion:hover { transform: translateY(-2px); box-shadow: 0 8px 28px rgba(184,134,42,0.4) !important; }

.detalle-cuerpo {
  max-width: 1100px; margin: 0 auto; padding: 48px 24px 100px;
  display: grid; grid-template-columns: 1fr 340px; gap: 48px; align-items: start;
}
.col-lateral { position: sticky; top: 100px; display: flex; flex-direction: column; gap: 0; }

.cargando {
  display: flex; flex-direction: column; align-items: center; justify-content: center;
  min-height: 60vh; gap: 16px; color: var(--text-muted);
}
.cargando-icono { font-size: 3rem; color: var(--gold-pale); }

@media (max-width: 900px) {
  .detalle-cuerpo { grid-template-columns: 1fr; }
  .col-lateral { position: static; }
}
</style>
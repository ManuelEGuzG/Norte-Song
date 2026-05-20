<template>
  <div class="audio-player" v-if="src">
    <div class="audio-info">
      <span class="audio-icono">🎵</span>
      <div class="audio-texto">
        <span class="audio-titulo">{{ titulo || 'Audio descriptivo' }}</span>
        <span class="audio-subtitulo">{{ subtitulo || 'Narración' }}</span>
      </div>
    </div>

    <div class="audio-controles">
      <button class="btn-play" @click="togglePlay">
        {{ reproduciendo ? '⏸' : '▶' }}
      </button>

      <div class="progreso-wrap" @click="saltar">
        <div class="progreso-barra">
          <div class="progreso-fill" :style="{ width: porcentaje + '%' }"></div>
        </div>
        <div class="progreso-tiempos">
          <span>{{ formatTiempo(tiempoActual) }}</span>
          <span>{{ formatTiempo(duracion) }}</span>
        </div>
      </div>

      <div class="volumen-wrap">
        <span class="vol-icono">{{ volumen === 0 ? '🔇' : '🔊' }}</span>
        <input
          type="range" min="0" max="1" step="0.05"
          :value="volumen" @input="cambiarVolumen"
          class="vol-slider"
        />
      </div>
    </div>

    <audio
      ref="audioEl"
      :src="src"
      @timeupdate="alActualizar"
      @loadedmetadata="alCargar"
      @ended="reproduciendo = false"
    />
  </div>
</template>

<script setup>
import { ref, onUnmounted } from 'vue'

const props = defineProps({
  src:       { type: String, default: null },
  titulo:    { type: String, default: '' },
  subtitulo: { type: String, default: '' },
})

const audioEl      = ref(null)
const reproduciendo = ref(false)
const tiempoActual  = ref(0)
const duracion      = ref(0)
const volumen       = ref(0.8)
const porcentaje    = ref(0)

function togglePlay() {
  if (!audioEl.value) return
  if (reproduciendo.value) {
    audioEl.value.pause()
  } else {
    audioEl.value.play()
  }
  reproduciendo.value = !reproduciendo.value
}

function alActualizar() {
  if (!audioEl.value) return
  tiempoActual.value = audioEl.value.currentTime
  porcentaje.value   = duracion.value ? (tiempoActual.value / duracion.value) * 100 : 0
}

function alCargar() {
  if (!audioEl.value) return
  duracion.value = audioEl.value.duration
  audioEl.value.volume = volumen.value
}

function saltar(e) {
  if (!audioEl.value || !duracion.value) return
  const rect = e.currentTarget.getBoundingClientRect()
  const ratio = (e.clientX - rect.left) / rect.width
  audioEl.value.currentTime = ratio * duracion.value
}

function cambiarVolumen(e) {
  volumen.value = parseFloat(e.target.value)
  if (audioEl.value) audioEl.value.volume = volumen.value
}

function formatTiempo(seg) {
  if (!seg || isNaN(seg)) return '0:00'
  const m = Math.floor(seg / 60)
  const s = Math.floor(seg % 60).toString().padStart(2, '0')
  return `${m}:${s}`
}

onUnmounted(() => { if (audioEl.value) audioEl.value.pause() })
</script>

<style scoped>
.audio-player {
  background: var(--bg-card);
  border: 1px solid var(--border-card);
  border-radius: var(--radius-md);
  padding: 16px 18px;
  display: flex; flex-direction: column; gap: 12px;
  box-shadow: var(--shadow-card);
  margin-top: 16px;
}

.audio-info { display: flex; align-items: center; gap: 12px; }
.audio-icono { font-size: 1.4rem; }
.audio-texto { display: flex; flex-direction: column; gap: 2px; }
.audio-titulo {
  font-family: var(--font-display); font-size: 0.85rem; font-weight: 600;
  color: var(--text-primary);
}
.audio-subtitulo {
  font-family: var(--font-display); font-size: 0.6rem; letter-spacing: 0.15em;
  text-transform: uppercase; color: var(--text-muted);
}

.audio-controles { display: flex; align-items: center; gap: 12px; }

.btn-play {
  width: 38px; height: 38px; border-radius: 50%; flex-shrink: 0;
  background: linear-gradient(135deg, var(--gold-dark), var(--gold-primary));
  color: #fff; font-size: 0.9rem; display: flex; align-items: center; justify-content: center;
  border: none; cursor: pointer; transition: var(--transition);
  box-shadow: 0 3px 10px rgba(184,134,42,0.35);
}
.btn-play:hover { transform: scale(1.08); box-shadow: 0 5px 16px rgba(184,134,42,0.5); }

.progreso-wrap { flex: 1; cursor: pointer; }
.progreso-barra {
  height: 4px; background: var(--border-faint); border-radius: 2px; overflow: hidden; margin-bottom: 4px;
}
.progreso-fill { height: 100%; background: var(--gold-primary); border-radius: 2px; transition: width 0.1s linear; }
.progreso-tiempos { display: flex; justify-content: space-between; font-family: var(--font-mono); font-size: 0.58rem; color: var(--text-muted); }

.volumen-wrap { display: flex; align-items: center; gap: 6px; flex-shrink: 0; }
.vol-icono { font-size: 0.9rem; }
.vol-slider {
  width: 60px; height: 4px; accent-color: var(--gold-primary); cursor: pointer;
}
</style>
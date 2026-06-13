<template>
  <div class="metronomo">
    <div class="metro-header">
      <span class="metro-icono"></span>
      <div>
        <span class="metro-titulo">Metrónomo</span>
        <span class="metro-sub">Web Audio API</span>
      </div>
    </div>

    <!-- BPM display --> 
    <div class="bpm-display">
      <div class="bpm-num" :class="{ pulso: pulsando }">{{ bpm }}</div>
      <div class="bpm-label">BPM</div>
    </div>

    <!-- Pendulo visual -->
    <div class="pendulo-wrap">
      <div class="pendulo-track">
        <div class="pendulo-bola" :class="{ izq: lado === 0, der: lado === 1 }"></div>
      </div>
      <div class="pendulo-marcas">
        <span
          v-for="(m, i) in marcasBpm"
          :key="i"
          class="pendulo-marca"
          :class="{ activa: bpm === m }"
          @click="bpm = m"
        >{{ m }}</span>
      </div>
    </div>

    <!-- Slider BPM -->
    <div class="bpm-control">
      <button class="btn-bpm" @click="bpm = Math.max(40, bpm - 1)">−</button>
      <input
        type="range" min="40" max="220" :value="bpm"
        @input="bpm = parseInt($event.target.value)"
        class="bpm-slider"
      />
      <button class="btn-bpm" @click="bpm = Math.min(220, bpm + 1)">+</button>
    </div>

    <!-- Tempo labels -->
    <div class="tempo-label">{{ tempoNombre }}</div>

    <!-- Botón play/stop -->
    <button class="btn-play-metro" @click="toggleMetronomo" :class="{ activo: corriendo }">
      {{ corriendo ? '⏹ Detener' : '▶ Iniciar' }}
    </button>
  </div>
</template>

<script setup>
import { ref, computed, watch, onUnmounted } from 'vue'

const bpm       = ref(80)
const corriendo = ref(false)
const lado      = ref(0)
const pulsando  = ref(false)

const marcasBpm = [60, 80, 100, 120, 140, 160]

// Nombres de tempo estándar
const tempoNombre = computed(() => {
  const b = bpm.value
  if (b < 60)  return 'Largo'
  if (b < 66)  return 'Larghetto'
  if (b < 76)  return 'Adagio'
  if (b < 108) return 'Andante'
  if (b < 120) return 'Moderato'
  if (b < 156) return 'Allegro'
  if (b < 176) return 'Vivace'
  return 'Presto'
})

// Web Audio API
let audioCtx = null
let intervalo = null

function getAudioCtx() {
  if (!audioCtx) audioCtx = new (window.AudioContext || window.webkitAudioContext)()
  return audioCtx
}

function tocarClick(acento = false) {
  const ctx = getAudioCtx()
  const osc = ctx.createOscillator()
  const gain = ctx.createGain()

  osc.connect(gain)
  gain.connect(ctx.destination)

  osc.frequency.value = acento ? 1000 : 800
  gain.gain.setValueAtTime(acento ? 0.6 : 0.35, ctx.currentTime)
  gain.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + 0.08)

  osc.start(ctx.currentTime)
  osc.stop(ctx.currentTime + 0.08)

  // Animación visual
  lado.value = lado.value === 0 ? 1 : 0
  pulsando.value = true
  setTimeout(() => { pulsando.value = false }, 100)
}

let beat = 0

function iniciar() {
  beat = 0
  const ms = (60 / bpm.value) * 1000
  tocarClick(true)
  intervalo = setInterval(() => {
    beat = (beat + 1) % 4
    tocarClick(beat === 0)
  }, ms)
}

function detener() {
  clearInterval(intervalo)
  intervalo = null
  beat = 0
  lado.value = 0
}

function toggleMetronomo() {
  if (corriendo.value) {
    detener()
  } else {
    iniciar()
  }
  corriendo.value = !corriendo.value
}

// Si cambia el BPM mientras corre, reiniciar
watch(bpm, () => {
  if (corriendo.value) {
    detener()
    iniciar()
  }
})

onUnmounted(() => {
  detener()
  if (audioCtx) audioCtx.close()
})
</script>

<style scoped>
.metronomo {
  background: var(--bg-card);
  border: 1px solid var(--border-card);
  border-radius: var(--radius-md);
  padding: 20px;
  display: flex; flex-direction: column; gap: 14px;
  box-shadow: var(--shadow-card);
  margin-top: 16px;
}

.metro-header {
  display: flex; align-items: center; gap: 10px;
}
.metro-icono { font-size: 1.3rem; }
.metro-titulo {
  display: block; font-family: var(--font-display); font-size: 0.85rem;
  font-weight: 600; color: var(--text-primary);
}
.metro-sub {
  display: block; font-family: var(--font-display); font-size: 0.55rem;
  letter-spacing: 0.15em; text-transform: uppercase; color: var(--text-muted);
}

/* BPM display */
.bpm-display {
  display: flex; align-items: baseline; gap: 6px; justify-content: center;
  padding: 10px 0;
}
.bpm-num {
  font-family: var(--font-display); font-size: 3.5rem; font-weight: 900;
  color: var(--gold-primary); line-height: 1; transition: transform 0.08s ease;
}
.bpm-num.pulso { transform: scale(1.12); }
.bpm-label {
  font-family: var(--font-display); font-size: 0.7rem; letter-spacing: 0.3em;
  text-transform: uppercase; color: var(--text-muted);
}

/* Péndulo visual */
.pendulo-wrap { display: flex; flex-direction: column; gap: 8px; }
.pendulo-track {
  height: 24px; background: var(--bg-secondary);
  border-radius: 12px; position: relative; overflow: hidden;
  border: 1px solid var(--border-faint);
}
.pendulo-bola {
  position: absolute; top: 4px;
  width: 16px; height: 16px; border-radius: 50%;
  background: linear-gradient(135deg, var(--gold-dark), var(--gold-primary));
  box-shadow: 0 2px 8px rgba(184,134,42,0.4);
  transition: left 0.15s ease;
}
.pendulo-bola.izq { left: 6px; }
.pendulo-bola.der { left: calc(100% - 22px); }

.pendulo-marcas { display: flex; justify-content: space-between; }
.pendulo-marca {
  font-family: var(--font-mono); font-size: 0.55rem; color: var(--text-muted);
  cursor: pointer; padding: 2px 4px; border-radius: 4px; transition: all 0.2s;
}
.pendulo-marca:hover { color: var(--gold-dark); }
.pendulo-marca.activa { color: var(--gold-primary); font-weight: 700; }

/* Slider */
.bpm-control {
  display: flex; align-items: center; gap: 10px;
}
.btn-bpm {
  width: 28px; height: 28px; border-radius: 50%;
  background: var(--bg-secondary); border: 1px solid var(--border-card);
  font-size: 1.1rem; font-weight: 700; color: var(--gold-dark);
  display: flex; align-items: center; justify-content: center;
  cursor: pointer; transition: all 0.2s; flex-shrink: 0;
}
.btn-bpm:hover { background: rgba(184,134,42,0.1); border-color: var(--gold-primary); }
.bpm-slider {
  flex: 1; height: 4px; accent-color: var(--gold-primary); cursor: pointer;
}

/* Tempo nombre */
.tempo-label {
  font-family: var(--font-display); font-size: 0.65rem;
  letter-spacing: 0.25em; text-transform: uppercase;
  color: var(--gold-dark); text-align: center;
}

/* Botón play */
.btn-play-metro {
  width: 100%; padding: 11px;
  background: linear-gradient(135deg, var(--gold-dark), var(--gold-primary));
  color: #fff; font-family: var(--font-display); font-size: 0.65rem;
  font-weight: 700; letter-spacing: 0.2em; text-transform: uppercase;
  border: none; border-radius: var(--radius-sm); cursor: pointer;
  transition: var(--transition); box-shadow: 0 3px 12px rgba(184,134,42,0.3);
}
.btn-play-metro:hover { transform: translateY(-1px); box-shadow: 0 6px 20px rgba(184,134,42,0.45); }
.btn-play-metro.activo {
  background: linear-gradient(135deg, #8a1a1a, #c0392b);
  box-shadow: 0 3px 12px rgba(192,57,43,0.3);
}
</style>
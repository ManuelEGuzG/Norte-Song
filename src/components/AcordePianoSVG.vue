<template>
  <g>
    <!-- Teclas blancas -->
    <rect v-for="(t, i) in teclasBlancas" :key="'b' + i"
      :x="t.x" :y="y0"
      :width="tkW - 1" :height="tkH"
      rx="2"
      :fill="notasActivas.has(t.nota) ? '#b8862a' : '#faf7f2'"
      stroke="#c8b090" stroke-width="0.8"
    />

    <!-- Teclas negras -->
    <rect v-for="(t, i) in teclasNegras" :key="'n' + i"
      :x="t.x" :y="y0"
      :width="tkW * 0.62" :height="tkH * 0.6"
      rx="1.5"
      :fill="notasActivas.has(t.nota) ? '#d4a843' : '#1a1208'"
      stroke="#0a0a0a" stroke-width="0.5"
    />

    <!-- Etiquetas en teclas activas blancas -->
    <text v-for="(t, i) in teclasBlancas.filter(t => notasActivas.has(t.nota))" :key="'lb' + i"
      :x="t.x + tkW / 2 - 0.5"
      :y="y0 + tkH - 6"
      text-anchor="middle" font-size="6.5"
      fill="#fff" font-family="Arial" font-weight="bold"
    >{{ t.nota }}</text>

    <!-- Etiquetas en teclas activas negras -->
    <text v-for="(t, i) in teclasNegras.filter(t => notasActivas.has(t.nota))" :key="'ln' + i"
      :x="t.x + tkW * 0.31"
      :y="y0 + tkH * 0.52"
      text-anchor="middle" font-size="5.5"
      fill="#fff" font-family="Arial" font-weight="bold"
    >{{ t.nota }}</text>
  </g>
</template>

<script setup>
import { computed } from 'vue'
const props = defineProps({
  diagrama: { type: Object, required: true },
  w: { type: Number, default: 110 },
  h: { type: Number, default: 90 },
})

const BLANCAS = ['C','D','E','F','G','A','B']
const NEGRAS  = [
  { nota:'C#', pos: 0 },
  { nota:'D#', pos: 1 },
  { nota:'F#', pos: 3 },
  { nota:'G#', pos: 4 },
  { nota:'A#', pos: 5 },
]

const y0  = 8
const tkW = computed(() => (props.w - 4) / 7)
const tkH = computed(() => props.h - y0 - 4)

const teclasBlancas = computed(() =>
  BLANCAS.map((nota, i) => ({ nota, x: 2 + i * tkW.value }))
)
const teclasNegras = computed(() =>
  NEGRAS.map(({ nota, pos }) => ({
    nota,
    x: 2 + (pos + 1) * tkW.value - tkW.value * 0.33
  }))
)

// Normalizar notas: Bb→A#, Eb→D#, Ab→G#, Db→C#, Gb→F#
const EQUIV = { 'Bb':'A#','Eb':'D#','Ab':'G#','Db':'C#','Gb':'F#' }
const notasActivas = computed(() => {
  const raw = props.diagrama?.notas || []
  return new Set(raw.map(n => EQUIV[n] || n))
})
</script>
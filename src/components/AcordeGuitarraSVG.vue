<template>
  <g>
    <!-- 
      ORIENTACIÓN HORIZONTAL:
      - Las cuerdas van de ARRIBA (E6 grave) a ABAJO (e1 aguda) — vertical
      - Los trastes van de IZQUIERDA a DERECHA
      - La nuez/traste inicial está a la izquierda
      - Los dedos se posicionan: cuerda = fila (y), traste = columna (x)
    -->

    <!-- Número de traste si posición alta -->
    <text
      v-if="diagrama.fret && diagrama.fret > 1"
      :x="x0 - 8" :y="y0 + 2"
      text-anchor="end" font-size="8"
      fill="#9a7420" font-family="monospace" font-weight="700"
    >{{ diagrama.fret }}</text>

    <!-- Nuez gruesa (solo traste 1) -->
    <rect
      v-if="!diagrama.fret || diagrama.fret === 1"
      :x="x0 - 4" :y="y0 - 0.5"
      :width="4" :height="(cuerdas - 1) * sy + 1"
      rx="1" fill="#1a1208"
    />

    <!-- Líneas de trastes (verticales en horizontal) -->
    <line v-for="t in trastes" :key="'t' + t"
      :x1="x0 + (t - 1) * sx" :y1="y0"
      :x2="x0 + (t - 1) * sx" :y2="y0 + (cuerdas - 1) * sy"
      stroke="#c8b090" stroke-width="1"
    />

    <!-- Líneas de cuerdas (horizontales) E6 arriba → e1 abajo -->
    <line v-for="c in cuerdas" :key="'c' + c"
      :x1="x0" :y1="y0 + (c - 1) * sy"
      :x2="x0 + (trastes - 1) * sx" :y2="y0 + (c - 1) * sy"
      stroke="#aaa090" stroke-width="0.9"
    />

    <!-- Cejilla (barre) — rectángulo vertical sobre trastes -->
    <rect v-if="diagrama.barre"
      :x="x0 + (diagrama.barre.traste - 1) * sx + sx * 0.2"
      :y="y0 + diagrama.barre.desde * sy - radio * 0.9"
      :width="sx * 0.6"
      :height="(diagrama.barre.hasta - diagrama.barre.desde) * sy + radio * 1.8"
      :rx="radio * 0.85"
      fill="#b8862a"
    />

    <!-- Dedos: c=cuerda(0=E6 arriba), t=traste -->
    <circle v-for="(dedo, i) in (diagrama.dedos || [])" :key="'d' + i"
      :cx="x0 + (dedo.t - 1) * sx + sx * 0.5"
      :cy="y0 + dedo.c * sy"
      :r="radio"
      fill="#b8862a"
    />

    <!-- X y O a la izquierda de cada cuerda (c=0 arriba=E6) -->
    <text v-for="(marca, i) in (diagrama.marcas || [])" :key="'m' + i"
      :x="x0 - 12"
      :y="y0 + marca.c * sy + 3.5"
      text-anchor="middle" font-size="9" font-weight="bold"
      :fill="marca.tipo === 'x' ? '#c0392b' : '#2a8a44'"
      font-family="Arial"
    >{{ marca.tipo === 'x' ? '✕' : 'O' }}</text>

    <!-- Etiquetas de cuerdas a la derecha (E6 arriba → e1 abajo) -->
    <text v-for="c in cuerdas" :key="'lab' + c"
      :x="x0 + (trastes - 1) * sx + 9"
      :y="y0 + (c - 1) * sy + 3.5"
      text-anchor="start" font-size="7"
      fill="#c8a870" font-family="monospace"
    >{{ ['E','A','D','G','B','e'][c - 1] }}</text>
  </g>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  diagrama: { type: Object, required: true },
  w: { type: Number, default: 110 },
  h: { type: Number, default: 90 },
})

const cuerdas = 6
const trastes = 5

// Layout horizontal: trastes van de izquierda a derecha
// Cuerdas van de arriba (E6) a abajo (e1)
const margenIzq = 22   // espacio para X/O a la izquierda
const margenArr = 8    // espacio arriba
const margenDer = 14   // espacio para etiquetas derecha
const margenAba = 8    // espacio abajo

const sx = computed(() => (props.w - margenIzq - margenDer) / (trastes - 1))
const sy = computed(() => (props.h - margenArr - margenAba) / (cuerdas - 1))
const x0 = margenIzq
const y0 = margenArr
const radio = computed(() => Math.min(sx.value, sy.value) * 0.36)
</script>
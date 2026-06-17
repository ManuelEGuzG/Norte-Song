<template>
  <div class="vista-acordes">
    <div class="pagina-header fade-in">
      <p class="header-supra">Referencia</p>
      <h2 class="header-titulo">Acordes</h2>
      <p class="header-desc">Posiciones para los instrumentos más comunes</p>
    </div>

    <!-- Selector de instrumento -->
    <div class="selector-wrap fade-in-2">
      <button
        v-for="inst in instrumentos"
        :key="inst.id"
        class="btn-instrumento"
        :class="{ activo: instrumentoActivo === inst.id }"
        @click="instrumentoActivo = inst.id"
      >
        <span class="inst-icono">{{ inst.icono }}</span>
        <span class="inst-nombre">{{ inst.nombre }}</span>
      </button>
    </div>

    <!-- Filas de acordes -->
    <div class="filas-notas fade-in-3">
      <div v-for="fila in filasActivas" :key="fila.key" class="fila-nota">

        <div class="fila-label">
          <span class="fila-label-nota">{{ fila.key }}</span>
          <span class="fila-label-alt" v-if="fila.alt">{{ fila.alt }}</span>
        </div>

        <div class="fila-acordes-wrap">
          <div class="fila-acordes">
            <div
              v-for="acorde in fila.acordes"
              :key="acorde.nombre"
              class="acorde-item"
              :class="{ 'acorde-item-piano': instrumentoActivo === 'piano' }"
            >
              <span class="acorde-nombre">{{ acorde.nombre }}</span>

              <!-- Guitarra -->
              <svg v-if="instrumentoActivo === 'guitarra'"
                :viewBox="`0 0 ${W} ${H}`" :width="W" :height="H" class="acorde-svg">
                <AcordeGuitarraSVG :diagrama="acorde.d" :w="W" :h="H" />
              </svg>

              <!-- Bajo -->
              <svg v-else-if="instrumentoActivo === 'bajo'"
                :viewBox="`0 0 ${W} ${HB}`" :width="W" :height="HB" class="acorde-svg">
                <AcordeBajoSVG :diagrama="acorde.d" :w="W" :h="HB" />
              </svg>

              <!-- Ukulele -->
              <svg v-else-if="instrumentoActivo === 'ukulele'"
                :viewBox="`0 0 ${W} ${HB}`" :width="W" :height="HB" class="acorde-svg">
                <AcordeUkuleleSVG :diagrama="acorde.d" :w="W" :h="HB" />
              </svg>

              <!-- Piano -->
              <svg v-else-if="instrumentoActivo === 'piano'"
                :viewBox="`0 0 ${WP} ${HP}`" :width="WP" :height="HP" class="acorde-svg">
                <AcordePianoSVG :diagrama="acorde.d" :w="WP" :h="HP" />
              </svg>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import AcordeGuitarraSVG from '../components/AcordeGuitarraSVG.vue'
import AcordeBajoSVG     from '../components/AcordeBajoSVG.vue'
import AcordeUkuleleSVG  from '../components/AcordeUkuleleSVG.vue'
import AcordePianoSVG    from '../components/AcordePianoSVG.vue'

const W  = 90
const H  = 76
const HB = 66
const WP = 100
const HP = 70

const instrumentoActivo = ref('guitarra')

const instrumentos = [
  { id: 'guitarra', nombre: 'Guitarra', icono: '' },
  { id: 'bajo',     nombre: 'Bajo',     icono: '' },
  { id: 'ukulele',  nombre: 'Ukulele',  icono: '' },
  { id: 'piano',    nombre: 'Piano',    icono: '' },
]

const FILAS_GUITARRA = [
  { key:'C', alt:null, acordes:[
    { nombre:'C',      d:{ dedos:[{c:4,t:3},{c:3,t:2},{c:1,t:1}],          marcas:[{c:5,tipo:'x'},{c:2,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Cm',     d:{ fret:3, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:2}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'C7',     d:{ dedos:[{c:4,t:3},{c:3,t:2},{c:2,t:3},{c:1,t:1}],  marcas:[{c:5,tipo:'x'},{c:0,tipo:'o'}] }},
    { nombre:'Cmaj7',  d:{ dedos:[{c:4,t:3},{c:3,t:2}],                     marcas:[{c:5,tipo:'x'},{c:2,tipo:'o'},{c:1,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Cm7',    d:{ fret:3, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:1,t:2}],           marcas:[{c:5,tipo:'x'}] }},
    { nombre:'Csus2',  d:{ dedos:[{c:4,t:3},{c:3,t:2},{c:2,t:5}],           marcas:[{c:5,tipo:'x'},{c:1,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Csus4',  d:{ dedos:[{c:4,t:3},{c:3,t:3},{c:1,t:1}],           marcas:[{c:5,tipo:'x'},{c:2,tipo:'o'},{c:0,tipo:'o'}] }},
  ]},
  { key:'C#', alt:'Db', acordes:[
    { nombre:'C#',     d:{ fret:4, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:3}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'C#m',    d:{ fret:4, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:2}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'C#7',    d:{ fret:4, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:1,t:3}],           marcas:[{c:5,tipo:'x'}] }},
    { nombre:'C#maj7', d:{ fret:4, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:2},{c:1,t:3}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'C#m7',   d:{ fret:4, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:1,t:2}],           marcas:[{c:5,tipo:'x'}] }},
  ]},
  { key:'D', alt:null, acordes:[
    { nombre:'D',      d:{ dedos:[{c:2,t:2},{c:1,t:3},{c:0,t:2}],            marcas:[{c:5,tipo:'x'},{c:4,tipo:'x'},{c:3,tipo:'o'}] }},
    { nombre:'Dm',     d:{ dedos:[{c:2,t:2},{c:1,t:3},{c:0,t:1}],            marcas:[{c:5,tipo:'x'},{c:4,tipo:'x'},{c:3,tipo:'o'}] }},
    { nombre:'D7',     d:{ dedos:[{c:2,t:2},{c:1,t:1},{c:0,t:2}],            marcas:[{c:5,tipo:'x'},{c:4,tipo:'x'},{c:3,tipo:'o'}] }},
    { nombre:'Dmaj7',  d:{ dedos:[{c:2,t:2},{c:1,t:2},{c:0,t:2}],            marcas:[{c:5,tipo:'x'},{c:4,tipo:'x'},{c:3,tipo:'o'}] }},
    { nombre:'Dm7',    d:{ dedos:[{c:2,t:2},{c:1,t:1},{c:0,t:1}],            marcas:[{c:5,tipo:'x'},{c:4,tipo:'x'},{c:3,tipo:'o'}] }},
    { nombre:'Dsus2',  d:{ dedos:[{c:2,t:2},{c:1,t:3}],                     marcas:[{c:5,tipo:'x'},{c:4,tipo:'x'},{c:3,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Dsus4',  d:{ dedos:[{c:2,t:2},{c:1,t:3},{c:0,t:3}],            marcas:[{c:5,tipo:'x'},{c:4,tipo:'x'},{c:3,tipo:'o'}] }},
  ]},
  { key:'D#', alt:'Eb', acordes:[
    { nombre:'D#',     d:{ fret:6, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:3}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'D#m',    d:{ fret:6, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:2}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'D#7',    d:{ fret:6, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:1,t:3}],           marcas:[{c:5,tipo:'x'}] }},
    { nombre:'Ebmaj7', d:{ fret:6, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:2},{c:1,t:3}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'D#m7',   d:{ fret:6, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:1,t:2}],           marcas:[{c:5,tipo:'x'}] }},
  ]},
  { key:'E', alt:null, acordes:[
    { nombre:'E',      d:{ dedos:[{c:4,t:2},{c:3,t:2},{c:2,t:1}],            marcas:[{c:5,tipo:'o'},{c:1,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Em',     d:{ dedos:[{c:4,t:2},{c:3,t:2}],                     marcas:[{c:5,tipo:'o'},{c:2,tipo:'o'},{c:1,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'E7',     d:{ dedos:[{c:4,t:2},{c:2,t:1}],                     marcas:[{c:5,tipo:'o'},{c:3,tipo:'o'},{c:1,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Emaj7',  d:{ dedos:[{c:4,t:2},{c:3,t:1},{c:2,t:1}],            marcas:[{c:5,tipo:'o'},{c:1,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Em7',    d:{ dedos:[{c:4,t:2}],                               marcas:[{c:5,tipo:'o'},{c:3,tipo:'o'},{c:2,tipo:'o'},{c:1,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Esus4',  d:{ dedos:[{c:4,t:2},{c:3,t:2},{c:2,t:2}],            marcas:[{c:5,tipo:'o'},{c:1,tipo:'o'},{c:0,tipo:'o'}] }},
  ]},
  { key:'F', alt:null, acordes:[
    { nombre:'F',      d:{ barre:{desde:0,hasta:5,traste:1},                 dedos:[{c:4,t:3},{c:3,t:3},{c:2,t:2}], marcas:[] }},
    { nombre:'Fm',     d:{ barre:{desde:0,hasta:5,traste:1},                 dedos:[{c:4,t:3},{c:3,t:3}],           marcas:[] }},
    { nombre:'F7',     d:{ barre:{desde:0,hasta:5,traste:1},                 dedos:[{c:4,t:3},{c:2,t:2}],           marcas:[] }},
    { nombre:'Fmaj7',  d:{ barre:{desde:0,hasta:5,traste:1},                 dedos:[{c:4,t:3},{c:3,t:2},{c:2,t:2}], marcas:[] }},
    { nombre:'Fm7',    d:{ barre:{desde:0,hasta:5,traste:1},                 dedos:[{c:4,t:3}],                     marcas:[] }},
    { nombre:'Fsus4',  d:{ barre:{desde:0,hasta:5,traste:1},                 dedos:[{c:4,t:3},{c:3,t:3},{c:2,t:3}], marcas:[] }},
  ]},
  { key:'F#', alt:'Gb', acordes:[
    { nombre:'F#',     d:{ fret:2, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3},{c:3,t:3},{c:2,t:2}], marcas:[] }},
    { nombre:'F#m',    d:{ fret:2, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3},{c:3,t:3}],           marcas:[] }},
    { nombre:'F#7',    d:{ fret:2, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3},{c:2,t:2}],           marcas:[] }},
    { nombre:'F#maj7', d:{ fret:2, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3},{c:3,t:2},{c:2,t:2}], marcas:[] }},
    { nombre:'F#m7',   d:{ fret:2, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3}],                     marcas:[] }},
  ]},
  { key:'G', alt:null, acordes:[
    { nombre:'G',      d:{ dedos:[{c:5,t:3},{c:4,t:2},{c:0,t:3}],            marcas:[{c:3,tipo:'o'},{c:2,tipo:'o'},{c:1,tipo:'o'}] }},
    { nombre:'Gm',     d:{ fret:3, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3},{c:3,t:3}],           marcas:[] }},
    { nombre:'G7',     d:{ dedos:[{c:5,t:3},{c:4,t:2},{c:0,t:1}],            marcas:[{c:3,tipo:'o'},{c:2,tipo:'o'},{c:1,tipo:'o'}] }},
    { nombre:'Gmaj7',  d:{ dedos:[{c:5,t:3},{c:4,t:2},{c:0,t:2}],            marcas:[{c:3,tipo:'o'},{c:2,tipo:'o'},{c:1,tipo:'o'}] }},
    { nombre:'Gm7',    d:{ fret:3, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3}],                     marcas:[] }},
    { nombre:'Gsus2',  d:{ dedos:[{c:5,t:3},{c:4,t:2},{c:1,t:3},{c:0,t:3}],  marcas:[{c:3,tipo:'o'},{c:2,tipo:'o'}] }},
    { nombre:'Gsus4',  d:{ dedos:[{c:5,t:3},{c:1,t:1},{c:0,t:3}],            marcas:[{c:4,tipo:'o'},{c:3,tipo:'o'},{c:2,tipo:'o'}] }},
  ]},
  { key:'G#', alt:'Ab', acordes:[
    { nombre:'G#',     d:{ fret:4, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3},{c:3,t:3},{c:2,t:2}], marcas:[] }},
    { nombre:'G#m',    d:{ fret:4, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3},{c:3,t:3}],           marcas:[] }},
    { nombre:'Ab7',    d:{ fret:4, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3},{c:2,t:2}],           marcas:[] }},
    { nombre:'Abmaj7', d:{ fret:4, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3},{c:3,t:2},{c:2,t:2}], marcas:[] }},
    { nombre:'G#m7',   d:{ fret:4, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3}],                     marcas:[] }},
  ]},
  { key:'A', alt:null, acordes:[
    { nombre:'A',      d:{ dedos:[{c:3,t:2},{c:2,t:2},{c:1,t:2}],            marcas:[{c:5,tipo:'x'},{c:4,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Am',     d:{ dedos:[{c:3,t:2},{c:2,t:2},{c:1,t:1}],            marcas:[{c:5,tipo:'x'},{c:4,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'A7',     d:{ dedos:[{c:3,t:2},{c:1,t:2}],                     marcas:[{c:5,tipo:'x'},{c:4,tipo:'o'},{c:2,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Amaj7',  d:{ dedos:[{c:3,t:2},{c:2,t:1},{c:1,t:2}],            marcas:[{c:5,tipo:'x'},{c:4,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Am7',    d:{ dedos:[{c:3,t:2},{c:1,t:1}],                     marcas:[{c:5,tipo:'x'},{c:4,tipo:'o'},{c:2,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Asus2',  d:{ dedos:[{c:3,t:2},{c:2,t:2}],                     marcas:[{c:5,tipo:'x'},{c:4,tipo:'o'},{c:1,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Asus4',  d:{ dedos:[{c:3,t:2},{c:2,t:2},{c:1,t:3}],            marcas:[{c:5,tipo:'x'},{c:4,tipo:'o'},{c:0,tipo:'o'}] }},
  ]},
  { key:'A#', alt:'Bb', acordes:[
    { nombre:'A#',     d:{ barre:{desde:0,hasta:4,traste:1},                 dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:3}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'A#m',    d:{ barre:{desde:0,hasta:4,traste:1},                 dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:2}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'Bb7',    d:{ barre:{desde:0,hasta:4,traste:1},                 dedos:[{c:3,t:3},{c:1,t:3}],           marcas:[{c:5,tipo:'x'}] }},
    { nombre:'Bbmaj7', d:{ barre:{desde:0,hasta:4,traste:1},                 dedos:[{c:3,t:3},{c:2,t:2},{c:1,t:3}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'Bbm7',   d:{ barre:{desde:0,hasta:4,traste:1},                 dedos:[{c:3,t:3},{c:1,t:2}],           marcas:[{c:5,tipo:'x'}] }},
  ]},
  { key:'B', alt:null, acordes:[
    { nombre:'B',      d:{ fret:2, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:3}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'Bm',     d:{ fret:2, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:2}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'B7',     d:{ dedos:[{c:4,t:2},{c:3,t:1},{c:2,t:2},{c:0,t:2}],  marcas:[{c:5,tipo:'x'},{c:1,tipo:'o'}] }},
    { nombre:'Bmaj7',  d:{ fret:2, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:2},{c:1,t:3}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'Bm7',    d:{ fret:2, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:1,t:2}],           marcas:[{c:5,tipo:'x'}] }},
    { nombre:'Bsus4',  d:{ fret:2, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:4}], marcas:[{c:5,tipo:'x'}] }},
  ]},
];

// ── BAJO ──────────────────────────────────────────────────
// 4 cuerdas estándar: c=0 G aguda (arriba) → c=1 D → c=2 A → c=3 E grave (abajo)
// Corregido exactamente según los diagramas reales de tu interfaz gráfica
const FILAS_BAJO = [
  { key:'C',  alt:null,  acordes:[{ nombre:'C',  d:{ dedos:[{c:2,t:3}],         marcas:[{c:3,tipo:'x'},{c:1,tipo:'x'},{c:0,tipo:'x'}] }}]},
  { key:'C#', alt:'Db',  acordes:[{ nombre:'C#', d:{ fret:4, dedos:[{c:2,t:1}], marcas:[{c:3,tipo:'x'},{c:1,tipo:'x'},{c:0,tipo:'x'}] }}]},
  { key:'D',  alt:null,  acordes:[{ nombre:'D',  d:{ dedos:[{c:1,t:0}],         marcas:[{c:3,tipo:'x'},{c:2,tipo:'x'},{c:0,tipo:'x'}] }}]}, 
  { key:'D#', alt:'Eb',  acordes:[{ nombre:'D#', d:{ fret:6, dedos:[{c:2,t:1}], marcas:[{c:3,tipo:'x'},{c:1,tipo:'x'},{c:0,tipo:'x'}] }}]},
  { key:'E',  alt:null,  acordes:[{ nombre:'E',  d:{ dedos:[],                  marcas:[{c:3,tipo:'o'},{c:2,tipo:'x'},{c:1,tipo:'x'},{c:0,tipo:'x'}] }}]},
  { key:'F',  alt:null,  acordes:[{ nombre:'F',  d:{ dedos:[{c:3,t:1}],         marcas:[{c:2,tipo:'x'},{c:1,tipo:'x'},{c:0,tipo:'x'}] }}]},
  { key:'F#', alt:'Gb',  acordes:[{ nombre:'F#', d:{ dedos:[{c:3,t:2}],         marcas:[{c:2,tipo:'x'},{c:1,tipo:'x'},{c:0,tipo:'x'}] }}]},
  { key:'G',  alt:null,  acordes:[{ nombre:'G',  d:{ dedos:[{c:3,t:3}],         marcas:[{c:2,tipo:'x'},{c:1,tipo:'x'},{c:0,tipo:'x'}] }}]},
  { key:'G#', alt:'Ab',  acordes:[{ nombre:'G#', d:{ fret:4, dedos:[{c:3,t:1}], marcas:[{c:2,tipo:'x'},{c:1,tipo:'x'},{c:0,tipo:'x'}] }}]},
  { key:'A',  alt:null,  acordes:[{ nombre:'A',  d:{ dedos:[],                  marcas:[{c:3,tipo:'x'},{c:2,tipo:'o'},{c:1,tipo:'x'},{c:0,tipo:'x'}] }}]},
  { key:'A#', alt:'Bb',  acordes:[{ nombre:'A#', d:{ dedos:[{c:2,t:1}],         marcas:[{c:3,tipo:'x'},{c:1,tipo:'x'},{c:0,tipo:'x'}] }}]},
  { key:'B',  alt:null,  acordes:[{ nombre:'B',  d:{ dedos:[{c:2,t:2}],         marcas:[{c:3,tipo:'x'},{c:1,tipo:'x'},{c:0,tipo:'x'}] }}]},
];

// ── UKULELE ───────────────────────────────────────────────
// 4 cuerdas invertidas según interfaz: c=0 A (arriba) → c=1 E → c=2 C → c=3 G (abajo)
const FILAS_UKULELE = [
  { key:'C', alt:null, acordes:[
    { nombre:'C',     d:{ dedos:[{c:0,t:3}],                                marcas:[{c:1,tipo:'o'},{c:2,tipo:'o'},{c:3,tipo:'o'}] }},
    { nombre:'Cm',    d:{ fret:3, barre:{desde:0,hasta:3,traste:1},         dedos:[],                              marcas:[] }},
    { nombre:'C7',    d:{ dedos:[{c:0,t:1}],                                marcas:[{c:1,tipo:'o'},{c:2,tipo:'o'},{c:3,tipo:'o'}] }},
    { nombre:'Cmaj7', d:{ dedos:[{c:0,t:2}],                                marcas:[{c:1,tipo:'o'},{c:2,tipo:'o'},{c:3,tipo:'o'}] }},
    { nombre:'Cm7',   d:{ fret:3, barre:{desde:0,hasta:3,traste:1},         dedos:[],                              marcas:[] }},
    { nombre:'Csus2', d:{ dedos:[{c:0,t:5},{c:1,t:3},{c:2,t:2}],            marcas:[{c:3,tipo:'o'}] }},
    { nombre:'Csus4', d:{ dedos:[{c:0,t:3},{c:1,t:3},{c:2,t:5}],            marcas:[{c:3,tipo:'o'}] }},
  ]},
  { key:'C#', alt:'Db', acordes:[
    { nombre:'C#',    d:{ fret:4, barre:{desde:0,hasta:3,traste:1},         dedos:[],                              marcas:[] }},
    { nombre:'C#m',   d:{ fret:4, barre:{desde:0,hasta:3,traste:1},         dedos:[],                              marcas:[] }},
    { nombre:'C#7',   d:{ fret:4, barre:{desde:0,hasta:3,traste:1},         dedos:[],                              marcas:[] }},
    { nombre:'C#m7',  d:{ fret:4, barre:{desde:0,hasta:3,traste:1},         dedos:[],                              marcas:[] }},
  ]},
  { key:'D', alt:null, acordes:[
    { nombre:'D',     d:{ dedos:[{c:1,t:2},{c:2,t:2},{c:3,t:2}],            marcas:[{c:0,tipo:'o'}] }},
    { nombre:'Dm',    d:{ dedos:[{c:0,t:0},{c:1,t:1},{c:2,t:2},{c:3,t:2}],  marcas:[] }},
    { nombre:'D7',    d:{ dedos:[{c:0,t:3},{c:1,t:2},{c:2,t:2},{c:3,t:2}],  marcas:[] }},
    { nombre:'Dmaj7', d:{ dedos:[{c:0,t:4},{c:1,t:2},{c:2,t:2},{c:3,t:2}],  marcas:[] }},
    { nombre:'Dm7',   d:{ dedos:[{c:0,t:3},{c:1,t:1},{c:2,t:2},{c:3,t:2}],  marcas:[] }},
    { nombre:'Dsus4', d:{ dedos:[{c:0,t:0},{c:1,t:3},{c:2,t:2},{c:3,t:2}],  marcas:[] }},
  ]},
  { key:'D#', alt:'Eb', acordes:[
    { nombre:'D#',    d:{ fret:3, barre:{desde:0,hasta:3,traste:1},         dedos:[],                              marcas:[] }},
    { nombre:'D#m',   d:{ fret:3, barre:{desde:0,hasta:3,traste:1},         dedos:[],                              marcas:[] }},
    { nombre:'Eb7',   d:{ fret:3, barre:{desde:0,hasta:3,traste:1},         dedos:[],                              marcas:[] }},
    { nombre:'D#m7',  d:{ fret:3, barre:{desde:0,hasta:3,traste:1},         dedos:[],                              marcas:[] }},
  ]},
  { key:'E', alt:null, acordes:[
    { nombre:'E',     d:{ dedos:[{c:0,t:2},{c:1,t:4},{c:2,t:4},{c:3,t:4}],  marcas:[] }},
    { nombre:'Em',    d:{ dedos:[{c:0,t:2},{c:1,t:3},{c:2,t:4}],            marcas:[{c:3,tipo:'o'}] }},
    { nombre:'E7',    d:{ dedos:[{c:0,t:2},{c:2,t:2},{c:3,t:1}],            marcas:[{c:1,tipo:'o'}] }},
    { nombre:'Emaj7', d:{ dedos:[{c:0,t:2},{c:1,t:4},{c:2,t:3},{c:3,t:1}],  marcas:[] }},
    { nombre:'Em7',   d:{ dedos:[{c:0,t:2},{c:2,t:2}],                      marcas:[{c:1,tipo:'o'},{c:3,tipo:'o'}] }},
    { nombre:'Esus4', d:{ dedos:[{c:0,t:2},{c:1,t:5},{c:2,t:4},{c:3,t:4}],  marcas:[] }},
  ]},
  { key:'F', alt:null, acordes:[
    { nombre:'F',     d:{ dedos:[{c:1,t:1},{c:3,t:2}],                      marcas:[{c:0,tipo:'o'},{c:2,tipo:'o'}] }},
    { nombre:'Fm',    d:{ dedos:[{c:0,t:3},{c:1,t:1},{c:3,t:1}],            marcas:[{c:2,tipo:'o'}] }},
    { nombre:'F7',    d:{ dedos:[{c:0,t:3},{c:1,t:1},{c:2,t:3},{c:3,t:2}],  marcas:[] }},
    { nombre:'Fmaj7', d:{ dedos:[{c:0,t:3},{c:1,t:1},{c:2,t:4},{c:3,t:2}],  marcas:[] }},
    { nombre:'Fm7',   d:{ dedos:[{c:0,t:3},{c:1,t:1},{c:2,t:3},{c:3,t:1}],  marcas:[] }},
    { nombre:'Fsus4', d:{ dedos:[{c:1,t:1},{c:3,t:3}],                      marcas:[{c:0,tipo:'o'},{c:2,tipo:'o'}] }},
  ]},
  { key:'F#', alt:'Gb', acordes:[
    { nombre:'F#',    d:{ fret:2, barre:{desde:0,hasta:3,traste:1},         dedos:[],                              marcas:[] }},
    { nombre:'F#m',   d:{ fret:2, barre:{desde:0,hasta:3,traste:1},         dedos:[],                              marcas:[] }},
    { nombre:'F#7',   d:{ fret:2, barre:{desde:0,hasta:3,traste:1},         dedos:[],                              marcas:[] }},
    { nombre:'F#m7',  d:{ fret:2, barre:{desde:0,hasta:3,traste:1},         dedos:[],                              marcas:[] }},
  ]},
  { key:'G', alt:null, acordes:[
    { nombre:'G',     d:{ dedos:[{c:0,t:2},{c:1,t:3},{c:2,t:2}],            marcas:[{c:3,tipo:'o'}] }},
    { nombre:'Gm',    d:{ dedos:[{c:0,t:1},{c:1,t:3},{c:2,t:2}],            marcas:[{c:3,tipo:'o'}] }},
    { nombre:'G7',    d:{ dedos:[{c:0,t:2},{c:1,t:1},{c:2,t:2}],            marcas:[{c:3,tipo:'o'}] }},
    { nombre:'Gmaj7', d:{ dedos:[{c:0,t:2},{c:1,t:2},{c:2,t:2}],            marcas:[{c:3,tipo:'o'}] }},
    { nombre:'Gm7',   d:{ dedos:[{c:0,t:1},{c:1,t:1},{c:2,t:2}],            marcas:[{c:3,tipo:'o'}] }},
    { nombre:'Gsus2', d:{ dedos:[{c:0,t:0},{c:1,t:3},{c:2,t:2}],            marcas:[{c:3,tipo:'o'}] }},
    { nombre:'Gsus4', d:{ dedos:[{c:0,t:3},{c:1,t:3},{c:2,t:2}],            marcas:[{c:3,tipo:'o'}] }},
  ]},
  { key:'G#', alt:'Ab', acordes:[
    { nombre:'G#',    d:{ fret:4, barre:{desde:0,hasta:3,traste:1},         dedos:[],                              marcas:[] }},
    { nombre:'G#m',   d:{ fret:4, barre:{desde:0,hasta:3,traste:1},         dedos:[],                              marcas:[] }},
    { nombre:'Ab7',   d:{ fret:4, barre:{desde:0,hasta:3,traste:1},         dedos:[],                              marcas:[] }},
    { nombre:'G#m7',  d:{ fret:4, barre:{desde:0,hasta:3,traste:1},         dedos:[],                              marcas:[] }},
  ]},
  { key:'A', alt:null, acordes:[
    { nombre:'A',     d:{ dedos:[{c:2,t:1},{c:3,t:2}],                      marcas:[{c:0,tipo:'o'},{c:1,tipo:'o'}] }},
    { nombre:'Am',    d:{ dedos:[{c:3,t:2}],                                marcas:[{c:0,tipo:'o'},{c:1,tipo:'o'},{c:2,tipo:'o'}] }},
    { nombre:'A7',    d:{ dedos:[{c:3,t:1}],                                marcas:[{c:0,tipo:'o'},{c:1,tipo:'o'},{c:2,tipo:'o'}] }},
    { nombre:'Amaj7', d:{ dedos:[{c:2,t:1},{c:3,t:1}],                      marcas:[{c:0,tipo:'o'},{c:1,tipo:'o'}] }},
    { nombre:'Am7',   d:{ dedos:[],                                         marcas:[{c:0,tipo:'o'},{c:1,tipo:'o'},{c:2,tipo:'o'},{c:3,tipo:'o'}] }},
    { nombre:'Asus2', d:{ dedos:[{c:2,t:2},{c:3,t:2}],                      marcas:[{c:0,tipo:'o'},{c:1,tipo:'o'}] }},
    { nombre:'Asus4', d:{ dedos:[{c:0,t:0},{c:1,t:0},{c:2,t:2},{c:3,t:2}],  marcas:[] }},
  ]},
  { key:'A#', alt:'Bb', acordes:[
    { nombre:'A#',    d:{ barre:{desde:0,hasta:3,traste:1},                 dedos:[{c:2,t:2},{c:3,t:3}],           marcas:[] }},
    { nombre:'A#m',   d:{ barre:{desde:0,hasta:3,traste:1},                 dedos:[{c:3,t:3}],                     marcas:[] }},
    { nombre:'Bb7',   d:{ barre:{desde:0,hasta:3,traste:1},                 dedos:[{c:2,t:2}],                     marcas:[] }},
    { nombre:'Bbm7',  d:{ barre:{desde:0,hasta:3,traste:1},                 dedos:[],                              marcas:[] }},
  ]},
  { key:'B', alt:null, acordes:[
    { nombre:'B',     d:{ fret:2, barre:{desde:0,hasta:3,traste:1},         dedos:[{c:2,t:2},{c:3,t:3}],           marcas:[] }},
    { nombre:'Bm',    d:{ fret:2, barre:{desde:0,hasta:3,traste:1},         dedos:[{c:3,t:3}],                     marcas:[] }},
    { nombre:'B7',    d:{ dedos:[{c:0,t:2},{c:1,t:2},{c:2,t:3},{c:3,t:2}],  marcas:[] }},
    { nombre:'Bmaj7', d:{ fret:2, barre:{desde:0,hasta:3,traste:1},         dedos:[{c:2,t:2}],                     marcas:[] }},
    { nombre:'Bm7',   d:{ fret:2, barre:{desde:0,hasta:3,traste:1},         dedos:[],                              marcas:[] }},
    { nombre:'Bsus4', d:{ fret:2, barre:{desde:0,hasta:3,traste:1},         dedos:[{c:3,t:3}],                     marcas:[] }},
  ]},
];

// ── PIANO ─────────────────────────────────────────────────
const FILAS_PIANO = [
  { key:'C', alt:null, acordes:[
    { nombre:'C',     d:{ notas:['C','E','G'] }},
    { nombre:'Cm',    d:{ notas:['C','Eb','G'] }},
    { nombre:'C7',    d:{ notas:['C','E','G','Bb'] }},
    { nombre:'Cmaj7', d:{ notas:['C','E','G','B'] }},
    { nombre:'Cm7',   d:{ notas:['C','Eb','G','Bb'] }},
    { nombre:'Csus2', d:{ notas:['C','D','G'] }},
    { nombre:'Csus4', d:{ notas:['C','F','G'] }},
  ]},
  { key:'C#', alt:'Db', acordes:[
    { nombre:'C#',    d:{ notas:['C#','F','G#'] }},
    { nombre:'C#m',   d:{ notas:['C#','E','G#'] }},
    { nombre:'C#7',   d:{ notas:['C#','F','G#','B'] }},
    { nombre:'C#maj7',d:{ notas:['C#','F','G#','C'] }},
    { nombre:'C#m7',  d:{ notas:['C#','E','G#','B'] }},
  ]},
  { key:'D', alt:null, acordes:[
    { nombre:'D',     d:{ notas:['D','F#','A'] }},
    { nombre:'Dm',    d:{ notas:['D','F','A'] }},
    { nombre:'D7',    d:{ notas:['D','F#','A','C'] }},
    { nombre:'Dmaj7', d:{ notas:['D','F#','A','C#'] }},
    { nombre:'Dm7',   d:{ notas:['D','F','A','C'] }},
    { nombre:'Dsus2', d:{ notas:['D','E','A'] }},
    { nombre:'Dsus4', d:{ notas:['D','G','A'] }},
  ]},
  { key:'D#', alt:'Eb', acordes:[
    { nombre:'D#',    d:{ notas:['D#','G','A#'] }},
    { nombre:'D#m',   d:{ notas:['D#','F#','A#'] }},
    { nombre:'D#7',   d:{ notas:['D#','G','A#','C#'] }},
    { nombre:'Ebmaj7',d:{ notas:['D#','G','A#','D'] }},
    { nombre:'D#m7',  d:{ notas:['D#','F#','A#','C#'] }},
  ]},
  { key:'E', alt:null, acordes:[
    { nombre:'E',     d:{ notas:['E','G#','B'] }},
    { nombre:'Em',    d:{ notas:['E','G','B'] }},
    { nombre:'E7',    d:{ notas:['E','G#','B','D'] }},
    { nombre:'Emaj7', d:{ notas:['E','G#','B','D#'] }},
    { nombre:'Em7',   d:{ notas:['E','G','B','D'] }},
    { nombre:'Esus4', d:{ notas:['E','A','B'] }},
  ]},
  { key:'F', alt:null, acordes:[
    { nombre:'F',     d:{ notas:['F','A','C'] }},
    { nombre:'Fm',    d:{ notas:['F','G#','C'] }},
    { nombre:'F7',    d:{ notas:['F','A','C','D#'] }},
    { nombre:'Fmaj7', d:{ notas:['F','A','C','E'] }},
    { nombre:'Fm7',   d:{ notas:['F','G#','C','D#'] }},
    { nombre:'Fsus4', d:{ notas:['F','A#','C'] }},
  ]},
  { key:'F#', alt:'Gb', acordes:[
    { nombre:'F#',    d:{ notas:['F#','A#','C#'] }},
    { nombre:'F#m',   d:{ notas:['F#','A','C#'] }},
    { nombre:'F#7',   d:{ notas:['F#','A#','C#','E'] }},
    { nombre:'F#maj7',d:{ notas:['F#','A#','C#','F'] }},
    { nombre:'F#m7',  d:{ notas:['F#','A','C#','E'] }},
  ]},
  { key:'G', alt:null, acordes:[
    { nombre:'G',     d:{ notas:['G','B','D'] }},
    { nombre:'Gm',    d:{ notas:['G','A#','D'] }},
    { nombre:'G7',    d:{ notas:['G','B','D','F'] }},
    { nombre:'Gmaj7', d:{ notas:['G','B','D','F#'] }},
    { nombre:'Gm7',   d:{ notas:['G','A#','D','F'] }},
    { nombre:'Gsus2', d:{ notas:['G','A','D'] }},
    { nombre:'Gsus4', d:{ notas:['G','C','D'] }},
  ]},
  { key:'G#', alt:'Ab', acordes:[
    { nombre:'G#',    d:{ notas:['G#','C','D#'] }},
    { nombre:'G#m',   d:{ notas:['G#','B','D#'] }},
    { nombre:'Ab7',   d:{ notas:['G#','C','D#','F#'] }},
    { nombre:'Abmaj7',d:{ notas:['G#','C','D#','G'] }},
    { nombre:'G#m7',  d:{ notas:['G#','B','D#','F#'] }},
  ]},
  { key:'A', alt:null, acordes:[
    { nombre:'A',     d:{ notas:['A','C#','E'] }},
    { nombre:'Am',    d:{ notas:['A','C','E'] }},
    { nombre:'A7',    d:{ notas:['A','C#','E','G'] }},
    { nombre:'Amaj7', d:{ notas:['A','C#','E','G#'] }},
    { nombre:'Am7',   d:{ notas:['A','C','E','G'] }},
    { nombre:'Asus2', d:{ notas:['A','B','E'] }},
    { nombre:'Asus4', d:{ notas:['A','D','E'] }},
  ]},
  { key:'A#', alt:'Bb', acordes:[
    { nombre:'A#',    d:{ notas:['A#','D','F'] }},
    { nombre:'A#m',   d:{ notas:['A#','C#','F'] }},
    { nombre:'Bb7',   d:{ notas:['A#','D','F','G#'] }},
    { nombre:'Bbmaj7',d:{ notas:['A#','D','F','A'] }},
    { nombre:'Bbm7',  d:{ notas:['A#','C#','F','G#'] }},
  ]},
  { key:'B', alt:null, acordes:[
    { nombre:'B',     d:{ notas:['B','D#','F#'] }},
    { nombre:'Bm',    d:{ notas:['B','D','F#'] }},
    { nombre:'B7',    d:{ notas:['B','D#','F#','A'] }},
    { nombre:'Bmaj7', d:{ notas:['B','D#','F#','A#'] }},
    { nombre:'Bm7',   d:{ notas:['B','D','F#','A'] }},
    { nombre:'Bsus4', d:{ notas:['B','E','F#'] }},
  ]},
]

const MAPA = {
  guitarra: FILAS_GUITARRA,
  bajo:     FILAS_BAJO,
  ukulele:  FILAS_UKULELE,
  piano:    FILAS_PIANO,
}

const filasActivas = computed(() => MAPA[instrumentoActivo.value] || [])
</script>

<style scoped>
.vista-acordes { max-width: 100%; padding: 0 0 80px; overflow-x: hidden; }

.pagina-header { max-width: 1200px; margin: 0 auto; padding: 110px 32px 24px; }
.header-supra { font-family: var(--font-display); font-size: 0.6rem; letter-spacing: 0.45em; text-transform: uppercase; color: var(--text-muted); margin-bottom: 10px; }
.header-titulo { font-family: var(--font-display); font-size: clamp(2.4rem, 6vw, 3.8rem); font-weight: 700; color: var(--text-primary); letter-spacing: -0.01em; line-height: 1; margin-bottom: 10px; }
.header-desc { font-size: 1rem; color: var(--text-muted); font-style: italic; }

/* ── Selector ── */
.selector-wrap {
  max-width: 1200px; margin: 0 auto 32px;
  padding: 0 32px;
  display: flex; gap: 10px; flex-wrap: wrap;
}
.btn-instrumento {
  display: flex; align-items: center; gap: 8px;
  font-family: var(--font-display); font-size: 0.68rem;
  letter-spacing: 0.15em; text-transform: uppercase;
  color: var(--text-muted);
  background: var(--bg-card); border: 1px solid var(--border-card);
  padding: 10px 20px; border-radius: 24px;
  cursor: pointer; transition: var(--transition);
  box-shadow: var(--shadow-card);
}
.btn-instrumento:hover { border-color: var(--gold-pale); color: var(--gold-dark); }
.btn-instrumento.activo {
  background: linear-gradient(135deg, var(--gold-dark), var(--gold-primary));
  color: #faf7f2; border-color: transparent;
  box-shadow: 0 4px 16px rgba(184,134,42,0.35);
  font-weight: 700;
}
.inst-icono { font-size: 1.1rem; }
.inst-nombre { font-size: 0.68rem; }

/* ── Filas ── */
.filas-notas { display: flex; flex-direction: column; }
.fila-nota {
  display: flex; align-items: stretch;
  border-top: 1px solid var(--border-faint); min-height: 105px;
}
.fila-nota:last-child { border-bottom: 1px solid var(--border-faint); }

.fila-label {
  flex-shrink: 0; width: 90px;
  display: flex; flex-direction: column; align-items: center; justify-content: center; gap: 3px;
  padding: 16px 8px; background: var(--bg-secondary);
  border-right: 1px solid var(--border-faint);
  position: sticky; left: 0; z-index: 2;
}
.fila-label-nota { font-family: var(--font-display); font-size: 1.5rem; font-weight: 800; color: var(--text-primary); line-height: 1; }
.fila-label-alt  { font-family: var(--font-display); font-size: 0.7rem; color: var(--text-muted); letter-spacing: 0.05em; }

.fila-acordes-wrap {
  flex: 1; overflow-x: auto; overflow-y: hidden;
  scrollbar-width: thin; scrollbar-color: var(--gold-pale) transparent;
}
.fila-acordes-wrap::-webkit-scrollbar { height: 4px; }
.fila-acordes-wrap::-webkit-scrollbar-thumb { background: var(--gold-pale); border-radius: 2px; }

.fila-acordes { display: flex; align-items: center; padding: 10px 0; width: max-content; }

.acorde-item {
  display: flex; flex-direction: column; align-items: center; gap: 4px;
  padding: 8px 12px; border-right: 1px solid var(--border-faint);
  transition: background 0.2s ease; min-width: 110px;
}
.acorde-item-piano { min-width: 120px; }
.acorde-item:hover { background: rgba(184,134,42,0.05); }

.acorde-nombre {
  font-family: var(--font-mono); font-size: 0.78rem; font-weight: 700;
  color: var(--gold-dark); letter-spacing: 0.03em; text-align: center; white-space: nowrap;
}
.acorde-svg { display: block; }

.fila-nota:nth-child(even) .fila-acordes-wrap { background: rgba(250,247,242,0.5); }
.fila-nota:nth-child(even) .fila-label        { background: rgba(248,245,238,0.8); }

@media (max-width: 600px) {
  .fila-label { width: 60px; }
  .fila-label-nota { font-size: 1.1rem; }
  .acorde-item { padding: 6px 8px; min-width: 90px; }
  .selector-wrap { padding: 0 16px; }
  .btn-instrumento { padding: 8px 14px; font-size: 0.6rem; }
}
</style>
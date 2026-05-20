<template>
  <div class="vista-acordes">
    <div class="pagina-header fade-in">
      <p class="header-supra">Referencia</p>
      <h2 class="header-titulo">Acordes</h2>
      <p class="header-desc">Todas las variantes por nota</p>
    </div>

    <div class="filas-notas fade-in-2">
      <div v-for="fila in FILAS" :key="fila.key" class="fila-nota">

        <div class="fila-label">
          <span class="fila-label-nota">{{ fila.key }}</span>
          <span class="fila-label-alt" v-if="fila.alt">{{ fila.alt }}</span>
        </div>

        <div class="fila-acordes-wrap">
          <div class="fila-acordes">
            <div v-for="acorde in fila.acordes" :key="acorde.nombre" class="acorde-item">
              <span class="acorde-nombre">{{ acorde.nombre }}</span>
              <svg :viewBox="`0 0 ${W} ${H}`" :width="W" :height="H" class="acorde-svg">
                <AcordeGuitarraSVG :diagrama="acorde.d" :w="W" :h="H" />
              </svg>
            </div>
          </div>
        </div>

      </div>
    </div>
  </div>
</template>

<script setup>
import AcordeGuitarraSVG from '../components/AcordeGuitarraSVG.vue'

const W = 90
const H = 76

// ─────────────────────────────────────────────────────────────
// POSICIONES VERIFICADAS — Sistema CAGED
// Forma E: barre en 6 cuerdas + dedos en c1,c2,c3 trastes relativos 3,3,2
// Forma Em: barre + c1,c2 traste 3
// Forma A: barre c1-c5 + c2,c3,c4 traste 3
// Forma Am: barre c1-c5 + c1,c2 traste 3 (no c0)
//
// c=0 → E (6a, grave, arriba)   c=5 → e (1a, aguda, abajo)
// t=traste relativo a fret (t=1 = primer traste del barre o nuez)
// ─────────────────────────────────────────────────────────────
const FILAS = [
  // ══ C ══
  { key:'C', alt:null, acordes:[
    { nombre:'C',      d:{ dedos:[{c:4,t:3},{c:3,t:2},{c:1,t:1}],          marcas:[{c:5,tipo:'x'},{c:2,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Cm',     d:{ fret:3, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:2}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'C7',     d:{ dedos:[{c:4,t:3},{c:3,t:2},{c:2,t:3},{c:1,t:1}],  marcas:[{c:5,tipo:'x'},{c:0,tipo:'o'}] }},
    { nombre:'Cmaj7',  d:{ dedos:[{c:4,t:3},{c:3,t:2}],                     marcas:[{c:5,tipo:'x'},{c:2,tipo:'o'},{c:1,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Cm7',    d:{ fret:3, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:1,t:2}],           marcas:[{c:5,tipo:'x'}] }},
    { nombre:'Csus2',  d:{ dedos:[{c:4,t:3},{c:3,t:0},{c:1,t:1}],           marcas:[{c:5,tipo:'x'},{c:2,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Csus4',  d:{ dedos:[{c:4,t:3},{c:3,t:3},{c:2,t:0},{c:1,t:1}],  marcas:[{c:5,tipo:'x'},{c:0,tipo:'o'}] }},
    { nombre:'C/E',    d:{ dedos:[{c:4,t:3},{c:3,t:2},{c:1,t:1}],           marcas:[{c:5,tipo:'o'},{c:2,tipo:'o'},{c:0,tipo:'o'}] }},
  ]},

  // ══ C# / Db ══
  { key:'C#', alt:'Db', acordes:[
    { nombre:'C#',     d:{ fret:4, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:3}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'C#m',    d:{ fret:4, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:2}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'C#7',    d:{ fret:4, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:1,t:3}],           marcas:[{c:5,tipo:'x'}] }},
    { nombre:'C#maj7', d:{ fret:4, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:2},{c:1,t:3}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'C#m7',   d:{ fret:4, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3}],                     marcas:[{c:5,tipo:'x'}] }},
    { nombre:'Db',     d:{ fret:4, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:3}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'Dbm',    d:{ fret:4, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:2}], marcas:[{c:5,tipo:'x'}] }},
  ]},

  // ══ D ══
  { key:'D', alt:null, acordes:[
    { nombre:'D',      d:{ dedos:[{c:2,t:2},{c:1,t:3},{c:0,t:2}],            marcas:[{c:5,tipo:'x'},{c:4,tipo:'x'},{c:3,tipo:'o'}] }},
    { nombre:'Dm',     d:{ dedos:[{c:2,t:2},{c:1,t:3},{c:0,t:1}],            marcas:[{c:5,tipo:'x'},{c:4,tipo:'x'},{c:3,tipo:'o'}] }},
    { nombre:'D7',     d:{ dedos:[{c:2,t:2},{c:1,t:1},{c:0,t:2}],            marcas:[{c:5,tipo:'x'},{c:4,tipo:'x'},{c:3,tipo:'o'}] }},
    { nombre:'Dmaj7',  d:{ dedos:[{c:2,t:2},{c:1,t:2},{c:0,t:2}],            marcas:[{c:5,tipo:'x'},{c:4,tipo:'x'},{c:3,tipo:'o'}] }},
    { nombre:'Dm7',    d:{ dedos:[{c:2,t:2},{c:1,t:1},{c:0,t:1}],            marcas:[{c:5,tipo:'x'},{c:4,tipo:'x'},{c:3,tipo:'o'}] }},
    { nombre:'Dsus2',  d:{ dedos:[{c:2,t:2},{c:1,t:3}],                     marcas:[{c:5,tipo:'x'},{c:4,tipo:'x'},{c:3,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Dsus4',  d:{ dedos:[{c:2,t:2},{c:1,t:3},{c:0,t:3}],            marcas:[{c:5,tipo:'x'},{c:4,tipo:'x'},{c:3,tipo:'o'}] }},
    { nombre:'D/F#',   d:{ dedos:[{c:5,t:2},{c:2,t:2},{c:1,t:3},{c:0,t:2}],  marcas:[{c:4,tipo:'x'},{c:3,tipo:'o'}] }},
  ]},

  // ══ D# / Eb ══
  { key:'D#', alt:'Eb', acordes:[
    { nombre:'D#',     d:{ fret:6, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:3}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'D#m',    d:{ fret:6, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:2}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'D#7',    d:{ fret:6, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:1,t:3}],           marcas:[{c:5,tipo:'x'}] }},
    { nombre:'Ebmaj7', d:{ fret:6, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:2},{c:1,t:3}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'D#m7',   d:{ fret:6, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3}],                     marcas:[{c:5,tipo:'x'}] }},
    { nombre:'Eb',     d:{ fret:6, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:3}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'Ebm',    d:{ fret:6, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:2}], marcas:[{c:5,tipo:'x'}] }},
  ]},

  // ══ E ══
  { key:'E', alt:null, acordes:[
    { nombre:'E',      d:{ dedos:[{c:4,t:2},{c:3,t:2},{c:2,t:1}],            marcas:[{c:5,tipo:'o'},{c:1,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Em',     d:{ dedos:[{c:4,t:2},{c:3,t:2}],                     marcas:[{c:5,tipo:'o'},{c:2,tipo:'o'},{c:1,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'E7',     d:{ dedos:[{c:4,t:2},{c:2,t:1}],                     marcas:[{c:5,tipo:'o'},{c:3,tipo:'o'},{c:1,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Emaj7',  d:{ dedos:[{c:4,t:2},{c:3,t:1},{c:2,t:1}],            marcas:[{c:5,tipo:'o'},{c:1,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'En7',    d:{ dedos:[{c:4,t:2}],                               marcas:[{c:5,tipo:'o'},{c:3,tipo:'o'},{c:2,tipo:'o'},{c:1,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Esus4',  d:{ dedos:[{c:4,t:2},{c:3,t:2},{c:2,t:2}],            marcas:[{c:5,tipo:'o'},{c:1,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Esus2',  d:{ dedos:[{c:4,t:2},{c:3,t:4},{c:2,t:4}],            marcas:[{c:5,tipo:'o'},{c:1,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'E/G#',   d:{ fret:4, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3},{c:3,t:3},{c:2,t:2}], marcas:[] }},
  ]},

  // ══ F ══
  { key:'F', alt:null, acordes:[
    { nombre:'F',      d:{ barre:{desde:0,hasta:5,traste:1},                 dedos:[{c:4,t:3},{c:3,t:3},{c:2,t:2}], marcas:[] }},
    { nombre:'Fm',     d:{ barre:{desde:0,hasta:5,traste:1},                 dedos:[{c:4,t:3},{c:3,t:3}],           marcas:[] }},
    { nombre:'F7',     d:{ barre:{desde:0,hasta:5,traste:1},                 dedos:[{c:4,t:3},{c:2,t:2}],           marcas:[] }},
    { nombre:'Fmaj7',  d:{ dedos:[{c:3,t:2},{c:2,t:2},{c:1,t:1}],            marcas:[{c:5,tipo:'x'},{c:4,tipo:'x'},{c:0,tipo:'o'}] }},
    { nombre:'Fm7',    d:{ barre:{desde:0,hasta:5,traste:1},                 dedos:[{c:4,t:3}],                     marcas:[] }},
    { nombre:'Fsus4',  d:{ barre:{desde:0,hasta:5,traste:1},                 dedos:[{c:4,t:3},{c:3,t:3},{c:2,t:3}], marcas:[] }},
  ]},

  // ══ F# / Gb ══
  { key:'F#', alt:'Gb', acordes:[
    { nombre:'F#',     d:{ fret:2, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3},{c:3,t:3},{c:2,t:2}], marcas:[] }},
    { nombre:'F#m',    d:{ fret:2, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3},{c:3,t:3}],           marcas:[] }},
    { nombre:'F#7',    d:{ fret:2, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3},{c:2,t:2}],           marcas:[] }},
    { nombre:'F#maj7', d:{ fret:2, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:2}], marcas:[] }},
    { nombre:'F#m7',   d:{ fret:2, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3}],                     marcas:[] }},
    { nombre:'Gb',     d:{ fret:2, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3},{c:3,t:3},{c:2,t:2}], marcas:[] }},
    { nombre:'F#sus4', d:{ fret:2, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3},{c:3,t:3},{c:2,t:3}], marcas:[] }},
  ]},

  // ══ G ══
  { key:'G', alt:null, acordes:[
    { nombre:'G',      d:{ dedos:[{c:5,t:3},{c:4,t:2},{c:0,t:3}],            marcas:[{c:3,tipo:'o'},{c:2,tipo:'o'},{c:1,tipo:'o'}] }},
    { nombre:'Gm',     d:{ fret:3, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3},{c:3,t:3}],           marcas:[] }},
    { nombre:'G7',     d:{ dedos:[{c:5,t:3},{c:4,t:2},{c:0,t:1}],            marcas:[{c:3,tipo:'o'},{c:2,tipo:'o'},{c:1,tipo:'o'}] }},
    { nombre:'Gmaj7',  d:{ dedos:[{c:5,t:3},{c:0,t:2}],                     marcas:[{c:4,tipo:'x'},{c:3,tipo:'o'},{c:2,tipo:'o'},{c:1,tipo:'o'}] }},
    { nombre:'Gm7',    d:{ fret:3, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3}],                     marcas:[] }},
    { nombre:'Gsus2',  d:{ dedos:[{c:5,t:3},{c:4,t:0},{c:3,t:0},{c:2,t:0},{c:1,t:3},{c:0,t:3}], marcas:[] }},
    { nombre:'Gsus4',  d:{ dedos:[{c:5,t:3},{c:4,t:3},{c:0,t:3}],            marcas:[{c:3,tipo:'o'},{c:2,tipo:'o'},{c:1,tipo:'o'}] }},
    { nombre:'G/B',    d:{ dedos:[{c:4,t:2},{c:0,t:3}],                     marcas:[{c:5,tipo:'x'},{c:3,tipo:'o'},{c:2,tipo:'o'},{c:1,tipo:'o'}] }},
  ]},

  // ══ G# / Ab ══
  { key:'G#', alt:'Ab', acordes:[
    { nombre:'G#',     d:{ fret:4, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3},{c:3,t:3},{c:2,t:2}], marcas:[] }},
    { nombre:'G#m',    d:{ fret:4, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3},{c:3,t:3}],           marcas:[] }},
    { nombre:'Ab7',    d:{ fret:4, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3},{c:2,t:2}],           marcas:[] }},
    { nombre:'Abmaj7', d:{ fret:4, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:3,t:2},{c:2,t:2}],           marcas:[] }},
    { nombre:'G#m7',   d:{ fret:4, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3}],                     marcas:[] }},
    { nombre:'Ab',     d:{ fret:4, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3},{c:3,t:3},{c:2,t:2}], marcas:[] }},
    { nombre:'Absus4', d:{ fret:4, barre:{desde:0,hasta:5,traste:1},         dedos:[{c:4,t:3},{c:3,t:3},{c:2,t:3}], marcas:[] }},
  ]},

  // ══ A ══
  { key:'A', alt:null, acordes:[
    { nombre:'A',      d:{ dedos:[{c:3,t:2},{c:2,t:2},{c:1,t:2}],            marcas:[{c:5,tipo:'x'},{c:4,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Am',     d:{ dedos:[{c:3,t:2},{c:2,t:2},{c:1,t:1}],            marcas:[{c:5,tipo:'x'},{c:4,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'A7',     d:{ dedos:[{c:3,t:2},{c:1,t:2}],                     marcas:[{c:5,tipo:'x'},{c:4,tipo:'o'},{c:2,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Amaj7',  d:{ dedos:[{c:3,t:2},{c:2,t:1},{c:1,t:2}],            marcas:[{c:5,tipo:'x'},{c:4,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'An7',    d:{ dedos:[{c:3,t:2},{c:1,t:1}],                     marcas:[{c:5,tipo:'x'},{c:4,tipo:'o'},{c:2,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Asus2',  d:{ dedos:[{c:3,t:2},{c:2,t:2}],                     marcas:[{c:5,tipo:'x'},{c:4,tipo:'o'},{c:1,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'Asus4',  d:{ dedos:[{c:3,t:2},{c:2,t:2},{c:1,t:3}],            marcas:[{c:5,tipo:'x'},{c:4,tipo:'o'},{c:0,tipo:'o'}] }},
    { nombre:'A/C#',   d:{ dedos:[{c:4,t:4},{c:3,t:2},{c:2,t:2},{c:1,t:2}],  marcas:[{c:5,tipo:'x'},{c:0,tipo:'o'}] }},
  ]},

  // ══ A# / Bb ══
  { key:'A#', alt:'Bb', acordes:[
    { nombre:'A#',     d:{ fret:1, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:3}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'A#m',    d:{ fret:1, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:2}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'Bb7',    d:{ fret:1, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:1,t:3}],           marcas:[{c:5,tipo:'x'}] }},
    { nombre:'Bbmaj7', d:{ fret:1, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:2},{c:1,t:3}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'Bbm7',   d:{ fret:1, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3}],                     marcas:[{c:5,tipo:'x'}] }},
    { nombre:'Bb',     d:{ fret:1, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:3}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'Bbsus4', d:{ fret:1, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:4}], marcas:[{c:5,tipo:'x'}] }},
  ]},

  // ══ B ══
  { key:'B', alt:null, acordes:[
    { nombre:'B',      d:{ fret:2, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:3}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'Bm',     d:{ fret:2, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:2}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'B7',     d:{ dedos:[{c:4,t:2},{c:3,t:1},{c:2,t:2},{c:0,t:2}],  marcas:[{c:5,tipo:'x'},{c:1,tipo:'o'}] }},
    { nombre:'Bmaj7',  d:{ fret:2, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:2},{c:1,t:3}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'Bm7',    d:{ fret:2, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3}],                     marcas:[{c:5,tipo:'x'}] }},
    { nombre:'Bsus4',  d:{ fret:2, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:4}], marcas:[{c:5,tipo:'x'}] }},
    { nombre:'B/D#',   d:{ fret:6, barre:{desde:0,hasta:4,traste:1},         dedos:[{c:3,t:3},{c:2,t:3},{c:1,t:2}], marcas:[{c:5,tipo:'x'}] }},
  ]},
]
</script>

<style scoped>
.vista-acordes { max-width: 100%; padding: 0 0 80px; overflow-x: hidden; }

.pagina-header { max-width: 1200px; margin: 0 auto; padding: 110px 32px 36px; }
.header-supra {
  font-family: var(--font-display); font-size: 0.6rem;
  letter-spacing: 0.45em; text-transform: uppercase; color: var(--text-muted); margin-bottom: 10px;
}
.header-titulo {
  font-family: var(--font-display); font-size: clamp(2.4rem, 6vw, 3.8rem);
  font-weight: 700; color: var(--text-primary); letter-spacing: -0.01em; line-height: 1; margin-bottom: 10px;
}
.header-desc { font-size: 1rem; color: var(--text-muted); font-style: italic; }

.filas-notas { display: flex; flex-direction: column; }

.fila-nota {
  display: flex; align-items: stretch;
  border-top: 1px solid var(--border-faint);
  min-height: 120px;
}
.fila-nota:last-child { border-bottom: 1px solid var(--border-faint); }

.fila-label {
  flex-shrink: 0; width: 90px;
  display: flex; flex-direction: column; align-items: center; justify-content: center; gap: 3px;
  padding: 16px 8px;
  background: var(--bg-secondary);
  border-right: 1px solid var(--border-faint);
  position: sticky; left: 0; z-index: 2;
}
.fila-label-nota {
  font-family: var(--font-display); font-size: 1.5rem; font-weight: 800;
  color: var(--text-primary); line-height: 1;
}
.fila-label-alt {
  font-family: var(--font-display); font-size: 0.7rem; color: var(--text-muted); letter-spacing: 0.05em;
}

.fila-acordes-wrap {
  flex: 1; overflow-x: auto; overflow-y: hidden;
  scrollbar-width: thin; scrollbar-color: var(--gold-pale) transparent;
}
.fila-acordes-wrap::-webkit-scrollbar { height: 4px; }
.fila-acordes-wrap::-webkit-scrollbar-thumb { background: var(--gold-pale); border-radius: 2px; }

.fila-acordes {
  display: flex; align-items: center; gap: 0;
  padding: 12px 0; width: max-content;
}

.acorde-item {
  display: flex; flex-direction: column; align-items: center; gap: 4px;
  padding: 10px 14px; border-right: 1px solid var(--border-faint);
  transition: background 0.2s ease; cursor: default; min-width: 110px;
}
.acorde-item:hover { background: rgba(184,134,42,0.05); }

.acorde-nombre {
  font-family: var(--font-mono); font-size: 0.78rem; font-weight: 700;
  color: var(--gold-dark); letter-spacing: 0.03em; text-align: center; white-space: nowrap;
}
.acorde-svg { display: block; }

.fila-nota:nth-child(even) .fila-acordes-wrap { background: rgba(250,247,242,0.5); }
.fila-nota:nth-child(even) .fila-label { background: rgba(248,245,238,0.8); }

@media (max-width: 600px) {
  .fila-label { width: 60px; }
  .fila-label-nota { font-size: 1.1rem; }
  .acorde-item { padding: 8px 10px; min-width: 90px; }
}
</style>
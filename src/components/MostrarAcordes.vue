<template>
  <div class="mostrar-acordes">
    <div class="barra-transponer">
      <div class="trans-izq">
        <span class="trans-label">Tonalidad</span>
        <span class="trans-tono">{{ tonoActual }}</span>
        <span v-if="semitonos !== 0" class="trans-diff">{{ semitonos > 0 ? '+' : '' }}{{ semitonos }} st</span>
      </div>
      <div class="trans-btns">
        <button class="btn-trans" @click="transponer(-1)">♭ −1</button>
        <button class="btn-trans btn-reset" @click="resetar">↺</button>
        <button class="btn-trans" @click="transponer(1)">♯ +1</button>
      </div>
    </div>

    <div class="secciones">
      <div v-for="(seccion, si) in cancion.letra" :key="si" class="seccion" :class="seccion.tipo">

        <div class="seccion-etiqueta">
          <span class="etiqueta-linea"></span>{{ seccion.etiqueta }}
        </div>

        <!-- Sección solo de acordes (intro, interludio, solo, final sin letra) -->
        <div v-if="esSeccionAcordes(seccion)" class="bloque-solo-acordes">
          <div v-for="(linea, li) in seccion.lineas" :key="li" class="fila-solo">
            <span
              v-for="(token, ti) in parsearAcordes(linea.acordes)"
              :key="ti"
              :class="token.esAcorde ? 'acorde' : 'espacio'"
            >{{ token.esAcorde ? transponerAcorde(token.texto) : token.texto }}</span>
          </div>
        </div>

        <!-- Sección normal con letra -->
        <div v-else class="lineas">
          <div v-for="(linea, li) in seccion.lineas" :key="li" class="bloque-linea">
            <div class="fila-acordes" v-if="linea.acordes && linea.acordes.trim()">
              <span
                v-for="(token, ti) in parsearAcordes(linea.acordes)"
                :key="ti"
                :class="token.esAcorde ? 'acorde' : 'espacio'"
              >{{ token.esAcorde ? transponerAcorde(token.texto) : token.texto }}</span>
            </div>
            <div class="fila-letra" v-if="linea.texto">{{ linea.texto }}</div>
          </div>
        </div>

      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
const props = defineProps({ cancion: { type: Object, required: true } })

const NOTAS   = ['C','C#','D','D#','E','F','F#','G','G#','A','A#','B']
const ALIASES = { Db:'C#',Eb:'D#',Fb:'E',Gb:'F#',Ab:'G#',Bb:'A#',Cb:'B','D#/G':'D#' }

const semitonos  = ref(0)
const tonoActual = computed(() => transponerAcorde(props.cancion.tono))

function transponer(n) { semitonos.value += n }
function resetar()     { semitonos.value = 0 }

function transponerAcorde(a) {
  if (!a) return a
  return a.replace(/[A-G][b#]?/g, m => {
    const norm = ALIASES[m] || m
    const idx  = NOTAS.indexOf(norm)
    if (idx === -1) return m
    return NOTAS[((idx + semitonos.value) % 12 + 12) % 12]
  })
}

function parsearAcordes(linea) {
  if (!linea) return []
  const tokens = []; let actual = '', i = 0
  while (i < linea.length) {
    if (linea[i] === ' ') {
      if (actual) { tokens.push({ texto: actual, esAcorde: true }); actual = '' }
      let esp = ''
      while (i < linea.length && linea[i] === ' ') { esp += ' '; i++ }
      tokens.push({ texto: esp, esAcorde: false })
    } else { actual += linea[i]; i++ }
  }
  if (actual) tokens.push({ texto: actual, esAcorde: true })
  return tokens
}

// Una sección es "solo acordes" si todas sus líneas tienen texto vacío
function esSeccionAcordes(seccion) {
  return seccion.lineas.every(l => !l.texto || l.texto.trim() === '')
}
</script>

<style scoped>
.mostrar-acordes { display: flex; flex-direction: column; gap: 32px; }

.barra-transponer {
  display: flex; align-items: center; justify-content: space-between;
  flex-wrap: wrap; gap: 14px;
  background: var(--bg-secondary); border: 1px solid var(--border-card);
  border-radius: var(--radius-md); padding: 14px 22px;
  box-shadow: 0 1px 6px rgba(90,64,32,0.06);
}
.trans-izq { display: flex; align-items: center; gap: 14px; }
.trans-label {
  font-family: var(--font-display); font-size: 0.6rem;
  letter-spacing: 0.25em; text-transform: uppercase; color: var(--text-muted);
}
.trans-tono {
  font-family: var(--font-mono); font-size: 1.3rem;
  color: var(--gold-dark); font-weight: 600; min-width: 30px;
}
.trans-diff {
  font-family: var(--font-mono); font-size: 0.72rem;
  color: var(--gold-primary); background: rgba(184,134,42,0.1);
  padding: 2px 8px; border-radius: var(--radius-xs);
}
.trans-btns { display: flex; gap: 8px; }
.btn-trans {
  font-family: var(--font-mono); font-size: 0.72rem;
  color: var(--text-secondary); background: var(--bg-card);
  border: 1px solid var(--border-card); padding: 7px 14px;
  border-radius: var(--radius-sm); transition: var(--transition);
}
.btn-trans:hover {
  background: rgba(184,134,42,0.1); border-color: var(--gold-primary); color: var(--gold-dark);
}
.btn-reset { color: var(--text-muted); }

.secciones { display: flex; flex-direction: column; gap: 28px; }

.seccion {
  padding-left: 18px; border-left: 2px solid var(--border-subtle);
}
.seccion.coro {
  border-left-color: var(--gold-primary);
  background: rgba(184,134,42,0.03);
  border-radius: 0 var(--radius-sm) var(--radius-sm) 0;
  padding: 14px 14px 14px 18px;
}
.seccion.puente {
  border-left-color: var(--gold-dark);
  background: rgba(122,85,16,0.03);
  border-radius: 0 var(--radius-sm) var(--radius-sm) 0;
  padding: 14px 14px 14px 18px;
}
.seccion.intro {
  border-left-color: var(--border-card);
  background: rgba(90,64,32,0.03);
  border-radius: 0 var(--radius-sm) var(--radius-sm) 0;
  padding: 12px 14px 12px 18px;
}

.seccion-etiqueta {
  display: flex; align-items: center; gap: 10px;
  font-family: var(--font-display); font-size: 0.58rem;
  letter-spacing: 0.3em; text-transform: uppercase;
  color: var(--text-muted); margin-bottom: 12px;
}
.seccion.coro   .seccion-etiqueta { color: var(--gold-dark); }
.seccion.puente .seccion-etiqueta { color: var(--gold-dark); }
.seccion.intro  .seccion-etiqueta { color: var(--text-faint); }
.etiqueta-linea { display: inline-block; width: 20px; height: 1px; background: currentColor; opacity: 0.5; }

/* Sección solo acordes (intro, interludio, etc.) */
.bloque-solo-acordes {
  display: flex; flex-direction: column; gap: 6px;
}
.fila-solo {
  font-family: var(--font-mono); font-size: 0.85rem;
  white-space: pre; color: var(--text-secondary);
  background: rgba(184,134,42,0.05);
  border: 1px solid var(--border-faint);
  border-radius: var(--radius-xs);
  padding: 6px 12px; display: inline-block;
}
.fila-solo .acorde  { color: var(--gold-dark); font-weight: 500; }
.fila-solo .espacio { color: transparent; white-space: pre; }

/* Secciones con letra */
.lineas { display: flex; flex-direction: column; gap: 6px; }
.bloque-linea { margin-bottom: 8px; }
.fila-acordes {
  font-family: var(--font-mono); font-size: 0.82rem;
  white-space: pre; line-height: 1.4; margin-bottom: 2px;
}
.acorde  { color: var(--gold-dark); font-weight: 500; }
.espacio { color: transparent; white-space: pre; }
.fila-letra { font-family: var(--font-body); font-size: 1.12rem; color: var(--text-primary); line-height: 1.5; }

@media (max-width: 600px) {
  .fila-acordes { font-size: 0.7rem; }
  .fila-letra   { font-size: 1rem; }
  .fila-solo    { font-size: 0.72rem; }
}
</style>
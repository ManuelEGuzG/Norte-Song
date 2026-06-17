<template>
  <div class="presentacion" ref="contenedor" tabindex="0" @click="manejarClic">

    <div class="pres-fondo" aria-hidden="true">
      <div class="pres-orb"></div>
    </div>

    <!-- Encabezado -->
    <div class="pres-encabezado">
      <div class="pres-logo-wrap">
        <img :src="logoIglesia" alt="Iglesia del Norte" class="pres-logo" />
      </div>
      <span class="pres-iglesia">Iglesia del Norte</span>
      <span class="pres-sep">·</span>
      <span class="pres-nombre">{{ cancion?.titulo }}</span>
      <button class="btn-toggle-acordes" :class="{ activo: mostrarAcordes }" @click.stop="mostrarAcordes = !mostrarAcordes">
        <span class="toggle-icono">♪</span>
        <span>{{ mostrarAcordes ? 'Acordes ON' : 'Acordes OFF' }}</span>
      </button>

      <!-- Control tamaño -->
      <div class="ctrl-tamano">
        <button class="btn-tamano" @click.stop="achicar"  :disabled="tamanoLetra <= 1.5">A−</button>
        <span class="tamano-val">{{ tamanoLetra }}vw</span>
        <button class="btn-tamano" @click.stop="agrandar" :disabled="tamanoLetra >= 5.6">A+</button>
      </div>
    </div>

    <!-- Bloque actual -->
    <transition name="trans-bloque" mode="out-in">
      <div class="pres-bloque" :key="indiceActual" v-if="bloques.length">
        <p class="pres-etiqueta">{{ bloques[indiceActual]?.etiqueta }}</p>

        <div v-if="bloques[indiceActual]?.esSoloAcordes" class="pres-solo-acordes">
          <div v-for="(linea, i) in bloques[indiceActual]?.lineas" :key="i" class="pres-acorde-solo">
            {{ linea.acordes }}
          </div>
        </div>

        <div v-else class="pres-lineas">
          <template v-for="(linea, i) in bloques[indiceActual]?.lineas" :key="i">
            <div v-if="mostrarAcordes && linea.acordes && linea.acordes.trim()" class="pres-acordes-linea">
              {{ linea.acordes }}
            </div>
            <p v-if="linea.texto && linea.texto.trim()" class="pres-linea" :style="{ fontSize: tamanoLetra + 'vw', animationDelay: `${i * 0.05}s` }">
              {{ linea.texto }}
            </p>
          </template>
        </div>
      </div>
    </transition>

    <!-- ── Preview del siguiente bloque ── -->
    <div
      class="pres-preview"
      v-if="bloquesSiguiente && indiceActual < bloques.length - 1"
      @click.stop="siguiente"
    >
      <div class="preview-label">A continuación · {{ bloquesSiguiente.etiqueta }}</div>
      <div v-if="bloquesSiguiente.esSoloAcordes" class="preview-acordes-solo">
        {{ bloquesSiguiente.lineas.map(l => l.acordes).join('  ') }}
      </div>
      <div v-else class="preview-lineas">
        <span
          v-for="(linea, i) in bloquesSiguiente.lineas"
          :key="i"
          class="preview-linea"
        >{{ linea.texto }}</span>
      </div>
    </div>


    <!-- Navegación -->
    <div class="pres-nav">
      <button class="pres-flecha" @click.stop="anterior" :disabled="indiceActual === 0">‹</button>
      <div class="pres-puntos">
        <span
          v-for="(_, i) in bloques" :key="i"
          class="punto" :class="{ activo: i === indiceActual }"
          @click.stop="indiceActual = i"
        />
      </div>
      <button class="pres-flecha" @click.stop="siguiente" :disabled="indiceActual === bloques.length - 1">›</button>
    </div>

    <!-- Hint -->
    <div class="pres-hint">
      <span>→ avanzar · + / − tamaño letra</span>
      <span class="sep">|</span>
      <router-link :to="`/cancion/${idCancion}`" class="pres-salir" @click.stop>✕ Salir</router-link>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { useRoute } from 'vue-router'
import logoIglesia from '@/assets/logo/logo-iglesia.png'

const route          = useRoute()
const idCancion      = route.params.id
const cancion        = ref(null)
const indiceActual   = ref(0)
const contenedor     = ref(null)
const mostrarAcordes = ref(false)
const LINEAS         = 4
const tamanoLetra    = ref(3.2)
const TAMANO_MIN     = 1.5
const TAMANO_MAX     = 5.6
const TAMANO_PASO    = 0.4

function agrandar() { if (tamanoLetra.value < TAMANO_MAX) tamanoLetra.value = Math.round((tamanoLetra.value + TAMANO_PASO) * 10) / 10 }
function achicar()  { if (tamanoLetra.value > TAMANO_MIN) tamanoLetra.value = Math.round((tamanoLetra.value - TAMANO_PASO) * 10) / 10 }

onMounted(async () => {
  const res = await fetch(import.meta.env.BASE_URL + 'canciones.json')
  const todas = await res.json()
  cancion.value = todas.find(c => c.id === parseInt(idCancion))
  contenedor.value?.focus()
  window.addEventListener('keydown', alTecla)
  // Entrar a pantalla completa
  try {
    await document.documentElement.requestFullscreen()
  } catch (e) {
    console.warn('Pantalla completa no disponible:', e)
  }
})
onUnmounted(() => {
  window.removeEventListener('keydown', alTecla)
  // Salir de pantalla completa al salir de la presentación
  if (document.fullscreenElement) {
    document.exitFullscreen().catch(() => {})
  }
})

const bloques = computed(() => {
  if (!cancion.value) return []
  const resultado = []
  for (const seccion of cancion.value.letra) {
    const esSoloAcordes = seccion.lineas.every(l => !l.texto || l.texto.trim() === '')
    if (esSoloAcordes) {
      resultado.push({
        etiqueta: seccion.etiqueta,
        esSoloAcordes: true,
        lineas: seccion.lineas.filter(l => l.acordes && l.acordes.trim())
      })
    } else {
      const lineasConTexto = seccion.lineas.filter(l => l.texto && l.texto.trim())
      for (let i = 0; i < lineasConTexto.length; i += LINEAS) {
        resultado.push({
          etiqueta: seccion.etiqueta,
          esSoloAcordes: false,
          lineas: lineasConTexto.slice(i, i + LINEAS)
        })
      }
    }
  }
  return resultado
})

const bloquesSiguiente = computed(() => {
  const sig = indiceActual.value + 1
  return sig < bloques.value.length ? bloques.value[sig] : null
})

function siguiente() { if (indiceActual.value < bloques.value.length - 1) indiceActual.value++ }
function anterior()  { if (indiceActual.value > 0) indiceActual.value-- }
function manejarClic() { siguiente() }


function alTecla(e) {
  if (['ArrowRight','ArrowDown','PageDown',' '].includes(e.key)) { e.preventDefault(); siguiente() }
  if (['ArrowLeft','ArrowUp','PageUp'].includes(e.key))          { e.preventDefault(); anterior() }
  if (e.key === 'Escape') window.history.back()
  if (e.key === 'a' || e.key === 'A') mostrarAcordes.value = !mostrarAcordes.value
  if (e.key === '+' || e.key === '=') { e.preventDefault(); agrandar() }
  if (e.key === '-' || e.key === '_') { e.preventDefault(); achicar() }
}
</script>

<style scoped>
.presentacion {
  position: fixed; inset: 0; background: #ffffff;
  display: flex; flex-direction: column; align-items: center; justify-content: center;
  cursor: pointer; user-select: none; outline: none;
  padding: 80px 60px 100px; overflow: hidden;
}

.pres-fondo { position: absolute; inset: 0; pointer-events: none; }
.pres-orb {
  position: absolute; top: 50%; left: 50%; transform: translate(-50%,-50%);
  width: 500px; height: 500px;
  background: radial-gradient(ellipse, rgba(184,134,42,0.04) 0%, transparent 70%);
  border-radius: 50%;
}

/* Encabezado */
.pres-encabezado {
  position: absolute; top: 22px; left: 50%; transform: translateX(-50%);
  display: flex; align-items: center; gap: 12px; white-space: nowrap;
}
.pres-logo-wrap { width: 30px; height: 30px; display: flex; align-items: center; justify-content: center; }
.pres-logo { width: 100%; height: 100%; object-fit: contain; filter: invert(1) brightness(0.1); }
.pres-iglesia { font-family: var(--font-display); font-size: 0.58rem; letter-spacing: 0.35em; text-transform: uppercase; color: #b8a07a; }
.pres-sep { color: #d4c0a0; }
.pres-nombre { font-family: var(--font-display); font-size: 0.58rem; letter-spacing: 0.2em; text-transform: uppercase; color: #c8b090; }

.btn-toggle-acordes {
  display: flex; align-items: center; gap: 5px;
  font-family: var(--font-display); font-size: 0.52rem; letter-spacing: 0.15em; text-transform: uppercase;
  color: #c8b090; background: rgba(184,134,42,0.06); border: 1px solid rgba(184,134,42,0.15);
  padding: 4px 10px; border-radius: 20px; cursor: pointer; transition: all 0.25s; margin-left: 8px;
}
.btn-toggle-acordes:hover { color: #b8862a; border-color: rgba(184,134,42,0.4); background: rgba(184,134,42,0.1); }
.btn-toggle-acordes.activo { color: #7a5510; border-color: #b8862a; background: rgba(184,134,42,0.15); }
.toggle-icono { font-size: 0.7rem; }

.ctrl-tamano {
  display: flex; align-items: center; gap: 2px;
  margin-left: 8px;
  background: rgba(184,134,42,0.06);
  border: 1px solid rgba(184,134,42,0.15);
  border-radius: 20px; padding: 2px 4px;
}
.btn-tamano {
  font-family: var(--font-display); font-size: 0.62rem; font-weight: 700;
  color: #c8b090; background: none; border: none;
  padding: 3px 8px; border-radius: 16px;
  cursor: pointer; transition: all 0.2s; line-height: 1;
}
.btn-tamano:hover:not(:disabled) { color: #b8862a; background: rgba(184,134,42,0.12); }
.btn-tamano:disabled { opacity: 0.3; cursor: default; }
.tamano-val {
  font-family: var(--font-mono); font-size: 0.48rem;
  color: #b8a07a; min-width: 34px; text-align: center;
}

/* Bloque principal */
.pres-bloque {
  flex: 1; display: flex; flex-direction: column;
  align-items: center; justify-content: center;
  text-align: center; max-width: 1100px; width: 100%;
}
.pres-etiqueta {
  font-family: var(--font-display); font-size: 0.52rem;
  letter-spacing: 0.4em; text-transform: uppercase; color: #c8a870; margin-bottom: 28px;
}

.pres-solo-acordes { display: flex; flex-direction: column; gap: 10px; align-items: center; }
.pres-acorde-solo {
  font-family: var(--font-mono); font-size: clamp(1.2rem, 2.5vw, 2rem);
  color: #b8862a; font-weight: 600; letter-spacing: 0.08em;
  background: rgba(184,134,42,0.06); border: 1px solid rgba(184,134,42,0.15);
  padding: 8px 24px; border-radius: 8px;
}

.pres-lineas { display: flex; flex-direction: column; gap: 4px; align-items: center; }
.pres-acordes-linea {
  font-family: var(--font-mono); font-size: clamp(0.75rem, 1.4vw, 1.1rem);
  color: #b8862a; font-weight: 600; white-space: pre; line-height: 1.2;
  margin-bottom: 0; margin-top: 10px; letter-spacing: 0.04em;
}
.pres-linea {
  font-family: var(--font-body); font-size: 3.2vw;
  font-weight: 500; color: #1a1208; line-height: 1.3;
  animation: fadeInUp 0.4s ease both; margin-bottom: 2px;
  transition: font-size 0.15s ease;
}

/* ── Preview del siguiente bloque ── */
.pres-preview {
  position: absolute;
  bottom: 80px;
  right: 32px;
  width: 240px;
  background: rgba(250, 247, 242, 0.92);
  border: 1px solid rgba(184,134,42,0.2);
  border-radius: 12px;
  padding: 12px 14px;
  cursor: pointer;
  transition: all 0.25s ease;
  backdrop-filter: blur(8px);
  box-shadow: 0 4px 20px rgba(90,64,32,0.08);
}
.pres-preview:hover {
  border-color: rgba(184,134,42,0.45);
  background: rgba(250, 247, 242, 1);
  transform: translateY(-2px);
  box-shadow: 0 6px 24px rgba(90,64,32,0.14);
}

.preview-label {
  font-family: var(--font-display);
  font-size: 0.5rem;
  letter-spacing: 0.22em;
  text-transform: uppercase;
  color: #b8862a;
  margin-bottom: 8px;
  padding-bottom: 6px;
  border-bottom: 1px solid rgba(184,134,42,0.15);
}

.preview-acordes-solo {
  font-family: var(--font-mono);
  font-size: 0.72rem;
  color: #b8862a;
  font-weight: 600;
  letter-spacing: 0.06em;
}

.preview-lineas {
  display: flex;
  flex-direction: column;
  gap: 3px;
}
.preview-linea {
  font-family: var(--font-body);
  font-size: 0.82rem;
  color: #5a4020;
  line-height: 1.35;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.preview-mas {
  font-family: var(--font-display);
  font-size: 0.6rem;
  color: #c8a870;
  letter-spacing: 0.1em;
  margin-top: 2px;
}

/* Navegación */
.pres-nav {
  position: absolute; bottom: 50px; left: 50%; transform: translateX(-50%);
  display: flex; align-items: center; gap: 24px;
}
.pres-flecha {
  font-size: 2.2rem; color: #d4c0a0; background: none; border: none;
  padding: 8px 16px; cursor: pointer; transition: color 0.25s; font-family: sans-serif; line-height: 1;
}
.pres-flecha:hover:not(:disabled) { color: var(--gold-primary); }
.pres-flecha:disabled { opacity: 0.2; cursor: default; }
.pres-puntos { display: flex; gap: 7px; flex-wrap: wrap; justify-content: center; max-width: 320px; }
.punto { width: 7px; height: 7px; border-radius: 50%; background: #e0d0b0; cursor: pointer; transition: all 0.25s; }
.punto.activo { background: var(--gold-primary); transform: scale(1.35); box-shadow: 0 0 8px rgba(184,134,42,0.4); }

/* Hint */
.pres-hint {
  position: absolute; bottom: 14px; left: 50%; transform: translateX(-50%);
  display: flex; align-items: center; gap: 10px;
  font-family: var(--font-display); font-size: 0.5rem;
  letter-spacing: 0.15em; text-transform: uppercase; color: #d4c0a0; white-space: nowrap;
}
.sep { opacity: 0.5; }
.pres-salir { color: var(--gold-primary); transition: color 0.25s; }
.pres-salir:hover { color: var(--gold-dark); }

/* Transición */
.trans-bloque-enter-active, .trans-bloque-leave-active { transition: all 0.3s ease; }
.trans-bloque-enter-from { opacity: 0; transform: translateY(20px); }
.trans-bloque-leave-to   { opacity: 0; transform: translateY(-20px); }

@media (max-width: 600px) {
  .presentacion { padding: 80px 20px 100px; }
  .pres-linea   { font-size: clamp(1.3rem, 5.5vw, 2rem); }
  .pres-hint    { display: none; }
  .pres-preview { display: none; }
  .pres-encabezado { gap: 6px; }
  .pres-sep, .pres-nombre { display: none; }
}
</style>
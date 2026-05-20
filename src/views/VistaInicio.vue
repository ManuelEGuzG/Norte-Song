<template>
  <div class="inicio">

    <!-- ══ HERO ══ -->
    <section class="hero">
      <div class="hero-fondo" aria-hidden="true">
        <svg class="svg-fondo" viewBox="0 0 1200 700" preserveAspectRatio="xMidYMid slice">
          <defs>
            <radialGradient id="grad1" cx="70%" cy="40%" r="60%">
              <stop offset="0%" stop-color="#d4a843" stop-opacity="0.18"/>
              <stop offset="100%" stop-color="#d4a843" stop-opacity="0"/>
            </radialGradient>
            <radialGradient id="grad2" cx="85%" cy="70%" r="50%">
              <stop offset="0%" stop-color="#9a7420" stop-opacity="0.12"/>
              <stop offset="100%" stop-color="#9a7420" stop-opacity="0"/>
            </radialGradient>
          </defs>
          <path class="forma1" d="M 750 -80 C 950 -60 1250 120 1220 320 C 1190 520 980 680 820 660 C 660 640 520 480 560 320 C 600 160 550 -100 750 -80 Z"/>
          <path class="forma2" d="M 850 80 C 1050 60 1250 220 1200 400 C 1150 580 950 680 800 640 C 650 600 600 460 660 320 C 720 180 650 100 850 80 Z"/>
          <rect width="1200" height="700" fill="url(#grad1)"/>
          <rect width="1200" height="700" fill="url(#grad2)"/>
          <circle cx="580" cy="580" r="4" class="punto-deco"/>
          <circle cx="610" cy="580" r="4" class="punto-deco"/>
          <circle cx="640" cy="580" r="4" class="punto-deco"/>
          <circle cx="670" cy="580" r="4" class="punto-deco"/>
          <circle cx="700" cy="580" r="4" class="punto-deco"/>
        </svg>
      </div>

      <div class="hero-inner">
        <div class="hero-izq">
          <p class="hero-supra fade-in">Iglesia del Norte</p>
          <h1 class="hero-titulo fade-in-2">
            <span class="titulo-linea1">Cancionero</span>
            <span class="titulo-linea2">Musical</span>
          </h1>
          <p class="hero-desc fade-in-3">
            Letras y acordes para músicos y cantantes de la Iglesia del Norte.
            Transpone tonalidades, modo presentación y más.
          </p>
          <div class="hero-acciones fade-in-4">
            <router-link to="/canciones" class="btn-primario">
              Ver Canciones <span class="btn-flecha">→</span>
            </router-link>
          </div>
          <div class="scroll-ind fade-in-5">
            <span class="scroll-linea"></span>
            <span class="scroll-texto">scroll</span>
          </div>
        </div>

        <div class="hero-der fade-in-3">
          <div class="telefono-wrap">
            <div class="telefono">
              <div class="tel-notch"></div>
              <div class="tel-pantalla">
                <div class="app-preview">
                  <div class="prev-header">
                    <img :src="logoIglesia" class="prev-logo" alt="logo"/>
                    <span class="prev-nombre">Norte Songs</span>
                  </div>
                  <div class="prev-cancion" v-for="c in previewCanciones" :key="c.id">
                    <div class="prev-info">
                      <span class="prev-titulo">{{ c.titulo }}</span>
                      <span class="prev-artista">{{ c.artista }}</span>
                    </div>
                    <span class="prev-tono">{{ c.tono }}</span>
                  </div>
                </div>
              </div>
            </div>
            <canvas ref="canvas" class="canvas-part"></canvas>
          </div>
        </div>
      </div>
    </section>

    <!-- ══ STATS ══ -->
    <section class="estadisticas fade-in-4">
      <div class="stats-inner">
        <div class="stat">
          <span class="stat-num">{{ totalCanciones }}</span>
          <span class="stat-label">Canciones</span>
        </div>
        <div class="stat-sep"></div>
        <div class="stat">
          <span class="stat-num">{{ totalGeneros }}</span>
          <span class="stat-label">Géneros</span>
        </div>
        <div class="stat-sep"></div>
        <div class="stat">
          <span class="stat-num">{{ totalArtistas }}</span>
          <span class="stat-label">Artistas</span>
        </div>
        <div class="stat-sep"></div>
        <div class="stat">
          <span class="stat-num">{{ totalTonos }}</span>
          <span class="stat-label">Tonalidades</span>
        </div>
      </div>
    </section>

    <!-- ══ CANCIONES DESTACADAS ══ -->
    <section class="seccion-destacadas">
      <div class="seccion-inner">
        <div class="seccion-header">
          <div>
            <p class="seccion-supra">Repertorio</p>
            <h2 class="seccion-titulo">Canciones Destacadas</h2>
          </div>
          <router-link to="/canciones" class="btn-ver-todo">Ver todas →</router-link>
        </div>
        <div class="grilla-destacadas">
          <router-link
            v-for="cancion in cancionesDestacadas"
            :key="cancion.id"
            :to="`/cancion/${cancion.id}`"
            class="card-dest"
          >
            <div class="card-dest-img">
              <img
                v-if="cancion.imagen"
                :src="cancion.imagen"
                :alt="cancion.titulo"
                loading="lazy"
                @error="e => e.target.style.display='none'"
              />
              <div class="card-dest-placeholder" v-else>♪</div>
              <span class="card-dest-genero">{{ cancion.genero }}</span>
            </div>
            <div class="card-dest-info">
              <span class="card-dest-tono">{{ cancion.tono }}</span>
              <h3 class="card-dest-titulo">{{ cancion.titulo }}</h3>
              <p class="card-dest-artista">{{ cancion.artista }}</p>
            </div>
          </router-link>
        </div>
      </div>
    </section>

    <!-- ══ ESTADÍSTICAS POR GÉNERO Y TONO ══ -->
    <section class="seccion-graficas">
      <div class="seccion-inner">
        <div class="seccion-header">
          <div>
            <p class="seccion-supra">Análisis</p>
            <h2 class="seccion-titulo">Distribución del Repertorio</h2>
          </div>
        </div>

        <div class="graficas-grid">

          <!-- Gráfica de géneros -->
          <div class="grafica-card">
            <h3 class="grafica-titulo">Por Género</h3>
            <div class="barras">
              <div v-for="item in porGenero" :key="item.nombre" class="barra-wrap">
                <div class="barra-label-row">
                  <span class="barra-nombre">{{ item.nombre }}</span>
                  <span class="barra-count">{{ item.total }}</span>
                </div>
                <div class="barra-track">
                  <div
                    class="barra-fill"
                    :style="{ width: (item.total / totalCanciones * 100) + '%' }"
                  ></div>
                </div>
              </div>
            </div>
          </div>

          <!-- Gráfica de tonos -->
          <div class="grafica-card">
            <h3 class="grafica-titulo">Tonos más usados</h3>
            <div class="barras">
              <div v-for="item in tonosMasUsados" :key="item.tono" class="barra-wrap">
                <div class="barra-label-row">
                  <span class="barra-nombre">{{ item.tono }}</span>
                  <span class="barra-count">{{ item.total }}</span>
                </div>
                <div class="barra-track">
                  <div
                    class="barra-fill barra-tono"
                    :style="{ width: (item.total / tonosMasUsados[0].total * 100) + '%' }"
                  ></div>
                </div>
              </div>
            </div>
          </div>

        </div>
      </div>
    </section>

  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue'
import logoIglesia from '@/assets/logo/logo-iglesia.png'

const canciones = ref([])
const canvas    = ref(null)
let animId      = null

onMounted(async () => {
  const res = await fetch('/canciones.json')
  canciones.value = await res.json()
  iniciarCanvas()
})
onUnmounted(() => { if (animId) cancelAnimationFrame(animId) })

// ── Computed ──
const totalCanciones  = computed(() => canciones.value.length)
const totalGeneros    = computed(() => new Set(canciones.value.map(c => c.genero)).size)
const totalArtistas   = computed(() => new Set(canciones.value.map(c => c.artista)).size)
const totalTonos      = computed(() => new Set(canciones.value.map(c => c.tono)).size)
const previewCanciones = computed(() => canciones.value.slice(0, 4))

// Canciones destacadas — las últimas 4 agregadas
const cancionesDestacadas = computed(() =>
  [...canciones.value].slice(-4).reverse()
)

// Por género
const porGenero = computed(() => {
  const conteo = {}
  canciones.value.forEach(c => {
    conteo[c.genero] = (conteo[c.genero] || 0) + 1
  })
  return Object.entries(conteo)
    .map(([nombre, total]) => ({ nombre, total }))
    .sort((a, b) => b.total - a.total)
})

// Tonos más usados (top 6)
const tonosMasUsados = computed(() => {
  const conteo = {}
  canciones.value.forEach(c => {
    conteo[c.tono] = (conteo[c.tono] || 0) + 1
  })
  return Object.entries(conteo)
    .map(([tono, total]) => ({ tono, total }))
    .sort((a, b) => b.total - a.total)
    .slice(0, 6)
})

// ── Canvas de partículas ──
function iniciarCanvas() {
  const c = canvas.value
  if (!c) return
  const ctx = c.getContext('2d')
  const W = c.offsetWidth; const H = c.offsetHeight
  c.width = W; c.height = H
  const N = 120
  const pts = Array.from({ length: N }, () => {
    const ang = Math.random() * Math.PI * 2
    const r   = 160 + Math.random() * 120
    return {
      x: W/2 + Math.cos(ang)*r, y: H/2 + Math.sin(ang)*r*0.9,
      ox: W/2 + Math.cos(ang)*r, oy: H/2 + Math.sin(ang)*r*0.9,
      r: Math.random()*2+0.8, fase: Math.random()*Math.PI*2,
      alfa: Math.random()*0.4+0.15
    }
  })
  let t = 0
  function draw() {
    ctx.clearRect(0,0,W,H)
    t += 0.007
    pts.forEach(p => {
      p.x = p.ox + Math.sin(t+p.fase)*16
      p.y = p.oy + Math.cos(t+p.fase*1.2)*10
    })
    for (let i=0;i<N;i++) {
      for (let j=i+1;j<N;j++) {
        const dx=pts[i].x-pts[j].x, dy=pts[i].y-pts[j].y
        const d=Math.sqrt(dx*dx+dy*dy)
        if (d<60) {
          ctx.beginPath()
          ctx.strokeStyle=`rgba(184,134,42,${0.15*(1-d/60)})`
          ctx.lineWidth=0.5
          ctx.moveTo(pts[i].x,pts[i].y)
          ctx.lineTo(pts[j].x,pts[j].y)
          ctx.stroke()
        }
      }
    }
    pts.forEach(p => {
      ctx.beginPath()
      ctx.arc(p.x,p.y,p.r,0,Math.PI*2)
      ctx.fillStyle=`rgba(184,134,42,${p.alfa})`
      ctx.fill()
    })
    animId = requestAnimationFrame(draw)
  }
  draw()
}
</script>

<style scoped>
.inicio { min-height: 100vh; background: #ffffff; overflow-x: hidden; }

/* ── Hero ── */
.hero { position: relative; min-height: 100vh; display: flex; align-items: stretch; }
.hero-fondo { position: absolute; inset: 0; z-index: 0; overflow: hidden; }
.svg-fondo { width: 100%; height: 100%; }
.forma1 { fill: rgba(184,134,42,0.09); animation: morphear1 10s ease-in-out infinite alternate; }
.forma2 { fill: rgba(184,134,42,0.06); animation: morphear2 13s ease-in-out infinite alternate; }
.punto-deco { fill: rgba(184,134,42,0.3); }

@keyframes morphear1 {
  0%   { d: path("M 750 -80 C 950 -60 1250 120 1220 320 C 1190 520 980 680 820 660 C 660 640 520 480 560 320 C 600 160 550 -100 750 -80 Z"); }
  100% { d: path("M 800 -40 C 1020 20 1280 180 1230 380 C 1180 560 960 700 780 650 C 600 600 500 440 560 280 C 620 120 580 -100 800 -40 Z"); }
}
@keyframes morphear2 {
  0%   { d: path("M 850 80 C 1050 60 1250 220 1200 400 C 1150 580 950 680 800 640 C 650 600 600 460 660 320 C 720 180 650 100 850 80 Z"); }
  100% { d: path("M 900 40 C 1100 80 1260 260 1180 440 C 1100 620 880 700 720 640 C 560 580 560 420 640 280 C 720 140 700 0 900 40 Z"); }
}

.hero-inner {
  position: relative; z-index: 1;
  max-width: 1200px; margin: 0 auto; width: 100%;
  display: grid; grid-template-columns: 1fr 1fr;
  align-items: center; padding: 120px 48px 80px; gap: 40px;
}
.hero-izq { display: flex; flex-direction: column; gap: 24px; }
.hero-supra { font-family: var(--font-display); font-size: 0.65rem; letter-spacing: 0.5em; text-transform: uppercase; color: var(--gold-dark); }
.hero-titulo { display: flex; flex-direction: column; line-height: 1; font-family: var(--font-display); font-weight: 900; }
.titulo-linea1 { font-size: clamp(2.4rem, 4.5vw, 4.2rem); color: var(--text-primary); letter-spacing: -0.02em; }
.titulo-linea2 { font-size: clamp(3rem, 5.5vw, 5.5rem); color: var(--gold-primary); font-style: italic; letter-spacing: -0.02em; margin-top: -4px; }
.hero-desc { font-family: var(--font-body); font-size: 1.1rem; color: var(--text-secondary); line-height: 1.75; max-width: 400px; }
.hero-acciones { display: flex; gap: 14px; flex-wrap: wrap; }
.btn-primario {
  display: inline-flex; align-items: center; gap: 12px;
  background: linear-gradient(135deg, var(--gold-dark), var(--gold-primary));
  color: #ffffff; font-family: var(--font-display); font-size: 0.7rem;
  font-weight: 700; letter-spacing: 0.22em; text-transform: uppercase;
  padding: 15px 36px; border-radius: var(--radius-xl); transition: var(--transition);
  box-shadow: 0 4px 24px rgba(184,134,42,0.4);
}
.btn-primario:hover { transform: translateY(-3px); box-shadow: 0 10px 40px rgba(184,134,42,0.55); }
.btn-flecha { transition: transform 0.3s; }
.btn-primario:hover .btn-flecha { transform: translateX(5px); }
.scroll-ind { display: flex; align-items: center; gap: 10px; margin-top: 8px; }
.scroll-linea { display: block; width: 1px; height: 40px; background: linear-gradient(180deg, var(--gold-primary), transparent); animation: scrollAnim 2s ease-in-out infinite; }
@keyframes scrollAnim { 0%,100% { height: 40px; opacity: 1; } 50% { height: 20px; opacity: 0.4; } }
.scroll-texto { font-family: var(--font-display); font-size: 0.55rem; letter-spacing: 0.35em; text-transform: uppercase; color: var(--text-muted); writing-mode: vertical-rl; }

/* Teléfono */
.hero-der { display: flex; align-items: center; justify-content: center; height: 580px; }
.telefono-wrap { position: relative; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; }
.canvas-part { position: absolute; inset: 0; width: 100%; height: 100%; pointer-events: none; }
.telefono {
  position: relative; z-index: 2; width: 220px;
  background: #ffffff; border-radius: 36px;
  border: 1px solid rgba(184,134,42,0.2);
  box-shadow: 0 30px 80px rgba(90,64,32,0.18), 0 8px 24px rgba(90,64,32,0.1), 0 0 0 8px rgba(184,134,42,0.06);
  overflow: hidden; animation: flotarTel 4s ease-in-out infinite;
}
@keyframes flotarTel { 0%,100% { transform: translateY(0) rotate(-2deg); } 50% { transform: translateY(-14px) rotate(-2deg); } }
.tel-notch { width: 60px; height: 14px; background: #1a1208; border-radius: 0 0 12px 12px; margin: 0 auto 0; }
.tel-pantalla { padding: 12px; }
.app-preview { background: #faf7f2; border-radius: 16px; padding: 12px; min-height: 320px; display: flex; flex-direction: column; gap: 8px; }
.prev-header { display: flex; align-items: center; gap: 8px; padding-bottom: 10px; border-bottom: 1px solid rgba(184,134,42,0.15); margin-bottom: 4px; }
.prev-logo { width: 22px; height: 22px; object-fit: contain; filter: invert(1) brightness(0.12); }
.prev-nombre { font-family: var(--font-display); font-size: 0.65rem; font-weight: 700; color: var(--gold-dark); letter-spacing: 0.1em; }
.prev-cancion { display: flex; align-items: center; justify-content: space-between; background: #ffffff; border-radius: 10px; padding: 8px 10px; border: 1px solid rgba(184,134,42,0.12); }
.prev-info { display: flex; flex-direction: column; gap: 2px; min-width: 0; }
.prev-titulo { font-family: var(--font-display); font-size: 0.62rem; font-weight: 600; color: var(--text-primary); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.prev-artista { font-family: var(--font-body); font-size: 0.55rem; color: var(--text-muted); font-style: italic; }
.prev-tono { font-family: var(--font-mono); font-size: 0.6rem; color: var(--gold-primary); background: rgba(184,134,42,0.1); padding: 2px 6px; border-radius: 6px; flex-shrink: 0; margin-left: 6px; }

/* ── Stats ── */
.estadisticas { background: #f8f5ef; border-top: 1px solid rgba(184,134,42,0.12); border-bottom: 1px solid rgba(184,134,42,0.12); padding: 40px 24px; }
.stats-inner { max-width: 800px; margin: 0 auto; display: flex; align-items: center; justify-content: center; gap: 60px; }
.stat { display: flex; flex-direction: column; align-items: center; gap: 6px; }
.stat-num { font-family: var(--font-display); font-size: 2.6rem; font-weight: 700; color: var(--gold-primary); line-height: 1; }
.stat-label { font-family: var(--font-display); font-size: 0.58rem; letter-spacing: 0.4em; text-transform: uppercase; color: var(--text-muted); }
.stat-sep { width: 1px; height: 50px; background: linear-gradient(180deg, transparent, rgba(184,134,42,0.25), transparent); }

/* ── Secciones ── */
.seccion-inner { max-width: 1200px; margin: 0 auto; padding: 72px 32px; }
.seccion-header { display: flex; align-items: flex-end; justify-content: space-between; margin-bottom: 36px; }
.seccion-supra { font-family: var(--font-display); font-size: 0.6rem; letter-spacing: 0.45em; text-transform: uppercase; color: var(--text-muted); margin-bottom: 8px; }
.seccion-titulo { font-family: var(--font-display); font-size: clamp(1.8rem, 3vw, 2.6rem); font-weight: 700; color: var(--text-primary); line-height: 1; }
.btn-ver-todo { font-family: var(--font-display); font-size: 0.65rem; letter-spacing: 0.18em; text-transform: uppercase; color: var(--gold-dark); padding: 8px 16px; border: 1px solid var(--border-card); border-radius: 20px; transition: var(--transition); }
.btn-ver-todo:hover { background: rgba(184,134,42,0.08); }

/* ── Canciones Destacadas ── */
.seccion-destacadas { background: #ffffff; }
.grilla-destacadas { display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; }
.card-dest {
  border-radius: var(--radius-lg); overflow: hidden;
  background: var(--bg-card); border: 1px solid var(--border-card);
  transition: var(--transition); box-shadow: var(--shadow-card);
  display: flex; flex-direction: column;
}
.card-dest:hover { transform: translateY(-4px); box-shadow: var(--shadow-strong); border-color: var(--gold-pale); }
.card-dest-img { position: relative; aspect-ratio: 16/9; overflow: hidden; background: var(--bg-secondary); }
.card-dest-img img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.4s; }
.card-dest:hover .card-dest-img img { transform: scale(1.06); }
.card-dest-placeholder { width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; font-size: 2rem; color: var(--text-faint); }
.card-dest-genero { position: absolute; top: 8px; left: 8px; font-family: var(--font-display); font-size: 0.5rem; letter-spacing: 0.15em; text-transform: uppercase; color: var(--gold-dark); background: rgba(255,255,255,0.92); padding: 3px 8px; border-radius: 12px; }
.card-dest-info { padding: 14px 16px; flex: 1; }
.card-dest-tono { font-family: var(--font-mono); font-size: 0.6rem; color: var(--gold-primary); background: rgba(184,134,42,0.1); padding: 2px 8px; border-radius: 10px; }
.card-dest-titulo { font-family: var(--font-display); font-size: 0.95rem; font-weight: 600; color: var(--text-primary); margin: 8px 0 4px; line-height: 1.3; }
.card-dest-artista { font-size: 0.82rem; color: var(--text-muted); font-style: italic; }

/* ── Gráficas ── */
.seccion-graficas { background: var(--bg-secondary); }
.graficas-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 24px; }
.grafica-card { background: var(--bg-card); border: 1px solid var(--border-card); border-radius: var(--radius-lg); padding: 28px; box-shadow: var(--shadow-card); }
.grafica-titulo { font-family: var(--font-display); font-size: 0.8rem; font-weight: 700; letter-spacing: 0.2em; text-transform: uppercase; color: var(--text-muted); margin-bottom: 24px; }
.barras { display: flex; flex-direction: column; gap: 14px; }
.barra-wrap { display: flex; flex-direction: column; gap: 6px; }
.barra-label-row { display: flex; justify-content: space-between; align-items: center; }
.barra-nombre { font-family: var(--font-display); font-size: 0.82rem; color: var(--text-primary); }
.barra-count { font-family: var(--font-mono); font-size: 0.72rem; font-weight: 600; color: var(--gold-dark); background: rgba(184,134,42,0.1); padding: 2px 8px; border-radius: 10px; }
.barra-track { height: 8px; background: var(--bg-secondary); border-radius: 4px; overflow: hidden; }
.barra-fill { height: 100%; background: linear-gradient(90deg, var(--gold-dark), var(--gold-primary)); border-radius: 4px; transition: width 1s cubic-bezier(0.4,0,0.2,1); }
.barra-tono { background: linear-gradient(90deg, var(--gold-primary), var(--gold-pale)); }

@media (max-width: 900px) {
  .grilla-destacadas { grid-template-columns: repeat(2, 1fr); }
  .graficas-grid { grid-template-columns: 1fr; }
  .stats-inner { gap: 32px; }
}
@media (max-width: 800px) {
  .hero-inner { grid-template-columns: 1fr; padding: 100px 24px 60px; text-align: center; }
  .hero-izq { align-items: center; }
  .scroll-ind { display: none; }
  .hero-der { height: 380px; }
  .seccion-header { flex-direction: column; align-items: flex-start; gap: 12px; }
}
@media (max-width: 500px) {
  .grilla-destacadas { grid-template-columns: 1fr; }
}
</style>
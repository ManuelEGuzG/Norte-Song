<template>
  <router-link :to="`/cancion/${cancion.id}`" class="tarjeta">

    <!-- Imagen de portada -->
    <div class="tarjeta-imagen">
      <img
        v-if="cancion.imagen && !imgError"
        :src="cancion.imagen"
        :alt="cancion.titulo"
        class="portada-img"
        loading="lazy"
        crossorigin="anonymous"
        referrerpolicy="no-referrer"
        @error="imgError = true"
      />
      <!-- Fallback: miniatura via iframe oculto + canvas, o placeholder estético -->
      <div v-else class="portada-placeholder">
        <div class="placeholder-bg"></div>
        <span class="portada-nota">♪</span>
      </div>
      <span class="badge-genero-over">{{ cancion.genero }}</span>
    </div>

    <div class="tarjeta-cuerpo">
      <div class="tarjeta-top">
        <span class="badge-tono">{{ cancion.tono }}</span>
      </div>
      <h3 class="tarjeta-titulo">{{ cancion.titulo }}</h3>
      <p class="tarjeta-artista">{{ cancion.artista }}</p>
    </div>

    <div class="tarjeta-pie">
      <span class="tarjeta-flecha">→</span>
    </div>
  </router-link>
</template>

<script setup>
import { ref } from 'vue'
defineProps({ cancion: { type: Object, required: true } })
const imgError = ref(false)
</script>

<style scoped>
.tarjeta {
  position: relative; display: flex; flex-direction: column;
  background: var(--bg-card); border: 1px solid var(--border-card);
  border-radius: var(--radius-lg); overflow: hidden;
  transition: var(--transition); cursor: pointer; box-shadow: var(--shadow-card);
  animation: fadeInUp 0.5s ease both;
}
.tarjeta::before {
  content: ''; position: absolute; top: 0; left: 0; right: 0; height: 3px;
  background: linear-gradient(90deg, var(--gold-pale), var(--gold-primary), var(--gold-pale));
  opacity: 0; transition: opacity 0.3s ease;
}
.tarjeta:hover { border-color: var(--gold-pale); transform: translateY(-4px); box-shadow: 0 12px 40px rgba(90,64,32,0.12); }
.tarjeta:hover::before { opacity: 1; }

/* Imagen */
.tarjeta-imagen {
  position: relative; width: 100%; aspect-ratio: 16/9; overflow: hidden;
}
.portada-img {
  width: 100%; height: 100%; object-fit: cover;
  transition: transform 0.4s ease;
}
.tarjeta:hover .portada-img { transform: scale(1.05); }

/* Placeholder estético con gradiente dorado */
.portada-placeholder {
  width: 100%; height: 100%;
  display: flex; align-items: center; justify-content: center;
  position: relative; overflow: hidden;
}
.placeholder-bg {
  position: absolute; inset: 0;
  background: linear-gradient(135deg,
    #f5ede0 0%,
    #ede0cc 30%,
    #e8d5b7 60%,
    #f0e4cc 100%
  );
}
.placeholder-bg::after {
  content: '';
  position: absolute; inset: 0;
  background:
    radial-gradient(ellipse 60% 50% at 30% 40%, rgba(184,134,42,0.12) 0%, transparent 70%),
    radial-gradient(ellipse 40% 60% at 70% 70%, rgba(184,134,42,0.08) 0%, transparent 60%);
}
.portada-nota {
  position: relative; z-index: 1;
  font-size: 2.8rem; color: rgba(184,134,42,0.4);
}

.badge-genero-over {
  position: absolute; top: 10px; left: 10px;
  font-family: var(--font-display); font-size: 0.55rem; letter-spacing: 0.18em; text-transform: uppercase;
  color: var(--gold-dark); background: rgba(255,255,255,0.9);
  border: 1px solid rgba(184,134,42,0.3); padding: 3px 10px; border-radius: 20px;
  backdrop-filter: blur(4px);
}

/* Cuerpo */
.tarjeta-cuerpo { padding: 18px 20px 8px; flex: 1; }
.tarjeta-top { display: flex; gap: 8px; margin-bottom: 10px; }
.badge-tono {
  font-family: var(--font-mono); font-size: 0.68rem; color: var(--text-muted);
  background: var(--bg-secondary); border: 1px solid var(--border-faint);
  padding: 3px 10px; border-radius: 20px;
}
.tarjeta-titulo {
  font-family: var(--font-display); font-size: 1.15rem; font-weight: 600;
  color: var(--text-primary); margin-bottom: 5px; line-height: 1.3; transition: color 0.25s;
}
.tarjeta:hover .tarjeta-titulo { color: var(--gold-dark); }
.tarjeta-artista { font-size: 0.9rem; color: var(--text-secondary); font-style: italic; }

.tarjeta-pie { padding: 8px 20px 16px; display: flex; justify-content: flex-end; }
.tarjeta-flecha { font-size: 1.1rem; color: var(--text-faint); transition: var(--transition); display: inline-block; }
.tarjeta:hover .tarjeta-flecha { color: var(--gold-primary); transform: translateX(6px); }
</style>
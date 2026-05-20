<template>
  <div class="relacionadas" v-if="relacionadas.length">
    <div class="rel-header">
      <p class="rel-supra">Más canciones</p>
      <h3 class="rel-titulo">También te puede interesar</h3>
    </div>
    <div class="rel-grilla">
      <router-link
        v-for="cancion in relacionadas"
        :key="cancion.id"
        :to="`/cancion/${cancion.id}`"
        class="rel-card"
      >
        <div class="rel-img">
          <img
            v-if="cancion.imagen"
            :src="cancion.imagen"
            :alt="cancion.titulo"
            loading="lazy"
            @error="e => e.target.style.display='none'"
          />
          <div v-else class="rel-placeholder">♪</div>
        </div>
        <div class="rel-info">
          <div class="rel-badges">
            <span class="rel-badge-genero">{{ cancion.genero }}</span>
            <span class="rel-badge-tono">{{ cancion.tono }}</span>
          </div>
          <h4 class="rel-nombre">{{ cancion.titulo }}</h4>
          <p class="rel-artista">{{ cancion.artista }}</p>
        </div>
        <span class="rel-flecha">→</span>
      </router-link>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  cancionActual: { type: Object, required: true },
  todas:         { type: Array,  required: true },
})

// Mostrar canciones del mismo género o mismo tono, excluyendo la actual
// Prioriza misma tonalidad
const relacionadas = computed(() => {
  const mismoTono   = props.todas.filter(c =>
    c.id !== props.cancionActual.id && c.tono === props.cancionActual.tono
  )
  const mismoGenero = props.todas.filter(c =>
    c.id !== props.cancionActual.id &&
    c.genero === props.cancionActual.genero &&
    c.tono !== props.cancionActual.tono
  )
  // Combinar: primero mismo tono, luego mismo género
  const combinadas = [...mismoTono, ...mismoGenero]
  // Quitar duplicados y limitar a 4
  const vistos = new Set()
  return combinadas.filter(c => {
    if (vistos.has(c.id)) return false
    vistos.add(c.id)
    return true
  }).slice(0, 4)
})
</script>

<style scoped>
.relacionadas {
  margin-top: 56px;
  padding-top: 40px;
  border-top: 1px solid var(--border-faint);
}

.rel-header { margin-bottom: 24px; }
.rel-supra {
  font-family: var(--font-display); font-size: 0.58rem;
  letter-spacing: 0.4em; text-transform: uppercase;
  color: var(--text-muted); margin-bottom: 6px;
}
.rel-titulo {
  font-family: var(--font-display); font-size: 1.5rem;
  font-weight: 700; color: var(--text-primary);
}

.rel-grilla {
  display: flex; flex-direction: column; gap: 10px;
}

.rel-card {
  display: flex; align-items: center; gap: 14px;
  padding: 12px 14px;
  background: var(--bg-card); border: 1px solid var(--border-card);
  border-radius: var(--radius-md); transition: var(--transition);
  box-shadow: var(--shadow-card);
}
.rel-card:hover {
  border-color: var(--gold-pale);
  transform: translateX(4px);
  box-shadow: var(--shadow-strong);
}

.rel-img {
  width: 60px; height: 60px; border-radius: var(--radius-sm);
  overflow: hidden; flex-shrink: 0; background: var(--bg-secondary);
}
.rel-img img { width: 100%; height: 100%; object-fit: cover; }
.rel-placeholder {
  width: 100%; height: 100%;
  display: flex; align-items: center; justify-content: center;
  font-size: 1.4rem; color: var(--text-faint);
}

.rel-info { flex: 1; min-width: 0; }
.rel-badges { display: flex; gap: 6px; margin-bottom: 4px; }
.rel-badge-genero {
  font-family: var(--font-display); font-size: 0.5rem; letter-spacing: 0.15em;
  text-transform: uppercase; color: var(--gold-dark);
  background: rgba(184,134,42,0.1); padding: 2px 8px; border-radius: 10px;
}
.rel-badge-tono {
  font-family: var(--font-mono); font-size: 0.58rem; color: var(--text-muted);
  background: var(--bg-secondary); padding: 2px 8px; border-radius: 10px;
}
.rel-nombre {
  font-family: var(--font-display); font-size: 0.95rem; font-weight: 600;
  color: var(--text-primary); white-space: nowrap; overflow: hidden;
  text-overflow: ellipsis; transition: color 0.2s;
}
.rel-card:hover .rel-nombre { color: var(--gold-dark); }
.rel-artista {
  font-size: 0.82rem; color: var(--text-muted); font-style: italic;
}

.rel-flecha {
  font-size: 1rem; color: var(--text-faint);
  transition: var(--transition); flex-shrink: 0;
}
.rel-card:hover .rel-flecha { color: var(--gold-primary); transform: translateX(4px); }

@media (max-width: 600px) {
  .rel-grilla { gap: 8px; }
}
</style>
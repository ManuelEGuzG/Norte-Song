<template>
  <router-link :to="`/cancion/${cancion.id}`" class="tarjeta">
    <div class="tarjeta-cuerpo">
      <div class="tarjeta-top">
        <span class="badge-genero">{{ cancion.genero }}</span>
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
defineProps({ cancion: { type: Object, required: true } })
</script>
<style scoped>
.tarjeta {
  position: relative;
  display: flex; flex-direction: column; justify-content: space-between;
  background: var(--bg-card);
  border: 1px solid var(--border-card);
  border-radius: var(--radius-lg);
  padding: 26px 24px;
  overflow: hidden;
  transition: var(--transition);
  cursor: pointer;
  box-shadow: var(--shadow-card);
  animation: fadeInUp 0.5s ease both;
}
.tarjeta::before {
  content: '';
  position: absolute; top: 0; left: 0; right: 0; height: 3px;
  background: linear-gradient(90deg, var(--gold-pale), var(--gold-primary), var(--gold-pale));
  opacity: 0; transition: opacity 0.3s ease;
}
.tarjeta:hover {
  border-color: var(--gold-pale);
  transform: translateY(-4px);
  box-shadow: 0 12px 40px rgba(90,64,32,0.12), 0 2px 8px rgba(90,64,32,0.08);
}
.tarjeta:hover::before { opacity: 1; }

.tarjeta-top { display: flex; gap: 8px; margin-bottom: 14px; }
.badge-genero {
  font-family: var(--font-display); font-size: 0.58rem;
  letter-spacing: 0.18em; text-transform: uppercase;
  color: var(--gold-dark);
  background: rgba(184,134,42,0.1);
  border: 1px solid rgba(184,134,42,0.2);
  padding: 4px 12px; border-radius: 20px;
}
.badge-tono {
  font-family: var(--font-mono); font-size: 0.68rem;
  color: var(--text-muted);
  background: var(--bg-secondary);
  border: 1px solid var(--border-faint);
  padding: 4px 12px; border-radius: 20px;
}
.tarjeta-titulo {
  font-family: var(--font-display); font-size: 1.2rem; font-weight: 600;
  color: var(--text-primary); margin-bottom: 6px; line-height: 1.3;
  transition: color 0.25s ease;
}
.tarjeta:hover .tarjeta-titulo { color: var(--gold-dark); }
.tarjeta-artista { font-size: 0.95rem; color: var(--text-secondary); font-style: italic; }
.tarjeta-pie { margin-top: 20px; display: flex; justify-content: flex-end; }
.tarjeta-flecha {
  font-size: 1.1rem; color: var(--text-faint);
  transition: var(--transition); display: inline-block;
}
.tarjeta:hover .tarjeta-flecha {
  color: var(--gold-primary); transform: translateX(6px);
}
</style>
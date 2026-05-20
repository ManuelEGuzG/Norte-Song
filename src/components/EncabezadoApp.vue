<template>
  <header class="encabezado" :class="{ scrolled: scrolled }">
    <div class="encabezado-inner">
      <router-link to="/" class="marca">
        <img :src="logoIglesia" alt="Iglesia del Norte" class="marca-logo" />
        <div class="marca-texto">
          <span class="marca-norte">Norte</span>
          <span class="marca-songs">Songs</span>
        </div>
      </router-link>
      <nav class="nav">
        <router-link to="/" class="nav-link" exact-active-class="activo">Inicio</router-link>
        <router-link to="/canciones" class="nav-link" active-class="activo">Canciones</router-link>
        <router-link to="/acordes" class="nav-link" active-class="activo">Acordes</router-link>
      </nav>
    </div>
  </header>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
import logoIglesia from '@/assets/logo/logo-iglesia.png'
const scrolled = ref(false)
function alScroll() { scrolled.value = window.scrollY > 40 }
onMounted(() => window.addEventListener('scroll', alScroll))
onUnmounted(() => window.removeEventListener('scroll', alScroll))
</script>

<style scoped>
.encabezado {
  position: fixed; top: 0; left: 0; right: 0; z-index: 100;
  padding: 16px 40px; transition: var(--transition); border-bottom: 1px solid transparent;
}
.encabezado.scrolled {
  background: rgba(250, 247, 242, 0.96);
  backdrop-filter: blur(16px);
  border-bottom-color: var(--border-faint);
  box-shadow: 0 2px 20px rgba(90,64,32,0.06);
  padding: 10px 40px;
}
.encabezado-inner {
  max-width: 1200px; margin: 0 auto;
  display: flex; align-items: center; justify-content: space-between;
}
.marca { display: flex; align-items: center; gap: 12px; }
.marca-logo {
  width: 44px; height: 44px; object-fit: contain;
  filter: invert(1) brightness(0.15); transition: var(--transition);
}
.marca:hover .marca-logo { filter: invert(1) brightness(0.15) drop-shadow(0 2px 6px rgba(184,134,42,0.5)); }
.marca-texto { display: flex; flex-direction: column; line-height: 1; }
.marca-norte {
  font-family: var(--font-display); font-size: 1.2rem; font-weight: 700;
  color: var(--gold-dark); letter-spacing: 0.1em;
}
.marca-songs {
  font-family: var(--font-display); font-size: 0.55rem; font-weight: 400;
  color: var(--text-muted); letter-spacing: 0.45em; text-transform: uppercase; margin-top: 2px;
}
.nav { display: flex; gap: 4px; }
.nav-link {
  font-family: var(--font-display); font-size: 0.68rem;
  letter-spacing: 0.2em; text-transform: uppercase;
  color: var(--text-muted); padding: 8px 16px;
  border-radius: var(--radius-sm); border: 1px solid transparent; transition: var(--transition);
}
.nav-link:hover { color: var(--gold-dark); background: rgba(184,134,42,0.06); }
.nav-link.activo { color: var(--gold-dark); border-color: var(--border-card); background: rgba(184,134,42,0.08); }

@media (max-width: 600px) {
  .encabezado { padding: 12px 16px; }
  .encabezado.scrolled { padding: 8px 16px; }
  .marca-norte { font-size: 1rem; }
  .nav-link { padding: 6px 10px; font-size: 0.6rem; }
}
</style>
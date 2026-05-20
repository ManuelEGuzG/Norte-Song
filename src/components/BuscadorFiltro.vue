<template>
  <div class="buscador-filtro">
    <div class="busqueda-wrap">
      <span class="icono-busqueda">♪</span>
      <input type="text" v-model="busquedaLocal" placeholder="Buscar canción o artista..."
        class="input-busqueda" @input="emit('update:search', busquedaLocal)" />
      <button v-if="busquedaLocal" class="btn-limpiar" @click="limpiar">✕</button>
    </div>
    <div class="filtros">
      <button class="btn-filtro" :class="{ activo: generoLocal === '' }" @click="setGenero('')">Todos</button>
      <button v-for="g in genres" :key="g" class="btn-filtro"
        :class="{ activo: generoLocal === g }" @click="setGenero(g)">{{ g }}</button>
    </div>
  </div>
</template>
<script setup>
import { ref } from 'vue'
const props = defineProps({ search: String, genre: String, genres: Array })
const emit  = defineEmits(['update:search', 'update:genre'])
const busquedaLocal = ref(props.search || '')
const generoLocal   = ref(props.genre || '')
function setGenero(g) { generoLocal.value = g; emit('update:genre', g) }
function limpiar()    { busquedaLocal.value = ''; emit('update:search', '') }
</script>
<style scoped>
.buscador-filtro { display: flex; flex-direction: column; gap: 14px; }
.busqueda-wrap { position: relative; display: flex; align-items: center; }
.icono-busqueda {
  position: absolute; left: 18px; color: var(--gold-primary);
  font-size: 1rem; pointer-events: none;
}
.input-busqueda {
  width: 100%; background: var(--bg-card);
  border: 1px solid var(--border-card);
  border-radius: var(--radius-lg); padding: 14px 48px;
  color: var(--text-primary); font-family: var(--font-body);
  font-size: 1.05rem; transition: var(--transition); outline: none;
  box-shadow: 0 1px 4px rgba(90,64,32,0.06);
}
.input-busqueda::placeholder { color: var(--text-faint); font-style: italic; }
.input-busqueda:focus {
  border-color: var(--gold-primary);
  box-shadow: 0 0 0 3px rgba(184,134,42,0.12), 0 2px 12px rgba(90,64,32,0.08);
}
.btn-limpiar {
  position: absolute; right: 16px; background: none;
  color: var(--text-muted); font-size: 0.75rem; padding: 4px 6px;
  transition: var(--transition-fast);
}
.btn-limpiar:hover { color: var(--gold-dark); }
.filtros { display: flex; flex-wrap: wrap; gap: 8px; }
.btn-filtro {
  font-family: var(--font-display); font-size: 0.62rem;
  letter-spacing: 0.18em; text-transform: uppercase;
  color: var(--text-muted); background: var(--bg-card);
  border: 1px solid var(--border-subtle); padding: 7px 16px;
  border-radius: 20px; transition: var(--transition);
  box-shadow: 0 1px 4px rgba(90,64,32,0.05);
}
.btn-filtro:hover { border-color: var(--gold-pale); color: var(--gold-dark); }
.btn-filtro.activo {
  background: rgba(184,134,42,0.1); border-color: var(--gold-primary);
  color: var(--gold-dark); font-weight: 600;
}
</style>
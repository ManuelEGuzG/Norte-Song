<template>
  <div class="reproductor">
    <div class="repr-header">
      <span class="repr-icono">▶</span>
      <span class="repr-titulo">Video de referencia</span>
    </div>
    <div class="repr-marco" v-if="videoId">
      <iframe :src="`https://www.youtube.com/embed/${videoId}`" frameborder="0"
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
        allowfullscreen title="Video de la canción" />
    </div>
    <div class="repr-vacio" v-else>
      <span>♩</span><p>Sin video disponible</p>
    </div>
  </div>
</template>
<script setup>
defineProps({ videoId: { type: String, default: '' } })
</script>
<style scoped>
.reproductor {
  display: flex; flex-direction: column; gap: 14px;
  background: var(--bg-card); border: 1px solid var(--border-card);
  border-radius: var(--radius-lg); padding: 20px;
  box-shadow: var(--shadow-card);
}
.repr-header { display: flex; align-items: center; gap: 10px; }
.repr-icono { color: var(--gold-primary); font-size: 0.8rem; }
.repr-titulo {
  font-family: var(--font-display); font-size: 0.6rem;
  letter-spacing: 0.25em; text-transform: uppercase; color: var(--text-muted);
}
.repr-marco {
  position: relative; padding-bottom: 56.25%; height: 0;
  border-radius: var(--radius-md); overflow: hidden;
  border: 1px solid var(--border-faint);
}
.repr-marco iframe { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }
.repr-vacio { text-align: center; padding: 28px; color: var(--text-muted); }
.repr-vacio span { font-size: 2rem; display: block; margin-bottom: 8px; color: var(--text-faint); }
.repr-vacio p { font-size: 0.9rem; font-style: italic; }
</style>
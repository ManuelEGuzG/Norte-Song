<template>
  <div class="skeleton-card">
    <div class="skel-img shimmer"></div>
    <div class="skel-body">
      <div class="skel-badge shimmer"></div>
      <div class="skel-titulo shimmer"></div>
      <div class="skel-artista shimmer"></div>
    </div>
  </div>
</template>

<style scoped>
.skeleton-card {
  border-radius: var(--radius-lg);
  background: var(--bg-card);
  border: 1px solid var(--border-faint);
  overflow: hidden;
  box-shadow: var(--shadow-card);
}
.skel-img {
  width: 100%; aspect-ratio: 16/9;
}
.skel-body {
  padding: 18px 20px;
  display: flex; flex-direction: column; gap: 10px;
}
.skel-badge { height: 20px; width: 50px; border-radius: 20px; }
.skel-titulo { height: 22px; width: 80%; border-radius: 6px; }
.skel-artista { height: 16px; width: 55%; border-radius: 6px; }

.shimmer {
  background: linear-gradient(
    90deg,
    var(--bg-secondary) 25%,
    var(--bg-elevated) 50%,
    var(--bg-secondary) 75%
  );
  background-size: 200% 100%;
  animation: shimmer 1.4s infinite;
}
@keyframes shimmer {
  0%   { background-position: 200% center; }
  100% { background-position: -200% center; }
}
</style>
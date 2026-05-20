<template>
  <div id="app">
    <EncabezadoApp v-if="!isPresentationMode" />
    <main>
      <router-view />
    </main>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRoute } from 'vue-router'
import EncabezadoApp from './components/EncabezadoApp.vue'

const route = useRoute()
const isPresentationMode = computed(() => route.path.startsWith('/presentacion'))
</script>

<style>
#app {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

main {
  flex: 1;
}
</style>
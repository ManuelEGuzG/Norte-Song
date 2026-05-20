import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { fileURLToPath, URL } from 'node:url'

export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  },
  server: {
    proxy: {
      '/ytimg': {
        target: 'https://i.ytimg.com',
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/ytimg/, '')
      }
    }
  }
})
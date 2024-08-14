import { defineConfig } from 'vite';

export default defineConfig({
  server: {
    proxy: {
      // Proxy all API requests to port 3000
      '/api': {
        target: 'http://localhost:3000/',
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, ''),
      },
    },
  },
});

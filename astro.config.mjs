import { defineConfig } from 'astro/config';
import cloudflare from '@astrojs/cloudflare';

export default defineConfig({
  output: 'server',
  adapter: cloudflare({
    imageService: 'cloudflare',
    platformProxy: {
      enabled: true,
      configPath: 'wrangler.jsonc',
      persist: { path: './.cache/wrangler/v3' },
    },
  }),
  vite: {
    ssr: {
      noExternal: ['@astrojs/cloudflare'],
    },
  },
});

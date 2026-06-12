import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: 'tests/integration',
  timeout: 30000,
  retries: 1,
  use: {
    baseURL: process.env.PLAYWRIGHT_TEST_BASE_URL || 'http://localhost:4321',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
  },
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
  ],
  webServer: {
    command: 'npx wrangler dev --port 4321 --test-scheduled',
    port: 4321,
    reuseExistingServer: true,
    timeout: 30000,
  },
});

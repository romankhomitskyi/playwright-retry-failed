import { defineConfig, devices } from '@playwright/test';


export default defineConfig({
  testDir: './specs',
  forbidOnly: !!process.env.CI,
  workers: 1,
  reporter: process.env.CI ? 'blob': 'html',
  outputDir: process.env.CI ? 'test-results' : `./test-results-${process.env.SHARD_INDEX || 1}`,
  use: {
    trace: 'on-first-retry',
    actionTimeout: 4000,
  },
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },

    {
      name: 'firefox',
      use: { ...devices['Desktop Firefox'] },
    },

    {
      name: 'webkit',
      use: { ...devices['Desktop Safari'] },
    }]
});

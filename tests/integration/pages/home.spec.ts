import { test, expect } from '@playwright/test';

test.describe('Home page', () => {
  test('loads successfully', async ({ page }) => {
    const response = await page.goto('/');
    expect(response?.status()).toBe(200);
  });

  test('displays the app name', async ({ page }) => {
    await page.goto('/');
    await expect(page.locator('h1')).toContainText('Welcome');
  });
});

test.describe('About page', () => {
  test('loads successfully', async ({ page }) => {
    const response = await page.goto('/about');
    expect(response?.status()).toBe(200);
  });
});

test.describe('API health endpoint', () => {
  test('returns health data', async ({ request }) => {
    const response = await request.get('/api/health');
    expect(response.status()).toBe(200);
    const body = await response.json();
    expect(body).toHaveProperty('status', 'ok');
    expect(body).toHaveProperty('timestamp');
    expect(body).toHaveProperty('version');
  });
});

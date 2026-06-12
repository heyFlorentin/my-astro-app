import type { APIRoute } from 'astro';

export const GET: APIRoute = async ({ locals }) => {
  try {
    const env = locals.runtime.env;
    return new Response(
      JSON.stringify({
        status: 'ok',
        environment: env.ENVIRONMENT,
        version: env.APP_VERSION,
        timestamp: new Date().toISOString(),
      }),
      {
        status: 200,
        headers: { 'Content-Type': 'application/json' },
      },
    );
  } catch (error) {
    console.error('GET /api/health error:', error);
    return new Response(
      JSON.stringify({ error: 'Internal server error', code: 500 }),
      {
        status: 500,
        headers: { 'Content-Type': 'application/json' },
      },
    );
  }
};

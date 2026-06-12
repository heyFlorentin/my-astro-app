/// <reference types="astro/client" />

type Runtime = import('@astrojs/cloudflare').Runtime<Env>;

declare namespace App {
  interface Locals extends Runtime {
    // Add custom locals here
  }
}

interface Env {
  ENVIRONMENT: string;
  APP_VERSION: string;
  // KV namespaces, Durable Objects, R2 buckets go here
  // SESSION: KVNamespace;  // (auto-provisioned by adapter)
}

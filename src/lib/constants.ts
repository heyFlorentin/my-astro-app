/**
 * App-wide constants.
 * MUST NOT use process.env here — constants only.
 * For environment-specific values, use Astro.locals.runtime.env in .astro files.
 */

export const APP_NAME = 'My Astro App' as const;

export const DEFAULT_PAGE_TITLE = 'My Astro App' as const;

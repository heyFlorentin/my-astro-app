/**
 * Utility helpers.
 * All functions MUST be pure or receive dependencies explicitly.
 * MUST NOT access process.env or Astro.locals directly.
 */

/**
 * Formats a date to ISO string, or returns fallback on error.
 */
export function formatDate(input: string | Date, fallback = 'Unknown date'): string {
  try {
    const date = typeof input === 'string' ? new Date(input) : input;
    if (isNaN(date.getTime())) return fallback;
    return date.toISOString();
  } catch {
    return fallback;
  }
}

/**
 * Type-safe check for non-null value.
 */
export function isDefined<T>(value: T | null | undefined): value is T {
  return value !== null && value !== undefined;
}

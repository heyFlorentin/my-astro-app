import { describe, it, expect } from 'vitest';
import { formatDate, isDefined } from '@lib/utils';

describe('formatDate', () => {
  it('returns ISO string for valid date string', () => {
    const result = formatDate('2026-06-12');
    expect(result).toContain('2026-06-12');
  });

  it('returns fallback for invalid date', () => {
    const result = formatDate('not-a-date', 'fallback');
    expect(result).toBe('fallback');
  });

  it('returns fallback for empty string', () => {
    const result = formatDate('');
    expect(result).toBe('Unknown date');
  });

  it('handles Date object input', () => {
    const date = new Date('2026-06-12T12:00:00Z');
    const result = formatDate(date);
    expect(result).toContain('2026-06-12');
  });
});

describe('isDefined', () => {
  it('returns true for defined values', () => {
    expect(isDefined('hello')).toBe(true);
    expect(isDefined(0)).toBe(true);
    expect(isDefined(false)).toBe(true);
    expect(isDefined({})).toBe(true);
  });

  it('returns false for null or undefined', () => {
    expect(isDefined(null)).toBe(false);
    expect(isDefined(undefined)).toBe(false);
  });
});

const { describe, it, expect } = require('@jest/globals');

const addon = require('./hello_world.node');

describe('Addon', () => {
  it('exposes hello', () => {
    expect(typeof addon.hello).toBe('function');
  });
});

describe('Hello World', () => {
  it('should work', () => {
    expect(addon.hello()).toBe('world');
  });
});

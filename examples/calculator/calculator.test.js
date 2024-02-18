const { describe, it, expect } = require('@jest/globals');

const addon = require('./bindings.node');

describe('Addon', () => {
  it('exposes Calculator', () => {
    expect(addon.Calculator).toBeDefined();
    expect(addon.Calculator.prototype.add).toBeDefined();
    expect(addon.Calculator.prototype.subtract).toBeDefined();
    expect(addon.Calculator.prototype.getResult).toBeDefined();
    expect(addon.Calculator.prototype.clear).toBeDefined();
  });
});

describe('Calculator', () => {
  it('works', () => {
    const calculator = new addon.Calculator();
    expect(calculator.getResult()).toBe(0);
    expect(calculator.add(1).getResult()).toBe(1);
    expect(calculator.add(2).getResult()).toBe(3);
    expect(calculator.subtract(3).getResult()).toBe(0);
    expect(calculator.subtract(10).getResult()).toBe(-10);
    expect(calculator.clear().getResult()).toBe(0);
  });

  it('throws an exception with invalid arguments', () => {
    const calculator = new addon.Calculator();
    expect(() => calculator.add()).toThrowError('Number expected');
    expect(() => calculator.add('a')).toThrowError('Number expected');
    expect(() => calculator.subtract()).toThrowError('Number expected');
    expect(() => calculator.subtract('a')).toThrowError('Number expected');
  });
});

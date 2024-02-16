#include "calculator/calculator.h"

namespace calculator {

Calculator ::Calculator() {}

void Calculator::Add(int x) { value_ += x; }

void Calculator::Subtract(int x) { value_ -= x; }

int Calculator::GetResult() const { return value_; }

void Calculator::Clear() { value_ = 0; }

}  // namespace calculator

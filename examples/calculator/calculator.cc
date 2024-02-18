#include "examples/calculator/calculator.h"

namespace examples {

Calculator ::Calculator() {}

void Calculator::Add(int x) { value_ += x; }

void Calculator::Subtract(int x) { value_ -= x; }

int Calculator::GetResult() const { return value_; }

void Calculator::Clear() { value_ = 0; }

}  // namespace examples

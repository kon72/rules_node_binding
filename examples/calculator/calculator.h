#ifndef EXAMPLES_CALCULATOR_CALCULATOR_H_
#define EXAMPLES_CALCULATOR_CALCULATOR_H_

namespace examples {

class Calculator {
 public:
  Calculator();

  void Add(int x);

  void Subtract(int x);

  int GetResult() const;

  void Clear();

 private:
  int value_ = 0;
};

}  // namespace examples

#endif  // EXAMPLES_CALCULATOR_CALCULATOR_H_

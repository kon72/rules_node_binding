#ifndef CALCULATOR_CALCULATOR_H_
#define CALCULATOR_CALCULATOR_H_

namespace calculator {

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

}  // namespace calculator

#endif  // CALCULATOR_CALCULATOR_H_

#include "examples/calculator/calculator_node.h"

#include "examples/calculator/calculator.h"
#include "napi.h"

namespace examples {
namespace node {

class CalculatorNode : public Napi::ObjectWrap<CalculatorNode> {
 public:
  static Napi::Function Init(Napi::Env env, Napi::Object exports) {
    return Napi::ObjectWrap<CalculatorNode>::DefineClass(
        env, "Calculator",
        {
            InstanceMethod("add", &CalculatorNode::Add),
            InstanceMethod("subtract", &CalculatorNode::Subtract),
            InstanceMethod("getResult", &CalculatorNode::GetResult),
            InstanceMethod("clear", &CalculatorNode::Clear),
        });
  }

  explicit CalculatorNode(const Napi::CallbackInfo& info)
      : Napi::ObjectWrap<CalculatorNode>(info) {}

  Napi::Value Add(const Napi::CallbackInfo& info) {
    if (info.Length() <= 0 || !info[0].IsNumber()) {
      Napi::TypeError::New(info.Env(), "Number expected")
          .ThrowAsJavaScriptException();
      return info.This();
    }
    calculator_.Add(info[0].As<Napi::Number>().Int32Value());
    return info.This();
  }

  Napi::Value Subtract(const Napi::CallbackInfo& info) {
    if (info.Length() <= 0 || !info[0].IsNumber()) {
      Napi::TypeError::New(info.Env(), "Number expected")
          .ThrowAsJavaScriptException();
      return info.This();
    }
    calculator_.Subtract(info[0].As<Napi::Number>().Int32Value());
    return info.This();
  }

  Napi::Value GetResult(const Napi::CallbackInfo& info) {
    return Napi::Number::New(info.Env(), calculator_.GetResult());
  }

  Napi::Value Clear(const Napi::CallbackInfo& info) {
    calculator_.Clear();
    return info.This();
  }

 private:
  Calculator calculator_;
};

void RegisterCalculator(Napi::Env env, Napi::Object exports) {
  exports.Set("Calculator", CalculatorNode::Init(env, exports));
}

}  // namespace node
}  // namespace examples

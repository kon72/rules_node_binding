#include "calculator/calculator_node.h"
#include "napi.h"

namespace calculator {
namespace node {

Napi::Object Init(Napi::Env env, Napi::Object exports) {
  RegisterCalculator(env, exports);
  return exports;
}

NODE_API_MODULE(addon, Init)

}  // namespace node
}  // namespace calculator

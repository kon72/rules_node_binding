#ifndef EXAMPLES_CALCULATOR_CALCULATOR_NODE_H_
#define EXAMPLES_CALCULATOR_CALCULATOR_NODE_H_

#include "napi.h"

namespace examples {
namespace node {

void RegisterCalculator(Napi::Env env, Napi::Object exports);

}  // namespace node
}  // namespace examples

#endif  // EXAMPLES_CALCULATOR_CALCULATOR_NODE_H_

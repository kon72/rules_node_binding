#ifndef CALCULATOR_CALCULATOR_NODE_H_
#define CALCULATOR_CALCULATOR_NODE_H_

#include "napi.h"

namespace calculator {
namespace node {

void RegisterCalculator(Napi::Env env, Napi::Object exports);

}  // namespace node
}  // namespace calculator

#endif  // CALCULATOR_CALCULATOR_NODE_H_

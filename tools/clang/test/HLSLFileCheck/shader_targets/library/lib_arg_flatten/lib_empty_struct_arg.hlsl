// RUN: %dxc -T lib_6_3 -auto-binding-space 11 -default-linkage external %s | FileCheck %s

// Make sure calls with empty struct params are well-behaved

// CHECK: define float @"\01?test2@@YAMUT@@@Z"(%struct.T* %t)
// CHECK-NOT:alloca
// CHECK-NOT:memcpy
// CHECK: call float @"\01?test@@YAMUT@@@Z"(%struct.T* %t)
// CHECK: ret float

struct T {
};

float test(T t);

float test2(T t): SV_Target {
  return test(t);
}
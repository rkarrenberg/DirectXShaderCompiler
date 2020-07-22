// RUN: %dxc -T lib_6_6 %s  | FileCheck %s


// Make sure there's exactly two values live across the loop:
// the result and the loop induction var. Both are i32 so we can simply
// check against phi nodes of float type.
// CHECK: alloca
// CHECK-NOT: phi float
struct MyStruct {
  float  x;
  float2 y;
};

void producer(inout MyStruct s);

export
uint loop_scoped_pure_output_struct()
{
  uint res = 0.f;

  [loop]
  for (uint i = 0; i < 100; ++i) {
    MyStruct s;
    producer(s);
    res += s.x; // This isn't even necessary to produce the useless phi nodes.
  }

  return res;
}

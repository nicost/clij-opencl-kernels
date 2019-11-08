__constant sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;

__kernel void apply_threshold_3d(DTYPE_IMAGE_IN_3D  src,
                                 const    float      threshold,
                          DTYPE_IMAGE_OUT_3D  dst
                     )
{
  const int x = get_global_id(0);
  const int y = get_global_id(1);
  const int z = get_global_id(2);

  const int4 pos = (int4){x,y,z,0};

  DTYPE_IN inputValue = READ_IMAGE_3D(src, sampler, pos).x;
  DTYPE_OUT value = 1.0;
  if (inputValue < threshold) {
    value = 0.0;
  }

  WRITE_IMAGE_3D (dst, pos, value);
}
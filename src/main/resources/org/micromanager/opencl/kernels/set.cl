
__kernel void set_3d(DTYPE_IMAGE_OUT_3D  dst,
                  float value
                     )
{
  const int x = get_global_id(0);
  const int y = get_global_id(1);
  const int z = get_global_id(2);

  WRITE_IMAGE_3D (dst, (int4)(x,y,z,0), CONVERT_DTYPE_OUT(value));
}


__kernel void set_2d(DTYPE_IMAGE_OUT_2D  dst,
                  float value
                     )
{
  const int x = get_global_id(0);
  const int y = get_global_id(1);

  WRITE_IMAGE_2D (dst, (int2)(x,y), CONVERT_DTYPE_OUT(value));
}

__kernel void set_pixel_3d(DTYPE_IMAGE_OUT_3D  dst,
                  const int xp, 
                  const int yp, 
                  const int zp,
                  float value
                     )
{
  const int x = get_global_id(0);
  const int y = get_global_id(1);
  const int z = get_global_id(2);

  if (x == xp && y == yp && z == zp) {
     WRITE_IMAGE_3D (dst, (int4)(x,y,z,0), CONVERT_DTYPE_OUT(value));
  }
}


__kernel void set_pixel_2d(DTYPE_IMAGE_OUT_2D  dst,
                  const int xp,
                  const int yp,
                  float value
                     )
{
  const int x = get_global_id(0);
  const int y = get_global_id(1);

  if (x == xp && y == yp) {
     WRITE_IMAGE_2D (dst, (int2)(x,y), CONVERT_DTYPE_OUT(value));
  }
}

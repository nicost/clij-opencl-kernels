__constant sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;


__kernel void reduce_minmax_1d( DTYPE_IMAGE_IN_2D src, DTYPE_IMAGE_OUT_2D dst)
{
  const int width = GET_IMAGE_WIDTH(src);

  const int x = get_global_id(0);
  const int stridex = get_global_size(0);
  
  float minv = INFINITY;
  float maxv = -INFINITY;
  
  for(int lx=x; lx<width; lx+=stridex)
  {
    const int2 pos = lx;
    const DTYPE_IN value = READ_IMAGE_2D(src, sampler, pos).x;
  
    minv = fmin(minv, value);
    maxv = fmax(maxv, value);
  }

  WRITE_IMAGE_2D (dst, (int2)(2* x + 0, 0), CONVERT_DTYPE_OUT(minv));
  WRITE_IMAGE_2D (dst, (int2)(2* x + 1, 0), CONVERT_DTYPE_OUT(maxv));
}


__kernel void reduce_minmax_2d( DTYPE_IMAGE_IN_2D src, DTYPE_IMAGE_OUT_2D dst)
{
  const int width = GET_IMAGE_WIDTH(src);
  const int height = GET_IMAGE_HEIGHT(src);

  const int x = get_global_id(0);
  const int y = get_global_id(1);  
  const int stridex = get_global_size(0);
  const int stridey = get_global_size(1);
  
  float minv = INFINITY;
  float maxv = -INFINITY;
  
  for(int ly=y; ly<height; ly+=stridey)
  {
    for(int lx=x; lx<width; lx+=stridex)
    {
      const int2 pos = {lx,ly};
      const DTYPE_IN value = READ_IMAGE_2D(src, sampler, pos).x;
  
      minv = fmin(minv, value);
      maxv = fmax(maxv, value);
    }
  }

  WRITE_IMAGE_2D (dst, (int2)(2* x + 0, 0), CONVERT_DTYPE_OUT(minv));
  WRITE_IMAGE_2D (dst, (int2)(2* x + 1, 0), CONVERT_DTYPE_OUT(maxv));

}

__kernel void reduce_minmax_3d( DTYPE_IMAGE_IN_3D src, DTYPE_IMAGE_OUT_3D dst)
{
  const int width = GET_IMAGE_WIDTH(src);
  const int height = GET_IMAGE_HEIGHT(src);
  const int depth = GET_IMAGE_DEPTH(src);

  const int x = get_global_id(0);
  const int y = get_global_id(1);  
  const int z = get_global_id(2);
  const int stridex = get_global_size(0);
  const int stridey = get_global_size(1);
  const int stridez = get_global_size(2);
  
  float minv = INFINITY;
  float maxv = -INFINITY;
  
  for(int ly=y; ly<height; ly+=stridey)
  {
    for(int lx=x; lx<width; lx+=stridex)
    {
      for (int lz=z; lz<depth; lz+=stridez) {
        const int4 pos = (int4){lx,ly,lz,0};
        const DTYPE_IN value = READ_IMAGE_3D(src, sampler, pos).x;
  
        minv = fmin(minv, value);
        maxv = fmax(maxv, value);
      }
    }
  }

  WRITE_IMAGE_3D (dst, (int4)(2* x + 0, 0, 0, 0), CONVERT_DTYPE_OUT(minv));
  WRITE_IMAGE_3D (dst, (int4)(2* x + 1, 0, 0, 0), CONVERT_DTYPE_OUT(maxv));
}



OS=$1
ARCH=$2

git clone --recurse-submodules https://github.com/microsoft/DirectXShaderCompiler dxc

cd dxc
mkdir build
cd build

cmake \
  -S .. \
  -C ../cmake/caches/PredefinedParams.cmake \
  -D DCMAKE_BUILD_TYPE=Release \
#

  #-DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=ON \
  #-DLLVM_APPEND_VC_REV:BOOL=ON \
  #-DLLVM_DEFAULT_TARGET_TRIPLE:STRING=dxil-ms-dx \
  #-DLLVM_ENABLE_EH:BOOL=ON \
  #-DLLVM_ENABLE_RTTI:BOOL=ON \
  #-DLLVM_INCLUDE_DOCS:BOOL=OFF \
  #-DLLVM_INCLUDE_EXAMPLES:BOOL=OFF \
  #-DLLVM_INCLUDE_TESTS:BOOL=OFF \
  #-DLLVM_OPTIMIZED_TABLEGEN:BOOL=OFF \
  #-DLLVM_REQUIRES_EH:BOOL=ON \
  #-DLLVM_REQUIRES_RTTI:BOOL=ON \
  #-DLLVM_TARGETS_TO_BUILD:STRING=None \
  #-DLIBCLANG_BUILD_STATIC:BOOL=ON \
  #-DCLANG_BUILD_EXAMPLES:BOOL=OFF \
  #-DCLANG_CL:BOOL=OFF \
  #-DCLANG_ENABLE_ARCMT:BOOL=OFF \
  #-DCLANG_ENABLE_STATIC_ANALYZER:BOOL=OFF \
  #-DCLANG_INCLUDE_TESTS:BOOL=OFF \
  #-DHLSL_INCLUDE_TESTS:BOOL=ON \
  #-DENABLE_SPIRV_CODEGEN:BOOL=ON \
  #-DCMAKE_BUILD_TYPE=Release \
#

make

# Zip build output

cd ../..
mkdir dxc-$OS-$ARCH

echo "==============================================================="
echo "=============================================================== ls dxc/build/bin"
echo "==============================================================="

ls dxc/build/bin

echo "==============================================================="
echo "=============================================================== ls dxc/build/lib"
echo "==============================================================="

ls dxc/build/lib

echo "==============================================================="
echo "=============================================================== ls dxc/build/include"
echo "==============================================================="

ls dxc/build/include

echo "==============================================================="
echo "==============================================================="
echo "==============================================================="

echo $COMMIT > dxc-$OS-$ARCH/commit.txt
cp -R dxc/build/bin dxc-$OS-$ARCH/bin
cp -R dxc/build/include dxc-$OS-$ARCH/include
cp -R dxc/build/lib dxc-$OS-$ARCH/lib

rm -f dxc-$OS-$ARCH-$BUILD_DATE.zip
zip -9 -r dxc-$OS-$ARCH-$BUILD_DATE.zip dxc-$OS-$ARCH || echo "could not zip artifacts"
cp -f dxc-$OS-$ARCH-$BUILD_DATE.zip .. || echo "could not copy zip artifacts to root dir"

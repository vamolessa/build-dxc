OS=$1
ARCH=$2

git clone --recurse-submodules https://github.com/microsoft/DirectXShaderCompiler dxc
pushd dxc
mkdir build
pushd build

cmake -S .. -B . -C ../cmake/caches/PredefinedParams.cmake -D DCMAKE_BUILD_TYPE=Release
cmake --build . --config Release

popd
popd

mkdir dxc-$OS-$ARCH
mkdir dxc-$OS-$ARCH/bin
mkdir dxc-$OS-$ARCH/lib
mkdir dxc-$OS-$ARCH/include

echo $COMMIT > dxc-$OS-$ARCH/commit.txt

OUT_DIR=dxc/build
if [ "$OS" == "win" ]; then
  OUT_DIR="$OUT_DIR/Release"
fi

cp -f "$OUT_DIR/bin/dxc.exe"               dxc-$OS-$ARCH/bin
cp -f "$OUT_DIR/bin/dxc"                   dxc-$OS-$ARCH/bin

cp -f "$OUT_DIR/lib/dxcompiler.dll"        dxc-$OS-$ARCH/lib
cp -f "$OUT_DIR/lib/dxcompiler.lib"        dxc-$OS-$ARCH/lib
cp -f "$OUT_DIR/lib/libdxcompiler.dylib"   dxc-$OS-$ARCH/lib
cp -f "$OUT_DIR/lib/libdxcompiler.so"      dxc-$OS-$ARCH/lib
cp -f "$OUT_DIR/lib/libdxcompiler.a"       dxc-$OS-$ARCH/lib

cp -f "$OUT_DIR/lib/dxil.dll"              dxc-$OS-$ARCH/lib
cp -f "$OUT_DIR/lib/dxil.lib"              dxc-$OS-$ARCH/lib
cp -f "$OUT_DIR/lib/libdxil.dylib"         dxc-$OS-$ARCH/lib
cp -f "$OUT_DIR/lib/libdxil.so"            dxc-$OS-$ARCH/lib
cp -f "$OUT_DIR/lib/libdxil.a"             dxc-$OS-$ARCH/lib

cp -f "dxc/include/dxc/dxcapi.h"           dxc-$OS-$ARCH/include
cp -f "dxc/include/dxc/dxcerrors.h"        dxc-$OS-$ARCH/include
cp -f "dxc/include/dxc/dxcisense.h"        dxc-$OS-$ARCH/include

cp -f dxc/external/DirectX-Headers/include/directx/d3d12shader.h dxc-$OS-$ARCH/include
rm -f dxc-$OS-$ARCH-$BUILD_DATE.zip

if [ "$OS" == "win" ]; then
  7z a -y -mx=9 dxc-$OS-$ARCH-$BUILD_DATE.zip dxc-$OS-$ARCH
else
  zip -9 -r dxc-$OS-$ARCH-$BUILD_DATE.zip dxc-$OS-$ARCH
fi

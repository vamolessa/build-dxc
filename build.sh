OS=$1
ARCH=$2

git clone --recurse-submodules https://github.com/microsoft/DirectXShaderCompiler dxc
pushd dxc
mkdir build
pushd build

cmake -S .. -B . -C ../cmake/caches/PredefinedParams.cmake -D DCMAKE_BUILD_TYPE=Release
cmake --build .

popd
popd

mkdir dxc-$OS-$ARCH
mkdir dxc-$OS-$ARCH/bin
mkdir dxc-$OS-$ARCH/lib
mkdir dxc-$OS-$ARCH/include

echo $COMMIT > dxc-$OS-$ARCH/commit.txt

cp -f dxc/build/bin/dxc.exe               dxc-$OS-$ARCH/bin
cp -f dxc/build/bin/dxc                   dxc-$OS-$ARCH/bin

cp -f dxc/build/lib/dxcompiler.dll        dxc-$OS-$ARCH/lib
cp -f dxc/build/lib/dxcompiler.lib        dxc-$OS-$ARCH/lib
cp -f dxc/build/lib/libdxcompiler.dylib   dxc-$OS-$ARCH/lib
cp -f dxc/build/lib/libdxcompiler.so      dxc-$OS-$ARCH/lib
cp -f dxc/build/lib/libdxcompiler.a       dxc-$OS-$ARCH/lib

cp -f dxc/build/lib/dxil.dll              dxc-$OS-$ARCH/lib
cp -f dxc/build/lib/dxil.lib              dxc-$OS-$ARCH/lib
cp -f dxc/build/lib/libdxil.dylib         dxc-$OS-$ARCH/lib
cp -f dxc/build/lib/libdxil.so            dxc-$OS-$ARCH/lib
cp -f dxc/build/lib/libdxil.a             dxc-$OS-$ARCH/lib

cp -f dxc/include/dxc/dxcapi.h            dxc-$OS-$ARCH/include
cp -f dxc/include/dxc/dxcerrors.h         dxc-$OS-$ARCH/include
cp -f dxc/include/dxc/dxcisense.h         dxc-$OS-$ARCH/include

cp -f dxc/external/DirectX-Headers/include/directx/d3d12shader.h dxc-$OS-$ARCH/include

#rm -f dxc-$OS-$ARCH-$BUILD_DATE.zip
#zip -9 -r dxc-$OS-$ARCH-$BUILD_DATE.zip dxc-$OS-$ARCH || echo "could not zip artifacts"
7z a -y -mx=9 dxc-$OS-$ARCH-$BUILD_DATE.zip dxc-$OS-$ARCH

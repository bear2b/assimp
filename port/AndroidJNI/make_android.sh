#CMAKE_PATH="C:\Program Files\CMake\bin\cmake.exe"
ANDROID_NDK_PATH=~/ndk/android-ndk-r18b #/usr/local/Caskroom/android-ndk/18/android-ndk-18
ANDROID_CMAKE_PATH=${ANDROID_NDK_PATH}/build/cmake/android.toolchain.cmake  
#cmakeontrib\android-cmake

ANDROID_NDK=~/ndk/android-ndk-r18b #/usr/local/Caskroom/android-ndk/18/android-ndk-r18

#rmdir /s /q build
mkdir build
cd build


unset CFLAGS CPPFLAGS CXXFLAGS


CPP_STD_LIST=(c++11 c++14)
CPP_STD_LIB_LIST=(libc++ libstdc++)
CPP_STD=${CPP_STD_LIST[0]}

    export CFLAGS="-arch arm64-v8a -pipe -nostdinc++ -no-cpp-precomp -stdlib=$CPP_STD_LIB -Os"
    export CPPFLAGS=$CFLAGS
    export CXXFLAGS="$CFLAGS -std=$CPP_STD"

cmake -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK}/build/cmake/android.toolchain.cmake \
  -DANDROID_NATIVE_API_LEVEL=android-21 \
  -DASSIMP_BUILD_GLTF_IMPORTER=ON \
  -DASSIMP_BUILD_ASSIMP_TOOLS=OFF \
  -DANDROID_ABI=arm64-v8a \
  -DASSIMP_BUILD_TESTS=OFF \
  -DCMAKE_CXX_FLAGS_RELEASE=-g0 \
  -DASSIMP_NO_EXPORT=ON \
  -DCMAKE_BUILD_TYPE="release" \
  -G 'Unix Makefiles' \
  ../../..  

#  -DASSIMP_ANDROID_JNIIOSYSTEM=ON \

  make
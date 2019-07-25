ANDROID_NDK_PATH=~/ndk/android-ndk-r20 
ANDROID_CMAKE_PATH=${ANDROID_NDK_PATH}/build/cmake/android.toolchain.cmake  
#cmakeontrib\android-cmake

#rmdir /s /q build

function build_assimp {

mkdir build
cd build

  cmake -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_PATH}/build/cmake/android.toolchain.cmake \
    -DANDROID_NATIVE_API_LEVEL=${ANDROID_API} \
    -DASSIMP_BUILD_GLTF_IMPORTER=ON \
    -DASSIMP_BUILD_COLLADA_IMPORTER=ON \
    -DASSIMP_BUILD_OBJ_IMPORTER=ON \
    -DASSIMP_BUILD_FBX_IMPORTER=ON \
    -DASSIMP_BUILD_ASSIMP_TOOLS=OFF \
    -DANDROID_ABI=${ANDROID_ABI}\
    -DASSIMP_BUILD_TESTS=OFF \
    -DCMAKE_CXX_FLAGS_RELEASE=-g0 \
    -DASSIMP_NO_EXPORT=ON \
    -DCMAKE_BUILD_TYPE="release" \
    -G 'Unix Makefiles' \
    ../../..  
  
  #  -DASSIMP_ANDROID_JNIIOSYSTEM=ON \
  
    make -j8
    
    mkdir ../built_libs
    mkdir ../built_libs/${ANDROID_ABI}
    mv ./code/libassimp.so ../built_libs/${ANDROID_ABI}/libassimp.so

    cd ../
    rm -r ./build
}
######################################
unset CFLAGS CPPFLAGS CXXFLAGS
  
CPP_STD_LIST=(c++11 c++14)
CPP_STD_LIB_LIST=(libc++ libstdc++)
CPP_STD=${CPP_STD_LIST[0]}

export CFLAGS=" -pipe -nostdinc++ -no-cpp-precomp -stdlib=$CPP_STD_LIB -Os"
export CPPFLAGS=$CFLAGS
export CXXFLAGS="$CFLAGS -std=$CPP_STD"

ANDROID_API=android-21


######################################

ANDROID_ABI=armeabi-v7a
build_assimp

ANDROID_ABI=arm64-v8a
build_assimp
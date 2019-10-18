NDK=~/ndk/android-ndk-r20

ALL_ABIS=(arm64-v8a armeabi-v7a) 
LIB_NAME=libzip.a

function build_zip {
	cmake	-G"Unix Makefiles" \
			-DCMAKE_TOOLCHAIN_FILE=${NDK}/build/cmake/android.toolchain.cmake \
			-DANDROID_NDK=${NDK} \
	      	-DANDROID_NATIVE_API_LEVEL=21 \
	      	-DANDROID_ABI=${ANDROID_ABI} \
		    -DCMAKE_BUILD_TYPE="release" \
	     	..
	make
}

for ANDROID_ABI in ${ALL_ABIS[*]}; do

	mkdir build
	cd build
	mkdir ../libs

 	mkdir ../libs/${ANDROID_ABI}
  	echo "Building for ABI: $ANDROID_ABI" 
  	
  	build_zip $ANDROID_ABI
  	mv ./${LIB_NAME} ../libs/${ANDROID_ABI}

  	cd ..
  	rm -rf ./build

done
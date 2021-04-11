#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Generating ninja files DEBUG"

# Catalyst x64 + copy header + debug symbols on - DEBUG

gn gen out/catalyst_x64_debug --args='target_os="ios" target_cpu="x64" rtc_include_builtin_video_codecs=true rtc_include_tests=false rtc_build_examples=false rtc_build_tools=false ios_enable_code_signing=false ios_deployment_target="13.2" use_xcode_clang=true target_environment="catalyst" enable_dsyms=true rtc_libvpx_build_vp9=false rtc_build_libvpx=false rtc_enable_symbol_export=true is_component_build=false enable_stripping=true treat_warnings_as_errors=false is_debug=true' &

# Catalyst arm64 + copy header + debug symbols on - DEBUG

gn gen out/catalyst_arm64_debug --args='target_os="ios" target_cpu="arm64" rtc_include_builtin_video_codecs=true rtc_include_tests=false rtc_build_examples=false rtc_build_tools=false ios_enable_code_signing=false ios_deployment_target="13.2" use_xcode_clang=true target_environment="catalyst" enable_dsyms=true rtc_libvpx_build_vp9=false rtc_build_libvpx=false rtc_enable_symbol_export=true is_component_build=false enable_stripping=true treat_warnings_as_errors=false is_debug=true' &

# Simulator x64 + copy header + debug symbols on - DEBUG

gn gen out/simulator_x64_debug --args='target_os="ios" target_cpu="x64" rtc_include_builtin_video_codecs=true rtc_include_tests=false rtc_build_examples=false rtc_build_tools=false ios_enable_code_signing=false ios_deployment_target="12.0" use_xcode_clang=true target_environment="simulator" enable_dsyms=true rtc_libvpx_build_vp9=false rtc_build_libvpx=true rtc_enable_symbol_export=true is_component_build=false enable_stripping=true treat_warnings_as_errors=false is_debug=true' &

# Simulator arm64 + debug symbols on - DEBUG

gn gen out/simulator_arm64_debug --args='target_os="ios" target_cpu="arm64" rtc_include_builtin_video_codecs=true rtc_include_tests=false rtc_build_examples=false rtc_build_tools=false ios_enable_code_signing=false ios_deployment_target="12.0" use_xcode_clang=true target_environment="simulator" enable_dsyms=true rtc_libvpx_build_vp9=false rtc_build_libvpx=true rtc_enable_symbol_export=true is_component_build=false enable_stripping=true treat_warnings_as_errors=false is_debug=true' &

# Device arm64 + debug symbols on - DEBUG

gn gen out/device_arm64_debug --args='target_os="ios" target_cpu="arm64" rtc_include_builtin_video_codecs=true rtc_include_tests=false rtc_build_examples=false rtc_build_tools=false ios_enable_code_signing=false ios_deployment_target="12.0" use_xcode_clang=true enable_dsyms=true rtc_libvpx_build_vp9=false rtc_build_libvpx=true rtc_enable_symbol_export=true is_component_build=false enable_stripping=true treat_warnings_as_errors=false is_debug=true' &

wait

echo "Building DEBUG"

ninja -C out/catalyst_x64_debug framework_objc &
ninja -C out/catalyst_arm64_debug framework_objc &
ninja -C out/simulator_x64_debug framework_objc &
ninja -C out/simulator_arm64_debug framework_objc &
ninja -C out/device_arm64_debug framework_objc &

wait

echo "Generating ninja files PROD"

# Catalyst x64 + copy header + debug symbols on - PROD

gn gen out/catalyst_x64_prod --args='target_os="ios" target_cpu="x64" rtc_include_builtin_video_codecs=true rtc_include_tests=false rtc_build_examples=false rtc_build_tools=false ios_enable_code_signing=false ios_deployment_target="13.2" use_xcode_clang=true target_environment="catalyst" enable_dsyms=true rtc_libvpx_build_vp9=false rtc_build_libvpx=false rtc_enable_symbol_export=true is_component_build=false enable_stripping=true treat_warnings_as_errors=false is_debug=false' &

# Catalyst arm64 + copy header + debug symbols on - PROD

gn gen out/catalyst_arm64_prod --args='target_os="ios" target_cpu="arm64" rtc_include_builtin_video_codecs=true rtc_include_tests=false rtc_build_examples=false rtc_build_tools=false ios_enable_code_signing=false ios_deployment_target="13.2" use_xcode_clang=true target_environment="catalyst" enable_dsyms=true rtc_libvpx_build_vp9=false rtc_build_libvpx=false rtc_enable_symbol_export=true is_component_build=false enable_stripping=true treat_warnings_as_errors=false is_debug=false' &

# Simulator x64 + copy header + debug symbols on - PROD

gn gen out/simulator_x64_prod --args='target_os="ios" target_cpu="x64" rtc_include_builtin_video_codecs=true rtc_include_tests=false rtc_build_examples=false rtc_build_tools=false ios_enable_code_signing=false ios_deployment_target="12.0" use_xcode_clang=true target_environment="simulator" enable_dsyms=true rtc_libvpx_build_vp9=false rtc_build_libvpx=true rtc_enable_symbol_export=true is_component_build=false enable_stripping=true treat_warnings_as_errors=false is_debug=false' &

# Simulator arm64 + debug symbols on - PROD

gn gen out/simulator_arm64_prod --args='target_os="ios" target_cpu="arm64" rtc_include_builtin_video_codecs=true rtc_include_tests=false rtc_build_examples=false rtc_build_tools=false ios_enable_code_signing=false ios_deployment_target="12.0" use_xcode_clang=true target_environment="simulator" enable_dsyms=true rtc_libvpx_build_vp9=false rtc_build_libvpx=true rtc_enable_symbol_export=true is_component_build=false enable_stripping=true treat_warnings_as_errors=false is_debug=false' &

# Device arm64 + debug symbols on - PROD

gn gen out/device_arm64_prod --args='target_os="ios" target_cpu="arm64" rtc_include_builtin_video_codecs=true rtc_include_tests=false rtc_build_examples=false rtc_build_tools=false ios_enable_code_signing=false ios_deployment_target="12.0" use_xcode_clang=true enable_dsyms=true rtc_libvpx_build_vp9=false rtc_build_libvpx=true rtc_enable_symbol_export=true is_component_build=false enable_stripping=true treat_warnings_as_errors=false is_debug=false' &

wait

echo "Building PROD"

ninja -C out/catalyst_x64_prod framework_objc &
ninja -C out/catalyst_arm64_prod framework_objc &
ninja -C out/simulator_x64_prod framework_objc &
ninja -C out/simulator_arm64_prod framework_objc &
ninja -C out/device_arm64_prod framework_objc &

wait

# Merge PROD

echo "Merging platforms PROD"

# Catalyst
rm -rf $CURR_DIR/out/ios-arm64_x86_64-maccatalyst_prod
mkdir -p $CURR_DIR/out/ios-arm64_x86_64-maccatalyst_prod
cp -R $CURR_DIR/out/catalyst_x64_prod/WebRTC.framework $CURR_DIR/out/ios-arm64_x86_64-maccatalyst_prod/
cp -R $CURR_DIR/out/catalyst_x64_prod/WebRTC.dSYM $CURR_DIR/out/ios-arm64_x86_64-maccatalyst_prod/
rm -rf $CURR_DIR/out/ios-arm64_x86_64-maccatalyst_prod/WebRTC.framework/Versions/A/WebRTC
rm -rf $CURR_DIR/out/ios-arm64_x86_64-maccatalyst_prod/WebRTC.dSYM/Contents/Resources/DWARF/WebRTC
lipo -create $CURR_DIR/out/catalyst_arm64_prod/WebRTC.dSYM/Contents/Resources/DWARF/WebRTC $CURR_DIR/out/catalyst_x64_prod/WebRTC.dSYM/Contents/Resources/DWARF/WebRTC -output $CURR_DIR/out/ios-arm64_x86_64-maccatalyst_prod/WebRTC.dSYM/Contents/Resources/DWARF/WebRTC
lipo -create $CURR_DIR/out/catalyst_arm64_prod/WebRTC.framework/Versions/A/WebRTC $CURR_DIR/out/catalyst_x64_prod/WebRTC.framework/Versions/A/WebRTC -output $CURR_DIR/out/ios-arm64_x86_64-maccatalyst_prod/WebRTC.framework/Versions/A/WebRTC

# Simulator
rm -rf $CURR_DIR/out/ios-arm64_x86_64-simulator_prod
mkdir -p $CURR_DIR/out/ios-arm64_x86_64-simulator_prod
cp -R $CURR_DIR/out/simulator_x64_prod/WebRTC.framework $CURR_DIR/out/ios-arm64_x86_64-simulator_prod/
cp -R $CURR_DIR/out/simulator_x64_prod/WebRTC.dSYM $CURR_DIR/out/ios-arm64_x86_64-simulator_prod/
rm -rf $CURR_DIR/out/ios-arm64_x86_64-simulator_prod/WebRTC.framework/WebRTC
rm -rf $CURR_DIR/out/ios-arm64_x86_64-simulator_prod/WebRTC.dSYM/Contents/Resources/DWARF/WebRTC
lipo -create $CURR_DIR/out/simulator_arm64_prod/WebRTC.dSYM/Contents/Resources/DWARF/WebRTC $CURR_DIR/out/simulator_x64_prod/WebRTC.dSYM/Contents/Resources/DWARF/WebRTC -output $CURR_DIR/out/ios-arm64_x86_64-simulator_prod/WebRTC.dSYM/Contents/Resources/DWARF/WebRTC
lipo -create $CURR_DIR/out/simulator_arm64_prod/WebRTC.framework/WebRTC $CURR_DIR/out/simulator_x64_prod/WebRTC.framework/WebRTC -output $CURR_DIR/out/ios-arm64_x86_64-simulator_prod/WebRTC.framework/WebRTC

echo "Creating xcframework PROD"

# Create PROD xcframework
rm -rf $CURR_DIR/out/xc_prod
mkdir -p $CURR_DIR/out/xc_prod
xcodebuild -create-xcframework \
	-framework $CURR_DIR/out/device_arm64_prod/WebRTC.framework \
	-debug-symbols $CURR_DIR/out/device_arm64_prod/WebRTC.dSYM \
	-framework $CURR_DIR/out/ios-arm64_x86_64-maccatalyst_prod/WebRTC.framework \
	-debug-symbols $CURR_DIR/out/ios-arm64_x86_64-maccatalyst_prod/WebRTC.dSYM \
	-framework $CURR_DIR/out/ios-arm64_x86_64-simulator_prod/WebRTC.framework \
	-debug-symbols $CURR_DIR/out/ios-arm64_x86_64-simulator_prod/WebRTC.dSYM \
	-output $CURR_DIR/out/xc_prod/WebRTC.xcframework


# Merge DEBUG

echo "Merging platforms DEBUG"

# Catalyst
rm -rf $CURR_DIR/out/ios-arm64_x86_64-maccatalyst_debug
mkdir -p $CURR_DIR/out/ios-arm64_x86_64-maccatalyst_debug
cp -R $CURR_DIR/out/catalyst_x64_debug/WebRTC.framework $CURR_DIR/out/ios-arm64_x86_64-maccatalyst_debug/
cp -R $CURR_DIR/out/catalyst_x64_debug/WebRTC.dSYM $CURR_DIR/out/ios-arm64_x86_64-maccatalyst_debug/
rm -rf $CURR_DIR/out/ios-arm64_x86_64-maccatalyst_debug/WebRTC.framework/Versions/A/WebRTC
rm -rf $CURR_DIR/out/ios-arm64_x86_64-maccatalyst_debug/WebRTC.dSYM/Contents/Resources/DWARF/WebRTC
lipo -create $CURR_DIR/out/catalyst_arm64_debug/WebRTC.dSYM/Contents/Resources/DWARF/WebRTC $CURR_DIR/out/catalyst_x64_debug/WebRTC.dSYM/Contents/Resources/DWARF/WebRTC -output $CURR_DIR/out/ios-arm64_x86_64-maccatalyst_debug/WebRTC.dSYM/Contents/Resources/DWARF/WebRTC
lipo -create $CURR_DIR/out/catalyst_arm64_debug/WebRTC.framework/Versions/A/WebRTC $CURR_DIR/out/catalyst_x64_debug/WebRTC.framework/Versions/A/WebRTC -output $CURR_DIR/out/ios-arm64_x86_64-maccatalyst_debug/WebRTC.framework/Versions/A/WebRTC

# Simulator
rm -rf $CURR_DIR/out/ios-arm64_x86_64-simulator_debug
mkdir -p $CURR_DIR/out/ios-arm64_x86_64-simulator_debug
cp -R $CURR_DIR/out/simulator_x64_debug/WebRTC.framework $CURR_DIR/out/ios-arm64_x86_64-simulator_debug/
cp -R $CURR_DIR/out/simulator_x64_debug/WebRTC.dSYM $CURR_DIR/out/ios-arm64_x86_64-simulator_debug/
rm -rf $CURR_DIR/out/ios-arm64_x86_64-simulator_debug/WebRTC.framework/WebRTC
rm -rf $CURR_DIR/out/ios-arm64_x86_64-simulator_debug/WebRTC.dSYM/Contents/Resources/DWARF/WebRTC
lipo -create $CURR_DIR/out/simulator_arm64_debug/WebRTC.dSYM/Contents/Resources/DWARF/WebRTC $CURR_DIR/out/simulator_x64_debug/WebRTC.dSYM/Contents/Resources/DWARF/WebRTC -output $CURR_DIR/out/ios-arm64_x86_64-simulator_debug/WebRTC.dSYM/Contents/Resources/DWARF/WebRTC
lipo -create $CURR_DIR/out/simulator_arm64_debug/WebRTC.framework/WebRTC $CURR_DIR/out/simulator_x64_debug/WebRTC.framework/WebRTC -output $CURR_DIR/out/ios-arm64_x86_64-simulator_debug/WebRTC.framework/WebRTC

echo "Creating xcframework DEBUG"

# Create DEBUG xcframework
rm -rf $CURR_DIR/out/xc_debug
mkdir -p $CURR_DIR/out/xc_debug
xcodebuild -create-xcframework \
	-framework $CURR_DIR/out/device_arm64_debug/WebRTC.framework \
	-debug-symbols $CURR_DIR/out/device_arm64_debug/WebRTC.dSYM \
	-framework $CURR_DIR/out/ios-arm64_x86_64-maccatalyst_debug/WebRTC.framework \
	-debug-symbols $CURR_DIR/out/ios-arm64_x86_64-maccatalyst_debug/WebRTC.dSYM \
	-framework $CURR_DIR/out/ios-arm64_x86_64-simulator_debug/WebRTC.framework \
	-debug-symbols $CURR_DIR/out/ios-arm64_x86_64-simulator_debug/WebRTC.dSYM \
	-output $CURR_DIR/out/xc_debug/WebRTC.xcframework

@echo on

:: set cflags because NDEBUG is set in Release configuration, which errors out in test suite due to no assert
cmake -G "NMake Makefiles" ^
      -D CMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -D CMAKE_C_FLAGS_RELEASE="%CFLAGS%" ^
      -D CMAKE_CXX_FLAGS_RELEASE="%CXXFLAGS%" ^
      -D CMAKE_BUILD_TYPE=Release
      %CMAKE_ARGS% %SRC_DIR%

:: Build.
cmake --build . --config Release
if errorlevel 1 exit 1

:: Test.
if NOT "%CONDA_BUILD_CROSS_COMPILATION%" == "1" (
  ctest -C Release
  if errorlevel 1 exit 1
)

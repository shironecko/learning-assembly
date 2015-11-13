@echo off
setlocal
if not exist ..\build mkdir ..\build
pushd ..\build

if defined VS140COMNTOOLS         ( set VSTOOLS=VS140COMNTOOLS
) else if defined VS120COMNTOOLS  ( set VSTOOLS=VS120COMNTOOLS
) else if defined VS110COMNTOOLS  ( set VSTOOLS=VS110COMNTOOLS
) else if defined VS100COMNTOOLS  ( set VSTOOLS=VS100COMNTOOLS
) else if defined VS90COMNTOOLS   ( set VSTOOLS=VS90COMNTOOLS
) else echo "Visual Studio installation is not found!" && exit /b 1

call "%%%VSTOOLS%%%vsvars32.bat"
call "%%%VSTOOLS%%%..\..\VC\bin\ml" ^
  /nologo /safeseh /Febuild.exe /Sa /Flbuild.masm /W3 /Zi ..\source\main.masm ^
  /link /nologo /subsystem:console kernel32.lib

popd
endlocal

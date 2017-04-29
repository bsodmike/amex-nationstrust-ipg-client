@echo off
set TMP_CLASSPATH=%CLASSPATH%

for %%i in (%0) do cd /d %%~dpi\.


set CLASSPATH=%CLASSPATH%;..\pcml
rem Add all jars....
for %%i in (".\jars\*.jar") do call ".\cpappend.bat" %%i

set IPGCLIENT2_CLASSPATH=%CLASSPATH%
set CLASSPATH=%TMP_CLASSPATH%

@echo off
java -cp "%IPGCLIENT2_CLASSPATH%" com.interblocks.ipay.client2.PHPService %*

rem exit
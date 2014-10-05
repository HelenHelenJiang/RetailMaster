IF NOT DEFINED JAVA_HOME (
	ECHO NDK_FOLDER not set. Point it to the Android JDK. This path cannot have any spaces!!!!
	EXIT /B 1
)

IF NOT DEFINED ANDROID_DIR (
	ECHO NDK_FOLDER not set. Point it to the android SDK
	EXIT /B 1
)

IF NOT DEFINED ANT_DIR (
	ECHO NDK_FOLDER not set. Point it to the apache ant bin folder
	EXIT /B 1
)


xcopy /s /y ..\..\NCL\Android\libs libs\
call %ANDROID_DIR%\tools\android update project -p . --target "android-19"
%ANT_DIR%\ant release
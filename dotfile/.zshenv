typeset -U path

export WORKING_DIR="$HOME/Documents"

path=($HOME/bin(N-/) /usr/local/sbin(N-/) /usr/local/bin(N-/) $path)
#path=(~/.local/bin $path[@])

## java ##
JAVA_ENV=java-10-openjdk

if [[ -d "/usr/lib/jvm/$JAVA_ENV" ]]; then
    export JAVA_HOME="/usr/lib/jvm/$JAVA_ENV"
fi

path=(${JAVA_HOME:+${JAVA_HOME}/bin}(N-/) $path)

## Android SDK ##
if [[ -d "${WORKING_DIR}/Android/Sdk" ]]; then
    export ANDROID_HOME=${WORKING_DIR}/Android/Sdk
fi
if [[ -n "$ANDROID_HOME" && -d "$ANDROID_HOME" ]]; then
    path=($path ${ANDROID_HOME}/tools(N-/) ${ANDROID_HOME}/platform-tools(N-/) ${ANDROID_HOME}/build-tools/android-4.4(N-/))
fi
if [[ -n "$ANDROID_HOME" && -d "$ANDROID_HOME" ]]; then
    path=(${ANDROID_HOME}/tools/ ${ANDROID_HOME}/tools/bin $path)
fi

## GOLANG ##
path=($WORKING_DIR/go/bin $path)

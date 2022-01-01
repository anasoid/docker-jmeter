#!/bin/bash
set -e

TARGET=$DEPENCENCIES_TMP_PATH

POSITIONAL=()
mondatory=0
while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
    -f)
        let "mondatory += 1"
        FILE="$2"
        if [[ $FILE == "" ]]; then
            echo "Missing file pom value"
            echo "  -h            -> display help"
            exit 1
        fi
        shift # past argument
        shift # past value
        ;;

    -t)
        TARGET="$2"

        shift # past value
        shift # past value
        ;;

    -h)
        echo "HELP : -f file [-s setting-file] [-t output-folder]"
        echo "  -f -> Choose pom format file (mondatory)"
        echo "  -t -> Output folder, default '$DEPENCENCIES_TMP_PATH'"
        exit 0
        ;;
    *)                     # unknown option
        POSITIONAL+=("$1") # save it in an array for later
        echo "UNKNOWN OPTIION $1"
        echo "  -h            -> display help"
        exit 1

        ;;
    esac
done
echo "mondatory"
if [ $mondatory != '1' ]; then
    echo "Missing mandatory parameter"
    echo "  -h            -> display help"
    exit 1
fi

echo $MVN_OPTION
echo $FILE

#SETTINGS
if [ -f "$PROJECT_MAVEN_SETTINGS" ]; then
    SETTNGS_PARAM="-s $PROJECT_MAVEN_SETTINGS"
elif [ -f "$USER_MAVEN_SETTINGS" ]; then
    SETTNGS_PARAM="-s $USER_MAVEN_SETTINGS"
fi

#FILE
FILE_PARAM=$FILE
if [ -f "$USER_DEPENCENCIES_PATH/$FILE" ]; then
    FILE_PARAM="$USER_DEPENCENCIES_PATH/$FILE"
elif [ -f "$DEPENCENCIES_PATH/$FILE" ]; then
    FILE_PARAM="$DEPENCENCIES_PATH/$FILE"
fi

echo mvn -Dmaven.main.skip=true -f $FILE_PARAM dependency:copy-dependencies $SETTNGS_PARAM -DoutputDirectory=$TARGET $MVN_OPTION
mvn -Dmaven.main.skip=true -f $FILE_PARAM dependency:copy-dependencies $SETTNGS_PARAM -DoutputDirectory=$TARGET $MVN_OPTION

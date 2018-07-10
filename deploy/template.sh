#!/bin/bash
set -u

# all variables
SUB_VARS='$PROJECT_ID:$COMMIT_SHA:$CONNECTION_NAME:$EMAIL'

# optional variables default
export EMAIL=${EMAIL:-"example@example.com"}

# check required variables
for i in $(echo $SUB_VARS | tr ":" "\n")
do
  varname=${i:1}
  if [ -z "${!varname-}" ]; then
    echo "error: must provide variable \$$varname"
    exit 1
  fi
done

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
for f in $(find $DIR/templates -type f | sort)
do
  [[ $f =~ $DIR\/templates(.*) ]] && export OUTPUT_FILE="$DIR${BASH_REMATCH[1]}"
  mkdir -p $(dirname $OUTPUT_FILE)
  envsubst $SUB_VARS <$f >$OUTPUT_FILE
done
echo "files created!"

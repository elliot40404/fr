#!/usr/bin/env bash

## CREATE TEST ENVIRONMENT

mkdir -p test/test{1..2}/test

## BASE TEST

touch test/file{1..2}.txt
touch test/test{1..2}/test/file.txt
FILES=$(find test -type f -name "*.txt" | tr '\n' ' ')
CMD="echo \"foo\" | tee $FILES"
eval $CMD

sudo fr test foo bar

CHECK=$(cat test/file{1..2}.txt | uniq)
if [ "$CHECK" != "bar" ]; then
    echo "BASE Integration test failed"
    exit 1
fi

## DEEP ARGUMENT TEST

eval $CMD

sudo fr test foo bar -d

CHECK=$(find . -type f -name "*.txt" -exec cat {} \; | uniq)
if [ "$CHECK" != "bar" ]; then
    echo "DEEP Integration test failed"
    exit 1
fi

eval $CMD

sudo fr test foo bar --deep

CHECK=$(find . -type f -name "*.txt" -exec cat {} \; | uniq)
if [ "$CHECK" != "bar" ]; then
    echo "DEEP Integration test failed"
    exit 1
fi

## EXTENSION ARGUMENT TEST

eval $CMD
touch test/index.js
touch test/test{1..2}/test/index.js
EFILES=$(find test -type f -name "*.js" | tr '\n' ' ')
ECMD="echo \"foo\" | tee $EFILES"
eval $ECMD

sudo fr test foo bar -e js

CHECK=$(cat test/file{1..2}.txt | uniq)
ECHECK=$(cat test/index.js)
if [[ "$CHECK" == "bar" || "$ECHECK" != "bar" ]]; then
    echo "EXTENSION Integration test failed"
    exit 1
fi

eval $CMD
eval $ECMD

sudo fr test foo bar --extension js

CHECK=$(cat test/file{1..2}.txt | uniq)
ECHECK=$(cat test/index.js)
if [[ "$CHECK" == "bar" || "$ECHECK" != "bar" ]]; then
    echo "EXTENSION Integration test failed"
    exit 1
fi

## FULL ARGUMENT TEST

eval $CMD
eval $ECMD

sudo fr test foo bar --extension js --deep

CHECK=$(find . -type f -name "*.txt" -exec cat {} \; | uniq)
ECHECK=$(find . -type f -name "*.js" -exec cat {} \; | uniq)
if [[ "$CHECK" == "bar" || "$ECHECK" != "bar" ]]; then
    echo "FULL Integration test failed"
    exit 1
fi

eval $CMD
eval $ECMD

sudo fr test foo bar -e js -d

CHECK=$(find . -type f -name "*.txt" -exec cat {} \; | uniq)
ECHECK=$(find . -type f -name "*.js" -exec cat {} \; | uniq)
if [[ "$CHECK" == "bar" || "$ECHECK" != "bar" ]]; then
    echo "FULL Integration test failed"
    exit 1
fi

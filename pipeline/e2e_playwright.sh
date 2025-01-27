#!/usr/bin/env bash

set -e

SHARD_INDEX=$1
SHARD_TOTAL=$2
ATTEMPT=${3:-1}
FAILED_TESTS_FLAG=""



if [ -f "./test-results/.last-run.json" ] && [ "$ATTEMPT" -gt 1 ]; then
  echo "Detected failed tests from previous attempt. Running only failed specs."
  FAILED_TESTS_FLAG="--last-failed --pass-with-no-tests"
fi

if [ -n "$FAILED_TESTS_FLAG" ]; then
  echo "Running without shard due to failed tests"
  npx playwright test --project=chromium --quiet $FAILED_TESTS_FLAG
else
  npx playwright test --project=chromium --quiet --shard=$SHARD_INDEX/$SHARD_TOTAL
fi

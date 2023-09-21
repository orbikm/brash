#!/bin/bash

source "$(dirname ${BASH_SOURCE[@]})/../brash.sh"

function test_array_foreach()
{
  echo "Starting test_array_foreach"
  local test=()

  brash::array::append test "foo"
  brash::array::append test "bar"
  brash::array::append test "baz"


  function echo_each()
  {
    local element=$1
    echo "  - Element: ${element}"
  }
  brash::array::foreach echo_each $test

  echo "Contains? $(brash::array::contains "test" "foo")"
}

test_array_foreach --foo=fooval -bar=barval

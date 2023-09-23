#!/bin/bash

source "$(dirname ${BASH_SOURCE[@]})/../brash.sh"

function test_array_foreach()
{
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

  brash::array::contains "test" "foo"
  local contains=$?
  echo "Contains? $contains"
  brash::test::assert_eq $contains 1
}

brash::test::begin "Array::Foreach" test_array_foreach --foo=fooval -bar=barval

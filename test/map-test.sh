#!/bin/bash

source "$(dirname ${BASH_SOURCE[@]})/../brash.sh"

function test_maps()
{
  brash::map::declare "test"
  brash::map::set "test" "FOO" "FOOVAL"

  brash::test::assert_eq $(brash::map::get "test" "FOO") "FOOVAL"
  brash::test::assert_eq $(brash::map::get "test" "BAR") ""
  brash::test::assert_eq $(brash::map::get_or "test" "BAR" "NOBAR") "NOBAR"
}

brash::test::begin "Test::Maps" test_maps

#!/bin/bash

source "$(dirname ${BASH_SOURCE[@]})/../brash.sh"

function test_maps()
{
  brash::map::declare "test"
  brash::map::set "test" "FOO" "FOOVAL"

  echo "Valid Key (FOO): $(brash::map::get "test" "FOO")"
  # brash::test::assert_eq $(brash::map::get "test" "FOO") "FOOVAL"
  echo "Missing Key (BAR): $(brash::map::get "test" "BAR")"
  # brash::test::assert_eq $(brash::map::get "test" "BAR") ""
  echo "Missing Key (BAR) or (NOBAR): $(brash::map::get_or "test" "BAR" "NOBAR")"
  # brash::test::assert_eq $(brash::map::get_or "test" "BAR") NOBAR
}

test_maps

#begin_test "Test Read" test_maps
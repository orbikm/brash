#!/bin/bash

source "$(dirname ${BASH_SOURCE[@]})/../brash.sh"
#set -x

function test_simple_function_args()
{
  echo "Starting test_simple_function_args"

  brash::args::declare "foo"
  brash::args::set_short "foo" "-f"
  brash::args::set_long "foo" "--foo"
  brash::args::set_desc "foo" "Specifies the fooiness of the function"
  brash::args::set_required "foo"

  brash::args::declare "bar"
  brash::args::set_short "bar" "-b"
  brash::args::set_long "bar" "-bar"
  brash::args::set_desc "bar" "Specifies the barriness (not to be confused with berriness)"

  brash::args::parse $@

  brash::test::assert_eq $(brash::args::get "foo") "fooval"
  brash::test::assert_eq $(brash::args::get "bar") "barval"
}

brash::test::begin "Simple Function Full Args" test_simple_function_args --foo=fooval -bar=barval
brash::test::begin "Simple Function Short Args" test_simple_function_args -f=fooval -b=barval


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

  brash::log "Foo: $(brash::args::get "foo")"
  brash::log "Bar: $(brash::args::get "bar")"
}

test_simple_function_args --foo=fooval -bar=barval
test_simple_function_args -f=short_Foo -b=short_bar

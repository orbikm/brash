#!/bin/bash

source "$(dirname ${BASH_SOURCE[@]})/../brash.sh"

function test_function()
{
  brash::args::add "foo" "Foo"
  echo "${BRASH_ARGS__test_function[@]}"
  brash::args::add "bar" "Bar"
  echo "${BRASH_ARGS__test_function[@]}"
  brash::args::parse $@
  #local args=brash::args::parse

  brash::log "Foo: $(brash::args::get "foo")"
  brash::log "Bar: $(brash::args::get "bar")"
}

test_function --foo=fooval -bar=barval
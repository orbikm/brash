# Brash

Brash is a collection of utilities intended to make bash scripting easier and more resilient. It is essentially a collection of useful functions with the goal of making the language a bit more ergonomic, and thus allowing for more robust logic.

Another goal of this library is to bring some of the useful features, such as associative arrays (brash::map) to earlier versions of Bash, such as 3.2, which is still the default version available on MacOS. It accomplishes this in a way that doesn't seek to establish API compatibility, or even be the cleanest / most efficient implementation. It is simply meant to bring developers the functionality of something _like_ an associative array to the older versions of Bash where we operate.

# Libraries

## Args
brash::args is meant to be a collection of functions that make it easy / trivial to add parameters to scripts and/or functions. This is done by _describing_ the parameters that you accept, and then attempting to parse them at runtime.

The goal is to also have the library enforce proper passing of required arguments easily and integrated within the parsing.

Example usage can be found in `test/args-test.sh`

## Array
brash::array contains a collection of functions useful for navigating array handling. Simple things like appending to an array, getting an item of the array at a particular index, etc.

## Map
Associative arrays for versions of bash that do not support them.

Example usage can be found in `test/map-test.sh`
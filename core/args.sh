# TODO: Add support for `--foo value` in addition to `--foo=value` (style)
# TODO: Add error checking

function brash::args::declare()
{
  local caller=${FUNCNAME[1]}
  local name=$1
  local args_arr_name="BRASH_ARGS__${caller}"
  brash::array::append $args_arr_name $name
  brash::map::declare "${args_arr_name}__${name}"
}

# Data structure will be like:
# BRASH_ARGS__function_name
#   - foo
#   - bar
#   - baz
#
# BRASH_ARGS__function_name_foo
#   - "short": '-f'
#   - "long": '--foo'
#   - "desc": "Specifies the fooiness of the function"
#   - "optional": 0
#
# BRASH_ARGS__function_name_bar
#


function brash::args::set_short()
{
  local caller=${FUNCNAME[1]}
  local name=$1
  local flag=$2
  local args_details_map="BRASH_ARGS__${caller}__${name}"


  # For now, assume the argument is declared, add error checking
  # later
  # if [[ !brash::array::contains $name ]]; then

  brash::map::set "${args_details_map}" "SHORT" "$flag"
}

function brash::args::set_long()
{
  local caller=${FUNCNAME[1]}
  local name=$1
  local flag=$2
  local args_details_map="BRASH_ARGS__${caller}__${name}"

  brash::map::set "${args_details_map}" "LONG" "$flag"
}

function brash::args::set_desc()
{
  local caller=${FUNCNAME[1]}
  local name=$1
  local desc=$2
  local args_details_map="BRASH_ARGS__${caller}__${name}"

  brash::map::set "${args_details_map}" "DESC" "$flag"
}

function brash::args::set_required()
{
  local caller=${FUNCNAME[1]}
  local name=$1
  local args_details_map="BRASH_ARGS__${caller}__${name}"
  # TODO: Implement
}

function brash::args::usage()
{
  local args_arr_name="BRASH_ARGS__${caller}"
  local local_arr=(${!args_arr_name})
  function print_flag()
  {
    local arg_name=$1
    echo "Argument: ${arg_name}"
  }
  brash::array::foreach print_flag ${!args_arr_name}
}

function brash::args::parse()
{
  local caller=${FUNCNAME[1]}
  local args_names_ref="BRASH_ARGS__${caller}"

  function parse_flag()
  {
    local elem=$1
    local IFS_BAK=$IFS
    IFS='=' read -r key_full value <<< "${elem}"
    hyphens=${key_full%%[!-]*}
    key=${key_full#$hyphens}

    echo "Parsed $key: $value"
    local caller=${FUNCNAME[3]}
    local args_names_ref="BRASH_ARGS__${caller}"
    local local_arr=(${!args_names_ref})

    function set_value()
    {
      local arg_name=$1
      local value=$2
      local args_details_map="BRASH_ARGS__${caller}__${arg_name}"
      #echo "Calling brash::map::set ${args_details_map} 'VALUE' ${value}"
      brash::map::set "${args_details_map}" "VALUE" "${value}"
    }

    local found=0
    for arg_name in ${!args_names_ref}; do
      local arg_details_ref="BRASH_ARGS__${caller}__${arg_name}"
      short=$(brash::map::get "${arg_details_ref}" "SHORT")
      long=$(brash::map::get "${arg_details_ref}" "LONG")
      #echo "${key_full} == ${short} ? || ${key_full} == ${long} ?"
      if [[ "${key_full}" == "${short}" ]] || [[ "${key_full}" == "${long}" ]]; then
        #echo "Setting value"
        set_value "${arg_name}" "${value}"
        found=1
      fi
    done

    if [ $found = 0 ]; then
       echo "Encountered unknown flag: ${key_full}"
    fi
  }
  brash::array::foreach parse_flag $@
}

function brash::args::get()
{
  local caller=${FUNCNAME[1]}
  local name=$1

  local args_names_ref="BRASH_ARGS__${caller}"
  local args_details_map="BRASH_ARGS__${caller}__${name}"

  brash::map::has ${args_details_map} 'VALUE'
  if [ $? = 1 ]; then
    echo "$(brash::map::get ${args_details_map} 'VALUE')"
  fi
}
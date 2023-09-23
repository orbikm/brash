function brash::log()
{
  echo -e "${@}"
}

function brash::loge()
{
  >&2 echo -e "${@}"
}

function brash::print_stack () {
  local start_idx=$1
  echo "Stacktrace:"
   STACK=""
   local i message="${2:-""}"
   local stack_size=${#FUNCNAME[@]}
   # to avoid noise we start with 1 to skip the get_stack function
   for (( i=$((1 + start_idx)); i<$stack_size; i++ )); do
      local func="${FUNCNAME[$i]}"
      [ x$func = x ] && func=MAIN
      local linen="${BASH_LINENO[$(( i - 1 ))]}"
      local src="${BASH_SOURCE[$i]}"
      [ x"$src" = x ] && src=non_file_source
      STACK+="   at: $func $src $linen\n"
   done
   echo -e "${message}${STACK}"
}
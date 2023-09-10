function brash::args::add()
{
  local caller=${FUNCNAME[1]}
  local ref=$1
  local name=$2

  # Build the arg list for the function
  local args_arr_name="BRASH_ARGS__${caller}"
  local args_arr_val="BRASH_ARGS__${caller}__VALUE"
  local local_arr=(${!args_arr_name})
  if [ ${#local_arr[@]} -eq 0 ]; then
    export $args_arr_name
    export $args_arr_val
  fi

  brash::array::append $args_arr_name $ref
  brash::array::append $args_arr_val ""
}

function brash::args::add_optional()
{
  return
}

function brash::args::parse()
{
  local caller=${FUNCNAME[1]}
  local args_names_ref="BRASH_ARGS__${caller}"
  # TODO: Make this a dict
  local args_values_ref="BRASH_ARGS__${caller}__VALUES"
  for flag in $@;do
    local IFS_BAK=$IFS
    IFS='=' read -r key value <<< "${flag}"
    hyphens=${key%%[!-]*}
    key=${key#$hyphens}
    echo "Parsed $key: $value"
    # TODO: Wtf, what if args aren't passed in order???
    brash::array::append $args_values_ref $value
  done
}

function brash::args::get()
{
  local arg_name=$1
  local caller=${FUNCNAME[1]}
  local args_names_ref="BRASH_ARGS__${caller}"
  local args_values_ref="BRASH_ARGS__${caller}__VALUES"
  local local_names=(${!args_names_ref})
  local local_values=(${!args_values_ref})
  local ARG_IDX=-1
  for ((i=0; i<${#local_names[@]}; i++)); do
    if [ $arg_name == ${local_names[$i]} ]; then
      ARG_IDX=$i
      echo "Found $arg_name @ index $i"
      break
    fi
  done

  echo "ARG_IDX: $ARG_IDX"
  echo "len(local_values): ${#local_values[@]}"
  if [ $ARG_IDX -lt 0 ] || [ ${#local_values[@]} -le $ARG_IDX ]; then
    echo "FATAL: Arg $arg_name not found."
    exit 1
  fi

  echo "Value of $arg_name is: ${local_values[$ARG_IDX]}"
}
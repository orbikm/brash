function brash::array::append()
{
  local ref=$1
  local local_arr=(${!ref})
  shift
  local elements=($@)
  local_arr+=(${elements[@]})
  read -d"\0" $ref <<< "${local_arr[@]}"
}

function brash::array::contains()
{
  local ref=$1
  local target=$2
  local local_arr=(${!ref})
  #echo "Searching '${ref}' (${local_arr[@]}) for $target"
  for elem in "${local_arr[@]}"; do
    if [[ "${elem}" == "${target}" ]]; then
      return 1
    fi
  done
  return 0
}

function brash::array::foreach()
{
  local func=$1
  shift
  local array=($@)
  for ((i=0; i<${#array[@]}; i++)); do
    $func ${array[$i]}
  done
}
